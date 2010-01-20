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
; ASCII table definition
;-------------------------------------------------------------------------------

%ifndef ASCII_ASM
%define ASCII_ASM

; Control characters
%define $ASCII.NUL  00h
%define $ASCII.SOH  01h
%define $ASCII.STX  02h
%define $ASCII.ETX  03h
%define $ASCII.EOT  04h
%define $ASCII.ENQ  05h
%define $ASCII.ACK  06h
%define $ASCII.BEL  07h
%define $ASCII.BS   08h
%define $ASCII.TAB  09h
%define $ASCII.LF   0Ah
%define $ASCII.VT   0Bh
%define $ASCII.FF   0Ch
%define $ASCII.CR   0Dh
%define $ASCII.SO   0Eh
%define $ASCII.SI   0Fh
%define $ASCII.DLE  10h
%define $ASCII.DC1  11h
%define $ASCII.DC2  12h
%define $ASCII.DC3  13h
%define $ASCII.DC4  14h
%define $ASCII.NAK  15h
%define $ASCII.SYN  16h
%define $ASCII.ETB  17h
%define $ASCII.CAN  18h
%define $ASCII.EM   19h
%define $ASCII.SUB  1Ah
%define $ASCII.ESC  1Bh
%define $ASCII.FS   1Ch
%define $ASCII.GS   1Dh
%define $ASCII.RS   1Eh
%define $ASCII.US   1Fh

; Space character
%define $ASCII.SPC  20h

; New line character (CRLF)
%define $ASCII.NL   $ASCII.CR, $ASCII.LF

%endif
