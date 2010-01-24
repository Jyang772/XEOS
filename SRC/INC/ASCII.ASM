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
%define $ASCII.NUL      0x00
%define $ASCII.SOH      0x01
%define $ASCII.STX      0x02
%define $ASCII.ETX      0x03
%define $ASCII.EOT      0x04
%define $ASCII.ENQ      0x05
%define $ASCII.ACK      0x06
%define $ASCII.BEL      0x07
%define $ASCII.BS       0x08
%define $ASCII.TAB      0x09
%define $ASCII.LF       0x0A
%define $ASCII.VT       0x0B
%define $ASCII.FF       0x0C
%define $ASCII.CR       0x0D
%define $ASCII.SO       0x0E
%define $ASCII.SI       0x0F
%define $ASCII.DLE      0x10
%define $ASCII.DC1      0x11
%define $ASCII.DC2      0x12
%define $ASCII.DC3      0x13
%define $ASCII.DC4      0x14
%define $ASCII.NAK      0x15
%define $ASCII.SYN      0x16
%define $ASCII.ETB      0x17
%define $ASCII.CAN      0x18
%define $ASCII.EM       0x19
%define $ASCII.SUB      0x1A
%define $ASCII.ESC      0x1B
%define $ASCII.FS       0x1C
%define $ASCII.GS       0x1D
%define $ASCII.RS       0x1E
%define $ASCII.US       0x1F

; Space character
%define $ASCII.SPC      0x20

; New line character (CRLF)
%define $ASCII.NL   $ASCII.CR, $ASCII.LF

%endif
