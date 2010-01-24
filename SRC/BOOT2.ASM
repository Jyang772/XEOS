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
; XEOS second stage bootloader
; 
; Note about compiling:
;
; This file has to be compiled as a flat-form binary file.
; 
; The following compilers have been successfully tested:
; 
;       - NASM - The Netwide Assembler
;       - YASM - The Yasm Modular Assembler
; 
; Other compilers have not been tested.
; 
; Examples:
; 
;       - nasm -f bin -o [boot.flp] [boot.asm]
;       - yasm -f bin -o [boot.flp] [boot.asm]
;-------------------------------------------------------------------------------

; Forces the 16 bits mode for the BIOS
BITS    16

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Horizontal ruler
%define HR              '--------------------------------------------------------------------------------'

;-------------------------------------------------------------------------------
; Second stage bootloader
; 
; The main XEOS bootloader, which is responsible to load the kernel.
;-------------------------------------------------------------------------------

; Jumps to the effective code section
jmp     XEOS.boot.stage2

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "MACROS.ASM"       ; General macros
%include "BIOS-INT.ASM"     ; BIOS interrupts
%include "BIOS-VIDEO.ASM"   ; BIOS video services
%include "BIOS-LLDS.ASM"    ; BIOS low-level disk services
%include "ASCII.ASM"        ; ASCII table

XEOS.boot.stage2:
    
    ; Clears the interrupts
    cli
    
    ; Set DS to CS, as we are now in the second stage bootloader
    push    cs
    push    cs
    pop     ds
    pop     es
    
    ; Restores the interrupts
    sti
    
    ; Clears the screen
    @BIOS.video.clearScreen $BIOS.video.colors.white, $BIOS.video.colors.lightBlue
    
    ; Prints the greeting
    @BIOS.video.print    XEOS.boot.stage2.greet
    
    ; Prints the copyright notice
    @BIOS.video.print    XEOS.boot.stage2.copyright
    
    ; Prints the find kernel message
    @BIOS.video.print    XEOS.boot.stage2.pMode
    
    ; Infinite loop
    jmp     $

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

XEOS.boot.stage2.greet          db  $ASCII.NL,\
                                'Entering the second stage bootloader...',\
                                $ASCII.NL, $ASCII.NUL

XEOS.boot.stage2.copyright      db  $ASCII.NL, HR,\
                                'XEOS - x86 Experimental Operating System',\
                                $ASCII.NL, $ASCII.NL,\
                                'Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)',\
                                $ASCII.NL,\
                                'All rights reserved',\
                                $ASCII.NL, HR, $ASCII.NL, $ASCII.NUL

XEOS.boot.stage2.pMode          db  'Entering protected mode...',\
                                $ASCII.NL, $ASCII.NUL
