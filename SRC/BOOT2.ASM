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

; We are in 16 bits real mode
%ifndef $XEOS.cpu.realMode    
%define $XEOS.cpu.realMode 1
%endif

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
%include "GDT.ASM"          ; GDT - Global Descriptor Table
%include "A20.ASM"          ; 20th address line enabling
%include "VIDEO.ASM"        ; XEOS video services

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Horizontal ruler
%define HR              '    ************************************************************************', $ASCII.NL

; Prints a new line with a message, prefixed by the prompt
%macro @XEOS.boot.stage2.print 1
    
    @BIOS.video.print    XEOS.boot.stage2.prompt
    @BIOS.video.print    %1
    @BIOS.video.print    XEOS.boot.stage2.nl
    
%endmacro

XEOS.boot.stage2:
    
    ; Clears the interrupts as we are setting-up the segments and stack space
    cli
    
    ; Sets the data and extra segments to where we were loaded by the first
    ; stage bootloader (0x50), so we don't have to add 0x50 to all our data
    mov     ax,         0x50
    mov     ds,         ax
    mov     es,         ax
    
    ; Sets up the stack (0x9000-0xFFFF)
    mov     ax,         0x9000
    mov     ss,         ax
    mov     sp,         0xFFFF
    
    ; Restores the interrupts
    sti
    
    ; Prints the copyright notice
    @BIOS.video.print       XEOS.boot.stage2.copyright
    
    ; Prints status messages
    @XEOS.boot.stage2.print XEOS.boot.stage2.greet
    @XEOS.boot.stage2.print XEOS.boot.stage2.revision
    @XEOS.boot.stage2.print XEOS.boot.stage2.date
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.gdt
    
    ; Installs the GDT
    call    XEOS.gdt.install
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.a20
    
    ; Enables A20 - 20th address line on the address bus to access 4GB of memory
    call    XEOS.a20.enable.bios
    
    @XEOS.boot.stage2.print XEOS.boot.stage2.loadRoot
    @XEOS.boot.stage2.print XEOS.boot.stage2.findKernel
    @XEOS.boot.stage2.print XEOS.boot.stage2.loadKernel
    
    ; Time to switch the CPU to 32bits protected mode
    .enterProtectedMode:
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.pMode
    
    ; Clears the interrupts
    cli
    
    ; Gets the value of the primary control register
    mov     eax,        cr0
    
    ; Sets the lowest bit, indicating the system must run in protected mode
    or      eax,        1
    
    ; Sets the new value - We are now in 32bits protected mode
    mov     cr0,        eax
    
    ; We are now in 32 bits realmode
    %undef $XEOS.cpu.realMode
    
    ; Infinite loop
    jmp     $

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

XEOS.boot.stage2.copyright      db  $ASCII.NL, HR,\
                                '    *               XEOS - x86 Experimental Operating System               *',\
                                $ASCII.NL,\
                                '    *                                                                      *',\
                                $ASCII.NL,\
                                '    *     Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)     *',\
                                $ASCII.NL,\
                                '    *                    All rights (& wrongs) reserved                    *',\
                                $ASCII.NL, HR, $ASCII.NL, $ASCII.NUL
XEOS.boot.stage2.nl             db   $ASCII.NL,  $ASCII.NUL         
XEOS.boot.stage2.prompt         db  '<BOOT2>: ', $ASCII.NUL
XEOS.boot.stage2.revision       db  '$Revision$', $ASCII.NUL
XEOS.boot.stage2.date           db  '$Date$', $ASCII.NUL
XEOS.boot.stage2.greet          db  'Entering the second stage bootloader...', $ASCII.NUL
XEOS.boot.stage2.gdt            db  'Installing the global descriptor table - GDT...', $ASCII.NUL
XEOS.boot.stage2.a20            db  'Enabling the A-20 address line...', $ASCII.NUL
XEOS.boot.stage2.loadRoot       db  'Loading the FAT-12 root directory into memory...', $ASCII.NUL
XEOS.boot.stage2.findKernel     db  'Trying to find the XEOS kernel (KERNEL.BIN)...', $ASCII.NUL
XEOS.boot.stage2.loadKernel     db  'Loading the XEOS kernel into memory...', $ASCII.NUL
XEOS.boot.stage2.pMode          db  'Switching the CPU to 32 bits protected mode...', $ASCII.NUL
