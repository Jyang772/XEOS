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
; Procedures to enable the A20 address line
; 
; The 8086 processor was originally designed with a 20bits address bus
; (20 address lines - 0-19).
; The processor had access to 2^20 bytes of addressable memory (about 1MB).
; 
; In order to be compatible with older processors, x86 processors are powered
; on in real mode, meaning they only have access to the firts 20 address lines.
; 
; In order to enter the 32 bits protected mode, and have access to more than
; 4GB of addressable memory (2^32), the 20th address line needs to be enabled.
; 
; Several ways of enabling the 20th address lines are available, but some of
; them are specific to some BIOS. The most portable way is to enable A20
; through the keyboard controller.
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------

%ifndef __XEOS_A20_INC_16_ASM__
%define __XEOS_A20_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.macros.inc.asm"          ; General macros
%include "BIOS.int.inc.asm"             ; BIOS interrupts
%include "BIOS.video.inc.16.asm"        ; BIOS video services
%include "XEOS.error.inc.16.asm"        ; Error management

; We are in 16 bits mode
;BITS    16

;-------------------------------------------------------------------------------
; Enables A20 through the system control port
;-------------------------------------------------------------------------------
XEOS.a20.enable.systemControl:
    
    @XEOS.reg.save
    
    ; Bits 2 enables A20
    mov     al,         2
    
    ; Writes to the system control port
    out     0x92,       al
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Enables A20 through a BIOS call
;-------------------------------------------------------------------------------
XEOS.a20.enable.bios:
    
    @XEOS.reg.save
    
    ; A20 enabling function ( BIOS miscellaneous services function)
    mov     ax,         0x2401
    
    ; Calls the BIOS miscellaneous services
    $BIOS.int.misc
    
    ; Checks for an error
    jnc     .success
    
    ; Prints the error message
    @BIOS.video.print   XEOS.a20.enable.bios.error
    
    ; Asks the user for a choice
    .ask
    
    ; Waits for a key (BIOS keyboard services function)
    xor     ax,         ax
    
    ; Calls the BIOS keyboard services
    $BIOS.int.keyboard
    
    ; Checks if the pressed key was '1'
    cmp     al,         0x31
    
    ; Yes - Enables A20 through the keyboard controller
    je      .keyboardOut
    
    ; Checks if the pressed key was '2'
    cmp     al,         0x32
    
    ; Yes - Enables A20 through the keyboard controller
    je     .keyboardController
    
    ; Checks if the pressed key was '3'
    cmp     al,         0x33
    
    ; Yes - Enables A20 through the keyboard controller
    je     .systemController
    
    ; Checks if the pressed key was '4'
    cmp     al,         0x34
    
    ; Yes - Enables A20 through the keyboard controller
    je     .reboot
    
    ; Unknown choice
    @BIOS.video.print   XEOS.a20.enable.bios.fallback.unknown
    
    ; Asks again
    je      .ask
    
    ; Fallback - A-20 will be enabled through the keyboard out port
    .keyboardOut:
    
    ; User feedback - Displays a '1' on the screen
    mov     al,         0x31
    mov     ah,         0x0E
    $BIOS.int.video
    
    ; Prints the confirmation message
    @BIOS.video.print   XEOS.a20.enable.bios.fallback.keyboardOut
    
    ; Enables A20 through the keyboard out port
    call    XEOS.a20.enable.keyboard.out
    je      .success
    
    ; Fallback - A-20 will be enabled through the keyboard control port
    .keyboardController:
    
    ; User feedback - Displays a '2' on the screen
    mov     al,         0x32
    mov     ah,         0x0E
    $BIOS.int.video
    
    ; Prints the confirmation message
    @BIOS.video.print   XEOS.a20.enable.bios.fallback.keyboardControl
    
    ; Enables A20 through the keyboard controller
    call    XEOS.a20.enable.keyboard.control
    je      .success
    
    ; Fallback - A-20 will be enabled through the system control port
    .systemController:
    
    ; User feedback - Displays a '3' on the screen
    mov     al,         0x33
    mov     ah,         0x0E
    $BIOS.int.video
    
    ; Prints the confirmation message
    @BIOS.video.print   XEOS.a20.enable.bios.fallback.systemControl
    
    ; Enables A20 through the keyboard controller
    call    XEOS.a20.enable.keyboard.control
    je      .success
    
    ; Fallback - Reboot the system
    .reboot:
    
    ; User feedback - Displays a '4' on the screen
    mov     al,         0x34
    mov     ah,         0x0E
    $BIOS.int.video
    
    ; Prints the reboot message
    @BIOS.video.print   XEOS.a20.enable.bios.fallback.reboot
    
    ; Reboots the system
    $BIOS.int.reboot
    
    .success
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Enables A20 through the keyboard control port
;-------------------------------------------------------------------------------
XEOS.a20.enable.keyboard.control:
    
    @XEOS.reg.save
    
    ; A20 enabling command
    mov	    al,         0xDD
    
    ; Sends the command to the keyboard control port
    out     0x64,       al
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Enables A20 through the keyboard out port
;-------------------------------------------------------------------------------
XEOS.a20.enable.keyboard.out:
    
    @XEOS.reg.save
    
    ; Clears the interrupts
    cli
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Disables the keyboard
    mov     al,         0xAD
    out     0x64,       al
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Tells the keyboard controller to read the output port
    mov     al,         0xD0
    out     0x64,       al
    
    ; Waits for the output buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.out
    
    ; Stores the data of the output port in the stack
    in      al,         0x60
    push    eax
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Writes the output port
    mov     al,         0xD1
    out     0x64,       al
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Restores data from the output port
    pop     eax
    
    ; Bit 1 enables A20
    or      al,         2
    
    ; Writes the data to the output port
    out     0x60,       al
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Re-enables the keyboard
    mov     al,         0xAE
    out     0x64,       al
    
    ; Waits for the input buffer to be empty
    call    XEOS.a20.enable.keyboard.out.wait.in
    
    ; Restores the interrupts
    sti
    
    @XEOS.reg.restore
    
    ret
    
;-------------------------------------------------------------------------------
; Waits for the input buffer of the keyboard controller to be empty
;-------------------------------------------------------------------------------
XEOS.a20.enable.keyboard.out.wait.in:
    
    in      al,         0x64
    test    al,         2
    jnz     XEOS.a20.enable.keyboard.out.wait.in
    
    ret

;-------------------------------------------------------------------------------
; Waits for the output buffer of the keyboard controller to be empty
;-------------------------------------------------------------------------------
XEOS.a20.enable.keyboard.out.wait.out:
    
    in      al,         0x64
    test    al,         1
    jz      XEOS.a20.enable.keyboard.out.wait.out
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Strings
XEOS.a20.enable.bios.error                      db  $ASCII.NL,\
                                                    '         ERROR: A-20 cannot be enabled with the BIOS!',\
                                                    $ASCII.NL,\
                                                    '         Choose an alternate solution form the list below:',\
                                                    $ASCII.NL, $ASCII.NL,\
                                                    '             1 - Enable A-20 through the keyboard output port (recommended)',\
                                                    $ASCII.NL,\
                                                    '             2 - Enable A-20 through the keyboard control port',\
                                                    $ASCII.NL,\
                                                    '             3 - Enable A-20 through the system control port',\
                                                    $ASCII.NL,\
                                                    '             4 - Reboot the system',\
                                                    $ASCII.NL, $ASCII.NL,\
                                                    '         Please enter your choice: ',\
                                                    $ASCII.NUL
XEOS.a20.enable.bios.fallback.keyboardOut       db  $ASCII.NL, $ASCII.NL,\
                                                    '         Enabling A-20 through the keyboard output port...',\
                                                    $ASCII.NL, $ASCII.NL, $ASCII.NUL
XEOS.a20.enable.bios.fallback.keyboardControl   db  $ASCII.NL, $ASCII.NL,\
                                                    '         Enabling A-20 through the keyboard control port...',\
                                                    $ASCII.NL, $ASCII.NL, $ASCII.NUL
XEOS.a20.enable.bios.fallback.systemControl     db  $ASCII.NL, $ASCII.NL,\
                                                    '         Enabling A-20 through the system control port...',\
                                                    $ASCII.NL, $ASCII.NL, $ASCII.NUL
XEOS.a20.enable.bios.fallback.reboot            db  $ASCII.NL, $ASCII.NL,\
                                                    '         Rebooting the system...',\
                                                    $ASCII.NL, $ASCII.NL, $ASCII.NUL
XEOS.a20.enable.bios.fallback.unknown           db  $ASCII.NL, $ASCII.NL,\
                                                    '         Invalid choice. A-20 still needs to be enabled...',\
                                                    $ASCII.NL,\
                                                    '         Press ', 39, '1', 39, ' if you don', 39, 't know what this is about: ',\
                                                    $ASCII.NUL

%endif
