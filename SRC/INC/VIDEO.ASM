; -----------------------------------------------------------------------------
; XEOS - x86 Experimental Operating System
; 
; Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)
; All rights reserved
; 
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
; 
;  -   Redistributions of source code must retain the above copyright notice,
;      this list of conditions and the following disclaimer.
;  -   Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;  -   Neither the name of 'Jean-David Gadina' nor the names of its
;      contributors may be used to endorse or promote products derived from
;      this software without specific prior written permission.
; 
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
; POSSIBILITY OF SUCH DAMAGE.
; ------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; Defines, macros and procedures for the XEOS video services
; 
; Those procedures and macros are intended to be used only in 32 bits protected
; mode. In real mode, please use the macros and procedures from the
; 'BIOS-VIDEO.ASM' file.
;-------------------------------------------------------------------------------

%ifndef VIDEO_ASM
%define VIDEO_ASM

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "MACROS.ASM"       ; General macros

;-------------------------------------------------------------------------------
; Definitions
;-------------------------------------------------------------------------------

; Location of the video memory
%define $XEOS.video.memory                  0xB8000

; BIOS screen dimensions
%define $XEOS.video.screen.cols             80
%define $XEOS.video.screen.rows             25

; BIOS colors
%define $XEOS.video.colors.black            0x00
%define $XEOS.video.colors.blue             0x01
%define $XEOS.video.colors.green            0x02
%define $XEOS.video.colors.cyan             0x03
%define $XEOS.video.colors.red              0x04
%define $XEOS.video.colors.magenta          0x05
%define $XEOS.video.colors.brown            0x06
%define $XEOS.video.colors.lightGray        0x07
%define $XEOS.video.colors.darkGray         0x08
%define $XEOS.video.colors.lightBlue        0x09
%define $XEOS.video.colors.lightGreen       0x0A
%define $XEOS.video.colors.lightCyan        0x0B
%define $XEOS.video.colors.lightRed         0x0C
%define $XEOS.video.colors.lightMagenta     0x0D
%define $XEOS.video.colors.lightBrown       0x0E
%define $XEOS.video.colors.white            0x0F

;-------------------------------------------------------------------------------
; Sets EDI to the memory address for the current cursor position
; 
; THIS MACRO IS PRIVATE! DO NOT CALL IT FROM OUTSIDE THIS FILE AS IT
; MODIFIED THE EDI REGISTER!
; 
; Video memory is linear, so in order to write a character to a specific
; position, the following formula can be used:
;   
;   x + ( y * screen width )
; 
; Also note that a displayed character takes two bytes of memory. One for the
; character itself, an the other one for the display attributes (color, etc).
;-------------------------------------------------------------------------------
%macro @XEOS.video._private.currentPosition 0
    
    ; Pointer to the start of the video memory
    mov     edi,        $XEOS.video.memory
    
    ; Resets EAX
    xor     eax,        eax
    
    ; Two bytes per character displayed
    mov     ecx,        $XEOS.video.screen.cols * 2
    
    ; Current Y position
    mov     al,         BYTE [ XEOS.video.cursor.y ]
    
    ; Y poition multiplied by the screen width
    mul     ecx
    
    ; Saves the resulting value
    push    eax
    
    ; Current X position
    mov     al,         BYTE [ XEOS.video.cursor.x ]
    
    ; Again, two bytes per character displayed
    mov     cl,         2
    mul     cl
    
    ; Restores the value of the previous computation (Y * screen width)
    pop     ecx
    
    ; Adds X
    add	    eax,        ecx
    
    ; EDI is now a pointer to the video memory area corresponding to the
    ; current cursor position
    add     edi,        eax
    
%endmacro

;-------------------------------------------------------------------------------
; Computes the value of a BIOS screen color into a register
; 
; Parameter 1:  The register in which to place the color value
; Parameter 2:  The foreground color
; Parameter 3:  The background color
;-------------------------------------------------------------------------------
%macro @XEOS.video.createScreenColor 3
    
    ; Stores the background color
    mov     %1,         %3
    shl     %1,         4
    
    ; Stores the foreground color
    add     %1,         %2
    
%endmacro

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
%macro @XEOS.video.setBackgroundColor 1
    
    ; Saves AX as we are going to alter it
    push    ax
    
    ; Resets AX
    xor     ax,         ax
    
    ; Places the color in AL
    mov     al,         BYTE %1
    
    ; Background color is the 4 high bits
    shl     al,         4
    
    ; Clears the existing background color
    and     [ XEOS.video.attribute ],   BYTE 00001111b
    
    ; Sets the new background color
    or      [ XEOS.video.attribute ],   al
    
    ; Restores AX
    pop     ax
    
%endmacro

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
%macro @XEOS.video.setForegroundColor 1
    
    ; Saves AX as we are going to alter it
    push    ax
    
    ; Resets AX
    xor     ax,         ax
    
    ; Places the color in AL
    mov     al,         BYTE %1
    
    ; Foreground color is the 4 low bits
    and     al,         00001111b
    
    ; Clears the existing foreground color
    and     [ XEOS.video.attribute ],   BYTE 11110000b
    
    ; Sets the new foreground color
    or      [ XEOS.video.attribute ],   al
    
    ; Restores AX
    pop     ax
    
%endmacro

;-------------------------------------------------------------------------------
; Clears the screen using the current character attribute
;-------------------------------------------------------------------------------
XEOS.video.clear:
    
    @XEOS.reg.save
    
    ; Computes the number of characters to write to clear the screen
    mov     ax,         $XEOS.video.screen.rows
    mov     ecx,        $XEOS.video.screen.cols
    mul     ecx
    
    ; Stores the result in ECX, so we can loop
    mov     ecx,        eax
    
    ; Start of the video memory
    mov     edi,        $XEOS.video.memory
    
    ; Clears a character on the screen
    .clear:
        
        ; Space character (ASCII 32)
        mov     al,         BYTE 0x20
        
        ; Current character attribute
        mov     ah,         BYTE [ XEOS.video.attribute ]
        
        ; Clears the current character by writing a space
        mov     [ edi ],    WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 2
        
        ; Continues clearing till we reached the end of the screen
        loop    .clear
    
    ; Update the cursor position
    mov     [ XEOS.video.cursor.x ],    BYTE 0
    mov     [ XEOS.video.cursor.y ],    BYTE 0
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Scrolls the screen by one line
;-------------------------------------------------------------------------------
XEOS.video.scroll:
    
    @XEOS.reg.save
    
    ; Start of the video memory
    mov     edi,        $XEOS.video.memory
    
    ; Computes the number of characters that will need to be rewritten
    ; (we won't rewrite the last line, as it will be cleared)
    mov     eax,        $XEOS.video.screen.rows - 1
    mov     ecx,        $XEOS.video.screen.cols
    mul     ecx
    
    ; Stores the result in ECX, so we can loop
    mov     ecx,        eax
    
    ; Moves the characters one line up
    .scroll
        
        ; Writes the character on the next line (same X position) to the current
        ; position
        mov     ax,         WORD [ edi + ( $XEOS.video.screen.cols * 2 ) ]
        mov     [ edi ]     WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 2
        
        ; Continues moving character till we reached the last line
        loop    .scroll
    
    ; Now we have to clear the last line
    mov     ecx,        $XEOS.video.screen.cols
    
    ; Clears a character on the screen
    .clear:
        
        ; Space character (ASCII 32)
        mov     al,         0x20
        
        ; Current character attribute
        mov     ah,         BYTE [ XEOS.video.attribute ]
        
        ; Clears the current character by writing a space
        mov     [ edi ]     WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 2
        
        ; Continues clearing till we reached the end of the screen
        loop    .clear
        
    @XEOS.reg.restore
    
    ; Updates the cursor position, as we now have an available line
    dec     BYTE [ XEOS.video.cursor.y ]
    
    ret

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.video.print:
    
    @XEOS.reg.save
    
    ; Process a byte from the string
    .repeat:
        
        ; Checks if we have reached the maximum width
        cmp     [ XEOS.video.cursor.x ], BYTE $XEOS.video.screen.cols
        
        ; No - we can print a character
        jne     .colAvailable
        
        ; Increases the Y position and resets X
        inc     BYTE [ XEOS.video.cursor.y ]
        mov     [ XEOS.video.cursor.x ],    BYTE 0
        
        ; A free column is now available for display
        .colAvailable:
        
        ; Checks if we have reached the maximum height
        cmp     [ XEOS.video.cursor.y ], BYTE $XEOS.video.screen.rows
        
        ; No - We can print a character
        jne     .rowAvailable
        
        ; Scrolls the screen
        call    XEOS.video.scroll
        
        .rowAvailable:
        
        ; Gets the current cursor position
        @XEOS.video._private.currentPosition
        
        ; Current character attribute
        mov     ah,         [ XEOS.video.attribute ]
        
        ; Gets a byte from the string placed in SI (will be placed in AL)
        lodsb
        
        ; Checks for the end of the string (ASCII 0)
        cmp     al,         0
        je      .done
        
        cmp     al,         10
        je      .lineFeed
        
        cmp     al,         13
        je      .carriageReturn
        
        ; Prints the current character
        mov	    [ edi ],        WORD ax
        
        ; Moves the cursor
        inc BYTE [ XEOS.video.cursor.x ]
        
        ; Process the next byte from the string
        jmp     .repeat
        
    ; ASCII 10 - LF
    .lineFeed:
        
        ; Updates the cursor position
        inc BYTE [ XEOS.video.cursor.y ]
        jmp     .repeat
        
    ; ASCII 13 - CR
    .carriageReturn:
        
        ; Updates the cursor position
        mov     [ XEOS.video.cursor.x ], BYTE 0
        jmp     .repeat
    
    ; End of the string
    .done:
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

; Current position of the cursor
XEOS.video.cursor.x     db  0
XEOS.video.cursor.y     db  0

; Current character attribute (default is white on light blue)
XEOS.video.attribute    db  0x9F

%endif
