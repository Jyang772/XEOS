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
; Those procedures and macros are intended to be used only in 64 bits long
; mode. In real mode, please use the macros and procedures from the
; 'xeos.16.video.inc.s' file.
;-------------------------------------------------------------------------------

%ifndef __XEOS_64_VIDEO_INC_S__
%define __XEOS_64_VIDEO_INC_S__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.macros.inc.s"          ; General macros
%include "xeos.crt.controller.inc.s"  ; CRT microcontroller

; We are in 32 bits mode
BITS    64

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Location of the video memory
%define @XEOS.64.video.memory                  0xB8000

; BIOS screen dimensions
%define @XEOS.64.video.screen.cols             80
%define @XEOS.64.video.screen.rows             25

; BIOS colors
%define @XEOS.64.video.color.black             0x00
%define @XEOS.64.video.color.blue              0x01
%define @XEOS.64.video.color.green             0x02
%define @XEOS.64.video.color.cyan              0x03
%define @XEOS.64.video.color.red               0x04
%define @XEOS.64.video.color.magenta           0x05
%define @XEOS.64.video.color.brown             0x06
%define @XEOS.64.video.color.gray.light        0x07
%define @XEOS.64.video.color.gray              0x08
%define @XEOS.64.video.color.blue.light        0x09
%define @XEOS.64.video.color.green.light       0x0A
%define @XEOS.64.video.color.cyan.light        0x0B
%define @XEOS.64.video.color.red.light         0x0C
%define @XEOS.64.video.color.magenta.light     0x0D
%define @XEOS.64.video.color.brown.light       0x0E
%define @XEOS.64.video.color.white             0x0F

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
%macro @XEOS.64.video._currentPosition 0
    
    
    
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
%macro @XEOS.64.video.createScreenColor 3
    
    
    
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
%macro @XEOS.64.video.setBackgroundColor 1
    
    
    
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
%macro @XEOS.64.video.setForegroundColor 1
    
    
    
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
%macro @XEOS.64.video.clear 2
    
    
    
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
%macro @XEOS.64.video.cursor.move 2
    
    
    
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
%macro @XEOS.64.video.putc 1
    
    
    
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
%macro @XEOS.64.video.print  1
    
    
    
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
XEOS.64.video.clear:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
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
XEOS.64.video.scroll:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
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
XEOS.64.video.cursor.move:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
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
XEOS.64.video.cursor.update:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
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
XEOS.64.video.putc:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
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
XEOS.64.video.print:
    
    @XEOS.64.proc.start 0
    
    @XEOS.64.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

; Current position of the cursor
$XEOS.64.video.cursor.x     db  0x00
$XEOS.64.video.cursor.y     db  0x00

; Current character attribute (default is white on black)
$XEOS.64.video.attribute    db  0x0F

%endif
