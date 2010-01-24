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
; In order to be compatible with older processors, x86 processors only have
; access to 20 address lines (address bus - lines 0-19). In such a case,
; memory is limited to 1MB.
; 
; To allow the OS to access 4GB of memory (in 32 bits protected mode), the 20th
; address line needs to be enabled.
; 
; Several ways of enabling the 20th address lines are available, but some of
; them are specific to some BIOS. The most portable way is to enable A20
; through the keyboard controller.
;-------------------------------------------------------------------------------

%ifndef A20_ASM
%define A20_ASM



%endif
