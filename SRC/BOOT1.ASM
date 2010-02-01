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
; XEOS first stage bootloader
; 
; The binary form of this file must no be larger than 512 bytes (one sector).
; The last two bytes have to be the standard PC boot signature (0xAA55).
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
; 
; It can then be copied to a floppy disk image (as it contains a valid MBR):
; 
;       - dd -conv=notrunc if=[bin] of=[floppy]
;-------------------------------------------------------------------------------

; Forces the 16 bits mode for the BIOS
BITS    16

; We are in 16 bits real mode
%ifndef $XEOS.cpu.realMode    
%define $XEOS.cpu.realMode 1
%endif

; Includes the FAT-12 MBR, so the beginning of the binary will be a valid
; FAT-12 floppy drive
%include "MBR-FAT12.ASM"

;-------------------------------------------------------------------------------
; First stage bootloader
; 
; This section is the bootloader's code that will be runned by the BIOS.
; 
; At this time, the memory layout is the following:
; 
;       - 0x0000 - 0x003F:  ISR vectors addresses (Interrupt Service Routine)
;       - 0x0040 - 0x004F:  BIOS data
;       - 0x0050 - 0x07BF:  Free
;       - 0x07C0 - 0x07DF:  Bootloader
;       - 0x07CE - 0x9FFF:  Free
;       - 0xA000 - 0xBFFF:  BIOS video sub-system
;       - 0xC000 - 0xEFFF:  BIOS ROM
;       - 0xF000 - 0xFFFF:  System ROM
; 
; Note that those addresses uses the segment:offset addressing mode:
; 
;   base address = base address * segment size (16) + offset
; 
; So 0x07C0 is 0x07C0:0 which is 0x07C00.
;-------------------------------------------------------------------------------

XEOS.boot.stage1:
    
    ; Jumps to the effective code (bypasses the includes)
    jmp     .start
    
    ;---------------------------------------------------------------------------
    ; Includes
    ;
    ; Placed here to avoid problems with the MBR short jump.
    ;---------------------------------------------------------------------------
    %include "MACROS.ASM"       ; General macros
    %include "IO-FAT12.ASM"     ; FAT-12 IO procedures
    %include "BIOS-INT.ASM"     ; BIOS interrupts
    %include "BIOS-VIDEO.ASM"   ; BIOS video services
    %include "BIOS-LLDS.ASM"    ; BIOS low-level disk services
    %include "ASCII.ASM"        ; ASCII table
    
    ; We are redefining 'XEOS.boot.stage1', as the include files are declaring
    ; global procedures
    XEOS.boot.stage1.start:
    
    ; Clears the interrupts as we are setting-up the segments and stack space
    cli
    
    ; Sets the data and extra segments to where we were loaded by the BIOS
    ; (0x07C0), so we don't have to add 0x07C0 to all our data
    mov     ax,         0x07C0
    mov     ds,         ax
    mov     es,         ax
    
    ; Sets up the of stack space
    xor     ax,         ax
    mov     ss,         ax
    mov     sp,         0xFFFF
    
    ; Restores the interrupts
    sti
    
    ; Prints the greeting
    @BIOS.video.print   XEOS.boot.stage1.greet
    
    ; The first bootloader is limited to 512 bytes, we we need to load a
    ; second stage bootloader to efficienttly load the kernel
    .findSecondStage:
    
    ; Loads the root directory into memory
    ; 
    ; Sectors will be read after the stack space (ES:BX = 0x07C0:0x1000).
    mov     bx,         0x1000
    call    XEOS.io.fat12.loadRootDirectory
    
    ; Location of the data we read into memory
    mov     di,         0x1000
    
    ; Name of the second stage bootloader file
    mov     si,         XEOS.files.stage2
    
    ; Tries to find the second stage bootloader file in the root directory
    call    XEOS.io.fat12.findFile
    
    ; We are going to load the second stage bootloader at the top of the free
    ; memory (0x50:0 => 0x0500)
    mov     ax,         0x50
    
    ; FAT sectors will be read after the stack space (ES:BX = 0x07C0:0x1000)
    mov     bx,         0x1000
    
    ; Loads the second stage bootloader into memory
    call    XEOS.io.fat12.loadFile
    
    ; End of file detected, so the second stage bootloader file has been
    ; completely loaded into memory
    .executeSecondStage:
    
    ; Pushes the instruction pointer (IP) and code segment (CS) on the stack
    push    WORD 0x0050
    push    WORD 0x0000
    
    ; Executes the second stage bootloader
    retf
    
    ; Infinite loop
    jmp     $
    
;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Strings
XEOS.files.stage2           db  'BOOT2   BIN'
XEOS.boot.stage1.greet      db  $ASCII.NL,\
                                'XEOS BOOT',\
                                $ASCII.NL, $ASCII.NUL

;-------------------------------------------------------------------------------
; Ends of the boot sector
;-------------------------------------------------------------------------------

; Pads the remainder of the boot sector with '0', so we'll be able to write the
; boot signature
times   510 - ( $ - $$ ) db  $ASCII.NUL

; 0x1FE (2) - Boot sector signature
dw      $BIOS.boot.signature
