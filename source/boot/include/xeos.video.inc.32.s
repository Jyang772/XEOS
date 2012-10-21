;-------------------------------------------------------------------------------
; XEOS - X86 Experimental Operating System
; 
; Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
; All rights reserved.
; 
; XEOS Software License - Version 1.0 - December 21, 2012
; 
; Permission is hereby granted, free of charge, to any person or organisation
; obtaining a copy of the software and accompanying documentation covered by
; this license (the "Software") to deal in the Software, with or without
; modification, without restriction, including without limitation the rights
; to use, execute, display, copy, reproduce, transmit, publish, distribute,
; modify, merge, prepare derivative works of the Software, and to permit
; third-parties to whom the Software is furnished to do so, all subject to the
; following conditions:
; 
;       1.  Redistributions of source code, in whole or in part, must retain the
;           above copyright notice and this entire statement, including the
;           above license grant, this restriction and the following disclaimer.
; 
;       2.  Redistributions in binary form must reproduce the above copyright
;           notice and this entire statement, including the above license grant,
;           this restriction and the following disclaimer in the documentation
;           and/or other materials provided with the distribution, unless the
;           Software is distributed by the copyright owner as a library.
;           A "library" means a collection of software functions and/or data
;           prepared so as to be conveniently linked with application programs
;           (which use some of those functions and data) to form executables.
; 
;       3.  The Software, or any substancial portion of the Software shall not
;           be combined, included, derived, or linked (statically or
;           dynamically) with software or libraries licensed under the terms
;           of any GNU software license, including, but not limited to, the GNU
;           General Public License (GNU/GPL) or the GNU Lesser General Public
;           License (GNU/LGPL).
; 
;       4.  All advertising materials mentioning features or use of this
;           software must display an acknowledgement stating that the product
;           includes software developed by the copyright owner.
; 
;       5.  Neither the name of the copyright owner nor the names of its
;           contributors may be used to endorse or promote products derived from
;           this software without specific prior written permission.
; 
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
; THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
; PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
; 
; IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
; THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
; WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
; THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
; OF THE POSSIBILITY OF SUCH DAMAGE.
;-------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; Defines, macros and procedures for the XEOS video services
; 
; Those procedures and macros are intended to be used only in 32 bits protected
; mode. In real mode, please use the macros and procedures from the
; 'bios.video.inc.16.s' file.
;-------------------------------------------------------------------------------

%ifndef __XEOS_VIDEO_INC_32_ASM__
%define __XEOS_VIDEO_INC_32_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.macros.inc.s"          ; General macros
%include "xeos.crt.controller.inc.s"  ; CRT microcontroller

; We are in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Location of the video memory
%define @XEOS.video.memory                  0xB8000

; BIOS screen dimensions
%define @XEOS.video.screen.cols             80
%define @XEOS.video.screen.rows             25

; BIOS colors
%define @XEOS.video.color.black             0x00
%define @XEOS.video.color.blue              0x01
%define @XEOS.video.color.green             0x02
%define @XEOS.video.color.cyan              0x03
%define @XEOS.video.color.red               0x04
%define @XEOS.video.color.magenta           0x05
%define @XEOS.video.color.brown             0x06
%define @XEOS.video.color.gray.light        0x07
%define @XEOS.video.color.gray              0x08
%define @XEOS.video.color.blue.light        0x09
%define @XEOS.video.color.green.light       0x0A
%define @XEOS.video.color.cyan.light        0x0B
%define @XEOS.video.color.red.light         0x0C
%define @XEOS.video.color.magenta.light     0x0D
%define @XEOS.video.color.brown.light       0x0E
%define @XEOS.video.color.white             0x0F

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
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       - EDI
;-------------------------------------------------------------------------------
%macro @XEOS.video._currentPosition 0
    
    ; Saves registers
    push    eax
    push    ecx
    
    ; Pointer to the start of the video memory
    mov     edi,        @XEOS.video.memory
    
    ; Resets EAX
    xor     eax,        eax
    
    ; Two bytes per character displayed
    mov     ecx,        @XEOS.video.screen.cols * 2
    
    ; Current Y position
    mov     al,         BYTE [ $XEOS.video.cursor.y ]
    
    ; Y poition multiplied by the screen width
    mul     ecx
    
    ; Saves the resulting value
    push    eax
    
    ; Current X position
    mov     al,         BYTE [ $XEOS.video.cursor.x ]
    
    ; Again, two bytes per character displayed
    mov     cl,         0x02
    mul     cl
    
    ; Restores the value of the previous computation (Y * screen width)
    pop     ecx
    
    ; Adds X
    add	    eax,        ecx
    
    ; EDI is now a pointer to the video memory area corresponding to the
    ; current cursor position
    add     edi,        eax
    
    ; Restores registers
    pop     ecx
    pop     eax
    
%endmacro

;-------------------------------------------------------------------------------
; Computes the value of a BIOS screen color into a register
; 
; Parameters:
; 
;       1:          The register in which to place the color value
;       2:          The foreground color
;       3:          The background color
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.createScreenColor 3
    
    ; Stores the background color
    mov     %1,         %3
    shl     %1,         0x04
    
    ; Stores the foreground color
    add     %1,         %2
    
%endmacro

;-------------------------------------------------------------------------------
; Sets the background color attribute
; 
; Parameters:
; 
;       1:          The background color
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.setBackgroundColor 1
    
    ; Saves AX as we are going to alter it
    push    ax
    
    ; Resets AX
    xor     ax,         ax
    
    ; Places the color in AL
    mov     al,         BYTE %1
    
    ; Background color is the 4 high bits
    shl     al,         0x04
    
    ; Clears the existing background color
    and     [ $XEOS.video.attribute ],   BYTE 00001111b
    
    ; Sets the new background color
    or      [ $XEOS.video.attribute ],   al
    
    ; Restores AX
    pop     ax
    
%endmacro

;-------------------------------------------------------------------------------
; Sets the foreground color attribute
; 
; Parameters:
; 
;       1:          The foreground color
; 
; Killed registers:
;       
;       None
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
    and     [ $XEOS.video.attribute ],   BYTE 11110000b
    
    ; Sets the new foreground color
    or      [ $XEOS.video.attribute ],   al
    
    ; Restores AX
    pop     ax
    
%endmacro

;-------------------------------------------------------------------------------
; Clears the screen
; 
; Parameters:
; 
;       1:          The foreground color
;       2:          The background color
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.clear 2
    
    @XEOS.video.setForegroundColor %1
    @XEOS.video.setBackgroundColor %2
    
    call    XEOS.video.clear
    
%endmacro

;-------------------------------------------------------------------------------
; Moves the cursor
; 
; Parameters:
; 
;       1:          The X position
;       2:          The Y position
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.cursor.move 2
    
    ; Saves BX as we are going to alter it
    push    bx
    
    ; Stores the X and Y positions in BX
    mov     bh,         %1
    mov     bl,         %2
    
    ; Moves the cursor position
    call    XEOS.video.cursor.move
    
    ; Restores BX
    pop     bx
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a single character, without updating the cursor position
; 
; Parameters:
; 
;       1:          The character to print
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.putc 1
    
    ; Saves registers
    push    ax
    
    ; Prints the character
    mov     al,         %1
    call    XEOS.video.putc
    
    ; Restores registers
    pop     ax
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a string
; 
; Parameters:
; 
;       1:          The address of the string to print
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.video.print  1
    
    ; Saves registers
    push    esi
    
    ; Prints the string
    mov     esi,    %1
    call    XEOS.video.print
    
    ; Restores registers
    pop     esi
    
%endmacro

;-------------------------------------------------------------------------------
; Procedures
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Clears the screen using the current character attribute
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.clear:
    
    @XEOS.proc.start 0
    
    ; Computes the number of characters to write to clear the screen
    mov     ax,         @XEOS.video.screen.rows
    mov     ecx,        @XEOS.video.screen.cols
    mul     ecx
    
    ; Stores the result in ECX, so we can loop
    mov     ecx,        eax
    
    ; Start of the video memory
    mov     edi,        @XEOS.video.memory
    
    ; Clears a character on the screen
    .clear:
        
        ; Space character (ASCII 32)
        mov     al,         BYTE 0x20
        
        ; Current character attribute
        mov     ah,         BYTE [ $XEOS.video.attribute ]
        
        ; Clears the current character by writing a space
        mov     [ edi ],    WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 0x02
        
        ; Continues clearing till we reached the end of the screen
        loop    .clear
    
    ; Update the cursor position
    mov     [ $XEOS.video.cursor.x ],    BYTE 0x00
    mov     [ $XEOS.video.cursor.y ],    BYTE 0x00
    
    ; Updates the hardware cursor
    call    XEOS.video.cursor.update
    
    @XEOS.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Scrolls the screen by one line
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.scroll:
    
    @XEOS.proc.start 0
    
    ; Start of the video memory
    mov     edi,        @XEOS.video.memory
    
    ; Computes the number of characters that will need to be rewritten
    ; (we won't rewrite the last line, as it will be cleared)
    mov     eax,        @XEOS.video.screen.rows - 1
    mov     ecx,        @XEOS.video.screen.cols
    mul     ecx
    
    ; Stores the result in ECX, so we can loop
    mov     ecx,        eax
    
    ; Moves the characters one line up
    .scroll
        
        ; Writes the character on the next line (same X position) to the current
        ; position
        mov     ax,         WORD [ edi + ( @XEOS.video.screen.cols * 2 ) ]
        mov     [ edi ],    WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 0x02
        
        ; Continues moving character till we reached the last line
        loop    .scroll
    
    ; Now we have to clear the last line
    mov     ecx,        @XEOS.video.screen.cols
    
    ; Clears a character on the screen
    .clear:
        
        ; Space character (ASCII 32)
        mov     al,         0x20
        
        ; Current character attribute
        mov     ah,         BYTE [ $XEOS.video.attribute ]
        
        ; Clears the current character by writing a space
        mov     [ edi ],    WORD ax
        
        ; Next character can now be processed
        add     edi,        BYTE 0x02
        
        ; Continues clearing till we reached the end of the screen
        loop    .clear
    
    ; Updates the cursor position, as we now have an available line
    dec     BYTE [ $XEOS.video.cursor.y ]
    
    ; Updates the hardware cursor
    call    XEOS.video.cursor.update
    
    @XEOS.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Moves the cursor
; 
; Input registers:
;       
;       - BX:       The cursor position (BH for X, BL for Y)
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.cursor.move:
    
    @XEOS.proc.start 0
    
    ; Stores the new cursor position
    mov     [ $XEOS.video.cursor.x ],   bh
    mov     [ $XEOS.video.cursor.y ],   bl
    
    ; First, we need to compute the new cursor location:
    ; cursor location = x + ( y * screen width )
    .newPosition:
        
        ; Resets CX
        xor     eax,        eax
        
        ; Number of available columns
        mov     ecx,        @XEOS.video.screen.cols
        
        ; New Y posotion
        mov     al,         bl
        
        ; Multiplies Y by the number of columns
        mul     ecx
        
        ; Adds the X position
        add     al,         bh
        
        ; Stores the new cursor posotion in EBX
        mov     ebx,        eax
        
        ; Tells the CRT microcontroller we are going to change to high byte for
        ; the cursor location
        mov     al,         @XEOS.crt.controller.cursorLocationHigh
        mov     dx,         @XEOS.crt.controller.registers.data
        out     dx,         al
        
        ; Writes the new high byte value for the cursor location
        mov     al,         bh
        mov     dx,         @XEOS.crt.controller.registers.index
        out     dx,         al
        
        ; Tells the CRT microcontroller we are going to change to low byte for
        ; the cursor location
        mov     al,         @XEOS.crt.controller.cursorLocationLow
        mov     dx,         @XEOS.crt.controller.registers.data
        out     dx,         al
        
        ; Writes the new low byte value for the cursor location
        mov     al,         bl
        mov     dx,         @XEOS.crt.controller.registers.index
        out     dx,         al
    
    @XEOS.proc.end
    
    ret
    
;-------------------------------------------------------------------------------
; Updates the cursor position to the saved value
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.cursor.update:
    
    @XEOS.proc.start 0
    
    ; Current cursor position
    mov     bh,         [ $XEOS.video.cursor.x ]
    mov     bl,         [ $XEOS.video.cursor.y ]
    
    ; Moves the cursor to the current position
    call    XEOS.video.cursor.move
    
    @XEOS.proc.end
    
    ret
   
;-------------------------------------------------------------------------------
; Prints a single character, without updating the cursor position
; 
; Input registers:
; 
;       - AL:       The character to print
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.putc:
    
    @XEOS.proc.start 0
    
    ; Gets the current cursor position
    @XEOS.video._currentPosition
    
    ; Current character attribute
    mov     ah,         [ $XEOS.video.attribute ]
    
    ; Prints the character
    mov	    [ edi ],    WORD ax
    
    @XEOS.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Prints a string
; 
; Input registers:
;       
;       - ESI:      The address of the string to print
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.video.print:
    
    @XEOS.proc.start 0
    
    ; Process a byte from the string
    .repeat:
        
        ; Checks if we have reached the maximum width
        cmp     [ $XEOS.video.cursor.x ], BYTE @XEOS.video.screen.cols
        
        ; No - we can print a character
        jne     .colAvailable
        
        ; Increases the Y position and resets X
        inc     BYTE [ $XEOS.video.cursor.y ]
        mov     [ $XEOS.video.cursor.x ],    BYTE 0
        
    .colAvailable:
        
        ; Checks if we have reached the maximum height
        cmp     [ $XEOS.video.cursor.y ], BYTE @XEOS.video.screen.rows
        
        ; No - We can print a character
        jne     .rowAvailable
        
        ; Scrolls the screen
        call    XEOS.video.scroll
    
    .rowAvailable:
    
        ; Gets the current cursor position
        @XEOS.video._currentPosition
        
        ; Current character attribute
        mov     ah,         [ $XEOS.video.attribute ]
        
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
        inc BYTE [ $XEOS.video.cursor.x ]
        
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
        mov     [ $XEOS.video.cursor.x ], BYTE 0
        jmp     .repeat
    
    ; End of the string
    .done:
    
        ; Updates the hardware cursor
        call    XEOS.video.cursor.update
    
    @XEOS.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

; Current position of the cursor
$XEOS.video.cursor.x     db  0x00
$XEOS.video.cursor.y     db  0x00

; Current character attribute (default is white on black)
$XEOS.video.attribute    db  0x0F

%endif
