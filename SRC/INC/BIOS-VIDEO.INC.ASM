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
; Defines, macros and procedures for the BIOS video services
;-------------------------------------------------------------------------------

%ifndef BIOS_VIDEO_ASM
%define BIOS_VIDEO_ASM

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "MACROS.INC.ASM"       ; General macros
%include "BIOS-INT.INC.ASM"     ; BIOS interrupts

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Definitions
;-------------------------------------------------------------------------------

; BIOS screen dimensions
%define $BIOS.video.screen.cols             80
%define $BIOS.video.screen.rows             25

; BIOS colors
%define $BIOS.video.colors.black            0x00
%define $BIOS.video.colors.blue             0x01
%define $BIOS.video.colors.green            0x02
%define $BIOS.video.colors.cyan             0x03
%define $BIOS.video.colors.red              0x04
%define $BIOS.video.colors.magenta          0x05
%define $BIOS.video.colors.brown            0x06
%define $BIOS.video.colors.lightGray        0x07
%define $BIOS.video.colors.darkGray         0x08
%define $BIOS.video.colors.lightBlue        0x09
%define $BIOS.video.colors.lightGreen       0x0A
%define $BIOS.video.colors.lightCyan        0x0B
%define $BIOS.video.colors.lightRed         0x0C
%define $BIOS.video.colors.lightMagenta     0x0D
%define $BIOS.video.colors.lightBrown       0x0E
%define $BIOS.video.colors.white            0x0F

;-------------------------------------------------------------------------------
; Computes the value of a BIOS screen color into a register
; 
; Parameter 1:  The register in which to place the color value
; Parameter 2:  The foreground color
; Parameter 3:  The background color
;-------------------------------------------------------------------------------
%macro @BIOS.video.createScreenColor 3
    
    ; Stores the background color
    mov %1, %3
    shl %1, 4
    
    ; Stores the foreground color
    add %1, %2
    
%endmacro

;-------------------------------------------------------------------------------
; BIOS - Moves the cursor
; 
; Parameter 1:  The X position
; Parameter 2:  The Y position
;-------------------------------------------------------------------------------
%macro @BIOS.video.setCursor 2
    
    @XEOS.reg.save
    
    ; Position cursor (BIOS video services function)
    mov     ah,     2
    
    ; Page number
    mov     bh,     0
    
    ; XY coordinates
    mov     dh,     %1
    mov     dl,     %2
    
    ; Calls the BIOS video services
    $BIOS.int.video
    
    @XEOS.reg.restore
    
%endmacro

;-------------------------------------------------------------------------------
; BIOS - Clears the screen
; 
; Parameter 1:  The foreground color
; Parameter 2:  The background color
;-------------------------------------------------------------------------------
%macro @BIOS.video.clearScreen 2
    
    @XEOS.reg.save
    
    ; Clear or scroll up (BIOS video services function)
    mov     ah,     6
    
    ; Number of lines to scroll (0 means clear)
    mov     al,     0
    
    ; Sets the screen color
    @BIOS.video.createScreenColor bh, %1, %2
    
    ; XY coordinates
    mov     cx,     0
    
    ; Width and height
    mov     dl,     $BIOS.video.screen.cols - 1
    mov     dh,     $BIOS.video.screen.rows - 1
    
    ; Calls the BIOS video services
    $BIOS.int.video
    
    ; Repositions the cursor to the top-left corner
    @BIOS.video.setCursor 0, 0
    
    @XEOS.reg.restore
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a string
; 
; Parameter 1:  The address of the string to print
;-------------------------------------------------------------------------------
%macro @BIOS.video.print  1
    
    mov     si,     %1
    call    BIOS.video.print
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a string
; 
; Necessary register values:
;       
;       - si:       The address of the string to print
;-------------------------------------------------------------------------------
BIOS.video.print:
    
    ; Outputs a single character (BIOS video services function)
    mov     ah,         0x0E
    
    ; Process a byte from the string
    .repeat:
        
        ; Gets a byte from the string placed in SI (will be placed in AL)
        lodsb
        
        ; Checks for the end of the string (ASCII 0)
        cmp     al,         0
        
        ; End of the string detected
        je      .done
        
        ; Calls the BIOS video services
        $BIOS.int.video
        
        ; Process the next byte from the string
        jmp     .repeat
            
    ; End of the string
    .done:
        
        ret

%endif
