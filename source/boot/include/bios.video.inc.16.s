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
; Defines, macros and procedures for the BIOS video services
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------

%ifndef __BIOS_VIDEO_INC_16_ASM__
%define __BIOS_VIDEO_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.macros.inc.s"          ; General macros
%include "BIOS.int.inc.s"             ; BIOS interrupts

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Definitions
;-------------------------------------------------------------------------------

; BIOS screen dimensions
%define @BIOS.video.screen.cols             80
%define @BIOS.video.screen.rows             25

; BIOS colors
%define @BIOS.video.colors.black            0x00
%define @BIOS.video.colors.blue             0x01
%define @BIOS.video.colors.green            0x02
%define @BIOS.video.colors.cyan             0x03
%define @BIOS.video.colors.red              0x04
%define @BIOS.video.colors.magenta          0x05
%define @BIOS.video.colors.brown            0x06
%define @BIOS.video.colors.lightGray        0x07
%define @BIOS.video.colors.gray             0x08
%define @BIOS.video.colors.lightBlue        0x09
%define @BIOS.video.colors.lightGreen       0x0A
%define @BIOS.video.colors.lightCyan        0x0B
%define @BIOS.video.colors.lightRed         0x0C
%define @BIOS.video.colors.lightMagenta     0x0D
%define @BIOS.video.colors.lightBrown       0x0E
%define @BIOS.video.colors.white            0x0F

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
    xor     bh,     bh
    
    ; XY coordinates
    mov     dh,     %1
    mov     dl,     %2
    
    ; Calls the BIOS video services
    @BIOS.int.video
    
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
    xor     al,     al
    
    ; Sets the screen color
    @BIOS.video.createScreenColor bh, %1, %2
    
    ; XY coordinates
    xor     cx,     cx
    
    ; Width and height
    mov     dl,     $BIOS.video.screen.cols - 1
    mov     dh,     $BIOS.video.screen.rows - 1
    
    ; Calls the BIOS video services
    @BIOS.int.video
    
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
; Input registers:
; 
;       - SI:       The address of the string to print (DS:SI)
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
BIOS.video.print:
    
    ; Save registers
    push ax
    
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
        @BIOS.int.video
        
        ; Process the next byte from the string
        jmp     .repeat
            
    ; End of the string
    .done:
        
        ; Restore registers
        pop ax
        
        ret

%endif
