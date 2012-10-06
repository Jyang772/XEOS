;-------------------------------------------------------------------------------
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
;-------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; Error management
; 
; Those procedures and macros are intended to be used only in 32 bits protected
; mode.
;-------------------------------------------------------------------------------
%ifndef __XEOS_ERROR_INC_32_ASM__
%define __XEOS_ERROR_INC_32_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "BIOS.video.inc.16.asm"        ; XEOS video services
%include "XEOS.ascii.inc.asm"           ; ASCII table

; We are in 32 bits mode
BITS    32

%macro @XEOS.error.fatal 1
    
    mov     si,         %1
    call    XEOS.error.fatal
    
%endmacro

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.error.fatal:
    
    @XEOS.video.clear $XEOS.video.colors.white, $XEOS.video.colors.black
    
    push    si
    mov     si,         XEOS.error.prompt
    call    XEOS.video.print
    
    pop     si
    
    @XEOS.video.setForegroundColor $XEOS.video.colors.red
    
    call    XEOS.video.print
    
    @XEOS.video.setForegroundColor $XEOS.video.colors.white
    
    @XEOS.video.print XEOS.error.reboot
    
    jmp     $
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

XEOS.error.prompt   db  $ASCII.NL,\
                        '    ************************************************************************   ', $ASCII.NL,\
                        '    *                                                                      *   ', $ASCII.NL,\
                        '    *                         XEOS - FATAL ERROR                           *   ', $ASCII.NL,\
                        '    *                                                                      *   ', $ASCII.NL,\
                        '    ************************************************************************   ', $ASCII.NL,\
                        $ASCII.NL,\
                        '<XEOS>: A fatal error occured: ',\
                        $ASCII.NL, $ASCII.NL, $ASCII.NUL
XEOS.error.reboot   db  $ASCII.NL, $ASCII.NL,\
                        '<XEOS>: Press any key to reboot the system: ', $ASCII.NUL

%endif
