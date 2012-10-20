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
; General purpose macros
;-------------------------------------------------------------------------------

%ifndef __XEOS_MACROS_INC_ASM__
%define __XEOS_MACROS_INC_ASM__

;-------------------------------------------------------------------------------
; Start of a standard procedure
; 
; Parameters:
; 
;       1:          The number of stack (local) variables 
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.proc.start 1
    
    ; Saves registers and flags
    pushf
    pusha
    
    ; Creates the stack frame
    push    ebp
    mov     ebp,        esp
    
    ; Space for local variables
    sub     esp,        %1 * 4
    
    ; Aligns the stack on a 16 byte boundary
    and     esp,        0xFFFFFFF0
    
%endmacro

;-------------------------------------------------------------------------------
; End of a standard procedure
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.proc.end 0
    
    ; Resets the previous stack frame
    mov     esp,        ebp
    pop     ebp
    
    ; Restores registers and flags
    popa
    popf
    
%endmacro

;-------------------------------------------------------------------------------
; Sets a stack (local) variable
; 
; Parameters:
; 
;       1:          The index of the stack (local) variables
;       2:          The value to set
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.proc.var.set 2
    
    mov @XEOS.proc.var.%1,  DWORD 0
    mov @XEOS.proc.var.%1, %2
    
%endmacro

; Shortcuts for stack (local) variables
%define @XEOS.proc.var.1    [ ebp -  4 ]
%define @XEOS.proc.var.2    [ ebp -  8 ]
%define @XEOS.proc.var.3    [ ebp - 12 ]
%define @XEOS.proc.var.4    [ ebp - 16 ]
%define @XEOS.proc.var.5    [ ebp - 20 ]
%define @XEOS.proc.var.6    [ ebp - 24 ]
%define @XEOS.proc.var.7    [ ebp - 28 ]
%define @XEOS.proc.var.8    [ ebp - 32 ]
%define @XEOS.proc.var.9    [ ebp - 36 ]
%define @XEOS.proc.var.10   [ ebp - 40 ]

%endif
