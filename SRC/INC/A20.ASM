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
;-------------------------------------------------------------------------------

%ifndef A20_ASM
%define A20_ASM

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "MACROS.ASM"       ; General macros
%include "BIOS-INT.ASM"     ; BIOS interrupts
%include "BIOS-VIDEO.ASM"   ; BIOS video services
%include "ERROR.ASM"        ; Error management

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
    
    ; Waits for a key (BIOS keyboard services function)
    xor     ax,         ax
    
    ; Calls the BIOS keyboard services
    $BIOS.int.keyboard
    
    ; Checks if the pressed key was 'K'
    cmp     al,         0x4B
    
    ; Yes - Enables A20 through the keyboard controller
    je      .keyboardController
    
    ; Checks if the pressed key was 'k'
    cmp     al,         0x6B
    
    ; Yes - Enables A20 through the keyboard controller
    je     .keyboardController
    
    .reboot:
    
    ; Prints the reboot message
    @BIOS.video.print   XEOS.a20.enable.bios.error.reboot
    
    ; Reboots the system
    $BIOS.int.reboot
    
    .keyboardController:
    
    ; User feedback - Displays a 'K' on the screen
    mov     al,         0x4B
    mov     ah,         0x0E
    $BIOS.int.video
    
    ; Prints the confirmation message
    @BIOS.video.print   XEOS.a20.enable.bios.error.keyboard
    
    ; Enables A20 through the keyboard controller
    call    XEOS.a20.enable.keyboard.control
    
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
    out	    0x64,       al
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Enables A20 through the keyboard out port
;-------------------------------------------------------------------------------
XEOS.a20.enable.keyboard.out:
    
    @XEOS.reg.save
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Strings
XEOS.a20.enable.bios.error          db  $ASCII.NL,\
                                        '         ERROR: A-20 cannot be enabled with the BIOS!',\
                                        $ASCII.NL, $ASCII.NL,\
                                        '         Press ', 0x27 , 'K', 0x27 ,' to enable A-20 through the keyboard controller,',\
                                        $ASCII.NL,\
                                        '         or any other key to reboot the system: ',\
                                        $ASCII.NUL
XEOS.a20.enable.bios.error.reboot   db  $ASCII.NL, $ASCII.NL,\
                                        '         Rebooting...',\
                                        $ASCII.NUL
XEOS.a20.enable.bios.error.keyboard db  $ASCII.NL, $ASCII.NL,\
                                        '         Enabling A-20 through the keyboard controller...',\
                                        $ASCII.NL, $ASCII.NL, $ASCII.NUL

%endif
