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
; Defines, macros and procedures for the XEOS video services
; 
; Those procedures and macros are intended to be used only in 32 bits protected
; mode. In real mode, please use the macros and procedures from the
; 'BIOS-VIDEO.ASM' file.
;-------------------------------------------------------------------------------

%ifndef VIDEO_ASM
%define VIDEO_ASM

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "MACROS.ASM"       ; General macros

;-------------------------------------------------------------------------------
; Definitions
;-------------------------------------------------------------------------------

; Location of the video memory
%define $XEOS.video.memory                  0xB8000

; BIOS screen dimensions
%define $XEOS.video.screen.cols             80
%define $XEOS.video.screen.rows             25

; BIOS colors
%define $XEOS.video.colors.black            0x00
%define $XEOS.video.colors.blue             0x01
%define $XEOS.video.colors.green            0x02
%define $XEOS.video.colors.cyan             0x03
%define $XEOS.video.colors.red              0x04
%define $XEOS.video.colors.magenta          0x05
%define $XEOS.video.colors.brown            0x06
%define $XEOS.video.colors.lightGray        0x07
%define $XEOS.video.colors.darkGray         0x08
%define $XEOS.video.colors.lightBlue        0x09
%define $XEOS.video.colors.lightGreen       0x0A
%define $XEOS.video.colors.lightCyan        0x0B
%define $XEOS.video.colors.lightRed         0x0C
%define $XEOS.video.colors.lightMagenta     0x0D
%define $XEOS.video.colors.lightBrown       0x0E
%define $XEOS.video.colors.white            0x0F

;-------------------------------------------------------------------------------
; Computes the value of a BIOS screen color into a register
; 
; Parameter 1:  The register in which to place the color value
; Parameter 2:  The foreground color
; Parameter 3:  The background color
;-------------------------------------------------------------------------------
%macro @XEOS.video.createScreenColor 3
    
    ; Stores the background color
    mov %1, %3
    shl %1, 4
    
    ; Stores the foreground color
    add %1, %2
    
%endmacro

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.video.print:
    
    @XEOS.reg.save
    
    
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

; Current position of the cursor
XEOS.video.cursor.x db  0
XEOS.video.cursor.y db  0

%endif
