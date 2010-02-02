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

; We are in 16 bits real mode
%ifndef $XEOS.cpu.realMode    
%define $XEOS.cpu.realMode 1
%endif

; Location at which we were loaded by the first stage bootloader (0x50:0)
ORG     0x500

; Jumps to the effective code section
jmp     XEOS.boot.stage2

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "CONSTANTS.INC.ASM"        ; General constants
%include "MACROS.INC.ASM"           ; General macros
%include "BIOS-INT.INC.ASM"         ; BIOS interrupts
%include "BIOS-VIDEO.INC.16.ASM"    ; BIOS video services
%include "BIOS-LLDS.INC.16.ASM"     ; BIOS low-level disk services
%include "IO-FAT12.INC.16.ASM"      ; FAT-12 IO procedures
%include "ASCII.INC.ASM"            ; ASCII table
%include "GDT.INC.ASM"              ; GDT - Global Descriptor Table
%include "A20.INC.16.ASM"           ; 20th address line enabling
%include "VIDEO.INC.32.ASM"         ; XEOS video services

; We are in 16 bits mode
BITS    16

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

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

XEOS.files.kernel               db  'KERNEL  BIN'
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
XEOS.boot.stage2.execKernel     db  'Moving and executing the XEOS kernel...', $ASCII.NUL

;-------------------------------------------------------------------------------
; Second stage bootloader
; 
; The main XEOS bootloader, which is responsible to load the kernel.
;-------------------------------------------------------------------------------
XEOS.boot.stage2:
    
    ; Clears the interrupts as we are setting-up the segments and stack space
    cli
    
    ; Sets the data and extra segments to where we were loaded by the first
    ; stage bootloader (0x50), so we don't have to add 0x50 to all our data
    xor     ax,         ax
    mov     ds,         ax
    mov     es,         ax
    
    ; Sets up the stack space
    xor     ax,         ax
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
    @XEOS.boot.stage2.print XEOS.boot.stage2.loadRoot
    
    ; Loads the root directory into memory
    ; 
    ; Sectors will be read after the stack space (ES:BX = 0x07C0:0x1000).
    mov     bx,         0x1000
    call    XEOS.io.fat12.loadRootDirectory
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.findKernel
    
    ; Location of the data we read into memory
    mov     di,         0x1000
    
    ; Name of the kernel file
    mov     si,         XEOS.files.kernel
    
    ; Tries to find the kernel file in the root directory
    call    XEOS.io.fat12.findFile
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.loadKernel
    
    ; We are going to load the kernel at 0x1000:0
    mov     ax,         0x1000
    
    ; FAT sectors will be read after the stack space (ES:BX = 0x07C0:0x1000)
    mov     bx,         0x1000
    
    ; Loads the kernel into memory
    call    XEOS.io.fat12.loadFile
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.gdt
    
    ; Installs the GDT
    call    XEOS.gdt.install
    
    ; Prints status message
    @XEOS.boot.stage2.print XEOS.boot.stage2.a20
    
    ; Enables A20 - 20th address line on the address bus to access 4GB of memory
    call    XEOS.a20.enable.bios
    
    ; Time to switch the CPU to 32bits protected mode
    .enterProtectedMode:
    
    ; Prints status messages
    @XEOS.boot.stage2.print XEOS.boot.stage2.pMode
    @XEOS.boot.stage2.print XEOS.boot.stage2.execKernel
    
    ; Clears the interrupts
    cli
    
    ; Gets the value of the primary control register
    mov     eax,        cr0
    
    ; Sets the lowest bit, indicating the system must run in protected mode
    or      eax,        1
    
    ; Sets the new value - We are now in 32bits protected mode
    mov     cr0,        eax
    
    ; We are now in 32 bits realmode
    %undef  $XEOS.cpu.realMode
    
    ; We are doing a far jump using our code descriptor, so CS is fixed
    jmp	    $XEOS.gdt.descriptors.code:.kernelSetup

; We are now in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Moves the kernel to an absolute memory location, as we are now in 32 bits
; protected mode, and executes it
;-------------------------------------------------------------------------------
XEOS.boot.stage2.kernelSetup:
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         $XEOS.gdt.descriptors.data
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    mov     esp,        0x90000
    
    ; We are going to move the kernel at 1Mb in memory
    .moveKernel:
        
        ; Number of sectors that were read to load the kernel at its current
        ; memory location (by the XEOS.io.fat12.loadFile procedure)
        mov     eax, dword [ XEOS.io.fat12.fileSectors ]
        
        ; Number of bytes per sector
        mov     ebx, dword $XEOS.mbr.bytesPerSector
        
        ; Gets the number of bytes to read
        mul     ebx
        
        ; We are going to read doubles, so divides the bytes by 4
        mov     ebx,        4
        div     ebx
        
        ; Actual memory location for the kernel code
        ; 
        ; We loaded it at 0x1000:0 in real mode, so the protected mode
        ; address is 0x10000 (0x1000 * 16 + 0).
        mov     esi,        0x10000
        
        ; Final destination for the kernel code (1MB)
        mov     edi,        0x100000
        
        ; Copies the kernel code
        mov     ecx,        eax
        rep     movsd
    
    ; We can now jump to the kernel code
    jmp     $XEOS.gdt.descriptors.code:0x100000
    
    ; Infinite loop
    jmp     $
