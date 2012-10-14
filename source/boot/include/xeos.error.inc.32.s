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
%include "BIOS.video.inc.16.s"        ; XEOS video services
%include "XEOS.ascii.inc.s"           ; ASCII table

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

XEOS.error.prompt   db  @ASCII.NL,\
                        '    ************************************************************************   ', @ASCII.NL,\
                        '    *                                                                      *   ', @ASCII.NL,\
                        '    *                         XEOS - FATAL ERROR                           *   ', @ASCII.NL,\
                        '    *                                                                      *   ', @ASCII.NL,\
                        '    ************************************************************************   ', @ASCII.NL,\
                        @ASCII.NL,\
                        '<XEOS>: A fatal error occured: ',\
                        @ASCII.NL, @ASCII.NL, @ASCII.NUL
XEOS.error.reboot   db  @ASCII.NL, @ASCII.NL,\
                        '<XEOS>: Press any key to reboot the system: ', @ASCII.NUL

%endif
