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
; General purpose macros
;-------------------------------------------------------------------------------
%ifndef __XEOS_MACROS_INC_ASM__
%define __XEOS_MACROS_INC_ASM__

;-------------------------------------------------------------------------------
; Saves the values of the AX, BX, CX and DX registers in the stack
;-------------------------------------------------------------------------------
%macro @XEOS.reg.save 0
    
    ; Checks if we are compiling for an old 8086 CPU
    %ifdef CPU_8086
        
        ; Manually stores the registers to the stack, as the 'pusha' instruction
        ; is only available on 80286 processors and later
        push    ax
        push    cx
        push    dx
        push    bx
        push    sp
        push    bp
        push    si
        push    di
        
    %else
        
        ; 80286 or later processor - 'pusha' is available
        pusha
        
    %endif
    
%endmacro

;-------------------------------------------------------------------------------
; Restores the values of the AX, BX, CX and DX registers from the stack
;-------------------------------------------------------------------------------
%macro @XEOS.reg.restore 0
    
    ; Checks if we are compiling for an old 8086 CPU
    %ifdef CPU_8086
        
        ; Manually restores the registers to the stack, as the 'popa'
        ; instruction is only available on 80286 processors and later
        pop     di
        pop     si
        pop     bp
        pop     sp
        pop     bx
        pop     dx
        pop     cx
        pop     ax
        
    %else
        
        ; 80286 or later processor - 'popa' is available
        popa
        
    %endif
    
%endmacro

%endif
