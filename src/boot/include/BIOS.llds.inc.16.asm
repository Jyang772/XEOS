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
; Defines, macros and procedures for the BIOS low-level disk services
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------

%ifndef __BIOS_LLDS_INC_16_ASM__
%define __BIOS_LLDS_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.asm"       ; General constants
%include "XEOS.macros.inc.asm"          ; General macros
%include "BIOS.int.inc.asm"             ; BIOS interrupts
%include "XEOS.error.inc.16.asm"        ; Error management

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Resets the floppy disk
;-------------------------------------------------------------------------------
BIOS.llds.resetFloppyDrive:
    
    @XEOS.reg.save
    
    ; Resets CX, so we can count the number of reset tries
    xor     cx,         cx
    
    .start:
    
    ; Floppy reset (BIOS low level disk services function)
    xor     ax,         ax
    
    ; Drive number
    mov dl,             $XEOS.mbr.driveNumber
    
    ; Calls the BIOS low level disk services
    $BIOS.int.llds
    
    ; Checks if an error occued
    jnc     .succes
    
    ; Increases the number of reset tries
    inc     cx
    
    ; 5 possible retries, in case of error
    cmp     cx,         5
    
    ; Tries to reset again
    jb     .start
    
    ; 5 retries - Fatal error
    call    XEOS.error.fatal
    
    .succes:
    
    @XEOS.reg.restore
    
    ret

%endif
