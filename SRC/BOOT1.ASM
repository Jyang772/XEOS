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
;       - 0x7CE0 - 0x9FFF:  Free
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
    
    ;-------------------------------------------------------------------------------
    ; Includes
    ;
    ; Placed here to avoid problems with the MBR short jump.
    ;-------------------------------------------------------------------------------
    %include "MACROS.ASM"       ; General macros
    %include "IO.ASM"           ; IO procedures
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
    ; (07C0h), so we don't have to add 07C0h to all our data
    mov     ax,         07C0h
    mov     ds,         ax
    mov     es,         ax
    
    ; Sets up 4KB of stack space after this bootloader
    xor     ax,         ax
    mov     ss,         ax
    mov     sp,         4096
    
    ; Restores the interrupts
    sti
    
    ; Saves the boot device number
    mov     dl,         $XEOS.mbr.driveNumber
    
    ; Clears the screen
    @BIOS.video.clearScreen $BIOS.video.colors.white, $BIOS.video.colors.lightGray
    
    ; Prints the greeting
    @BIOS.video.print   XEOS.boot.stage1.greet
    
    ; The first bootloader is limited to 512 bytes, we we need to load a
    ; second stage bootloader to efficienttly load the kernel
    .findSecondStage:
    
    ; Loads the root directory of the floppy
    ; 
    ; The structure of the FAT-12 root directory is:
    ; 
    ;       - 0x00 - 0x07:  File name
    ;       - 0x08 - 0x0A:  File extension
    ;       - 0x0B - 0x0B:  File attributes
    ;       - 0x0C - 0x0C:  Reserved
    ;       - 0x0D - 0x0D:  Create time - fine resolution
    ;       - 0x0E - 0x0F:  Create time - hours, minutes and seconds
    ;       - 0x10 - 0x11:  Create date
    ;       - 0x12 - 0x13:  Last access date
    ;       - 0x14 - 0x15:  EA-Index (used by OS/2 and NT)
    ;       - 0x16 - 0x17:  Last modified time
    ;       - 0x18 - 0x19:  Last modified date
    ;       - 0x1A - 0x1B:  First cluster of the file
    ;       - 0x1C - 0x20:  File size in bytes
    .loadRootDirectory
    
    ; An entry of the root directory is 32 bits
    mov     ax,         32
    
    ; Number of root directory entries
    mov     bx,         $XEOS.mbr.maxRootDirEntries
    mul     WORD bx
    
    ; Number of sectors used by the root directory
    mov     bx,         $XEOS.mbr.bytesPerSector
    div     bx
    
    ; Stores the size of the root directory in CX
    xchg    cx,         ax
    
    ; Number of file allocation tables
    mov     al,         $XEOS.mbr.numberOfFat
    
    ; Multiplies by the number of sectors that a FAT uses
    mov     bx,         $XEOS.mbr.sectorsPerFat
    mul     bx
    
    ; Adds the number of reserved sectors, so we now have the starting
    ; sector of the root directory
    add     ax,         $XEOS.mbr.reservedSectors
    
    ; Now we can guess and store the starting sector for the data
    mov     [ XEOS.boot1.dataSectorStart ], ax
    add     [ XEOS.boot1.dataSectorStart ], cx
    
    ; Sectors will be read after the stack space (ES:BX = 07C0h:4096)
    mov     bx,         4096
    
    ; Reads the necessary sectors to load the root directory into memory
    call    XEOS.io.readSectors
    
    ; Reads the root directory
    ; 
    ; The content of the root directory is now in memory, just after this
    ; bootloader.
    ; We are going to read it to find the second stage bootloader.
    .readRootDirectory:
    
    ; Location of the data we read into memory
    mov     di,         4096
    
    ; Number of entries to read
    mov     cx,         WORD $XEOS.mbr.maxRootDirEntries
    
    ; We are going to loop through the root directory entries to find the name
    ; of the second stage bootloader file
    .readRootDirectoryLoop:
    
    ; Saves the loop counter
    push    cx
    
    ; FAT12 filenames are limited to 11 characters
    mov     cx,         11
    
    ; Name of the second stage bootloader file
    mov     si,         XEOS.files.stage2
    
    ; Saves the memory address in which the root directory was loaded
    push    di
    
    ; Tries to find the name of the second stage bootloader
    rep     cmpsb
    
    ; Restores the address of the data we are reading
    pop     di
    
    ; The file was found - We are going to load it
    je      .loadSecondStage
    
    ; Restores the loop counter
    pop     cx
    
    ; Address of the next entry
    add     di,         32
    
    ; Reads the next entry
    loop    .readRootDirectoryLoop
    
    ; The second stage bootloader was not found - Issues a fatal error
    call    XEOS.error.fatal
    
    ; At this time, the second stage bootloader has been located in the root
    ; directory
    .loadSecondStage:
    
    ; Saves the first cluster of the second stage bootloader (first cluster
    ; is located at location 0x1A of a root directory entry)
    mov     ax,         WORD [ di ]
    add     ax,         1Ah
    mov     WORD [ XEOS.boot1.boot2Cluster ], dx 
    
    ; We now have to read the file allocation table
    .readFat:
    
    ; Resets AX
    xor     ax,         ax
    
    ; Number of file allocation tables
    mov     al,         BYTE $XEOS.mbr.numberOfFat
    
    ; Multiplies by the number of sectors that a FAT uses
    mov     cx,         $XEOS.mbr.sectorsPerFat
    mul     cx
    
    ; Stores the size of the FAT in CX
    mov     cx,         ax
    
    ; Location of the FAT
    mov     ax, WORD $XEOS.mbr.reservedSectors
    
    ; Sectors will be read after the stack space (ES:BX = 07C0h:4096)
    mov     bx,         4096
    
    ; Reads the necessary sectors to load the FAT into memory
    call    XEOS.io.readSectors
    
    ; Infinite loop
    jmp     $
    
;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Strings
XEOS.files.stage2           db  'BOOT2   BIN'
XEOS.boot.stage1.greet      db  $ASCII.NL,\
                                'Booting XEOS...',\
                                $ASCII.NL, $ASCII.NUL

; Start of the floppy data sector
XEOS.boot1.dataSectorStart  dw  0

; First cluster of the second stage bootloader
XEOS.boot1.boot2Cluster     dw  0

;-------------------------------------------------------------------------------
; Ends of the boot sector
;-------------------------------------------------------------------------------

; Pads the remainder of the boot sector with '0', so we'll be able to write the
; boot signature
times   510 - ( $ - $$ ) db  $ASCII.NUL

; 0x1FE (2) - Boot sector signature
dw      $BIOS.boot.signature
