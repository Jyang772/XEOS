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
; Defines, macros and procedures for the CRT microcontroller
;-------------------------------------------------------------------------------

%ifndef __XEOS_CRT_CONTROLLER_INC_ASM__
%define __XEOS_CRT_CONTROLLER_INC_ASM__

;-------------------------------------------------------------------------------
; Definitions
;-------------------------------------------------------------------------------

; Location of the video memory
%define $XEOS.crt.controller.registers.data                 0x03D4
%define $XEOS.crt.controller.registers.index                0x03D5

; Indices for the index register
%define $XEOS.crt.controller.horizontalTotal                0x0000
%define $XEOS.crt.controller.horizontalDisplayEnableEnd     0x0001
%define $XEOS.crt.controller.startHorizontalBlanking        0x0002
%define $XEOS.crt.controller.endHorizontalBlanking          0x0003
%define $XEOS.crt.controller.startHorizontalRetracePulse    0x0004
%define $XEOS.crt.controller.endHorizontalRetrace           0x0005
%define $XEOS.crt.controller.verticalTotal                  0x0006
%define $XEOS.crt.controller.overflow                       0x0007
%define $XEOS.crt.controller.presetRowScan                  0x0008
%define $XEOS.crt.controller.maximumScanLine                0x0009
%define $XEOS.crt.controller.cursorStart                    0x000A
%define $XEOS.crt.controller.cursorEnd                      0x000B
%define $XEOS.crt.controller.startAddressHigh               0x000C
%define $XEOS.crt.controller.startAddressLow                0x000D
%define $XEOS.crt.controller.cursorLocationHigh             0x000E
%define $XEOS.crt.controller.cursorLocationLow              0x000F
%define $XEOS.crt.controller.verticalRetraceStart           0x0010
%define $XEOS.crt.controller.verticalRetraceEnd             0x0011
%define $XEOS.crt.controller.verticalDisplayEnableEnd       0x0012
%define $XEOS.crt.controller.offset                         0x0013
%define $XEOS.crt.controller.underlineLocation              0x0014
%define $XEOS.crt.controller.startVerticalBlanking          0x0015
%define $XEOS.crt.controller.endVerticalBlanking            0x0016
%define $XEOS.crt.controller.crtModeControl                 0x0017
%define $XEOS.crt.controller.lineCompare                    0x0018

%endif
