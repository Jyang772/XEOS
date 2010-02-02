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
; IO procedures
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------
%ifndef __IO_FAT12_INC_16_ASM__
%define __IO_FAT12_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "CONSTANTS.INC.ASM"        ; General constants
%include "MACROS.INC.ASM"           ; General macros
%include "BIOS-INT.INC.ASM"         ; BIOS interrupts
%include "ERROR.INC.16.ASM"         ; Error management
%include "ASCII.INC.ASM"            ; ASCII table
%include "BIOS-LLDS.INC.16.ASM"     ; BIOS low-level disk services

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.io.fat12.readSectors:
    
    ; Resets DI, so we can count the number of read tries
    xor     di,         di
    
    .start:
    
    @XEOS.reg.save
    
    ; Converts the logical block address to cluster, head and cylinder
    ; (needed for int 0x13)
    call    XEOS.io.fat12.lbaToChs
    
    ; Read sectors (BIOS low level disk services function)
    mov     ah,         2
    
    ; Number of sectors to read
    mov     al,         1
    
    ; Track number
    mov     ch,         BYTE [ XEOS.io.fat12.absoluteTrack ]
    
    ; Sector number
    mov     cl,         BYTE [ XEOS.io.fat12.absoluteSector ]
    
    ; Head number
    mov     dh,         BYTE [ XEOS.io.fat12.absoluteHead ]
    
    ; Drive number
    mov     dl,         $XEOS.mbr.driveNumber
    
    ; Calls the BIOS low level disk services
    $BIOS.int.llds
    
    ; Checks if an error occued
    jnc     .succes
    
    ; Resets the floppy controller
    call    BIOS.llds.resetFloppyDrive
    
    @XEOS.reg.save
    
    ; Increases the number of read tries
    inc     di
    
    ; 5 possible retries, in case of error
    cmp     di,         5
    
    ; Tries to reset again
    jb     .start
    
    ; 5 retries - Fatal error
    call    XEOS.error.fatal
    
    .succes:
    
    @XEOS.reg.restore
    
    ; Memory area in which the next sector will be read
    add     bx,         WORD $XEOS.mbr.bytesPerSector
    
    ; We are now reading the next sector
    inc     ax
    loop    XEOS.io.fat12.readSectors
    
    ret
   
;-------------------------------------------------------------------------------
; Converts LBA (Logical Block Addressing) to CHS (Cylinder Head Sector)
; 
; The result values will be placed in XEOS.io.fat12.absoluteSector,
; XEOS.io.fat12.absoluteHead and XEOS.io.fat12.absoluteTrack.
; 
; Formulas:
;   
;   absolute sector = (logical sector / sectors per track) + 1
;   absolute head   = (logical sector / sectors per track) % number of heads
;   absolute track  = logical sector / (sectors per track * number of heads)
; 
; Necessary register values:
;       
;       - ax:       The LBA address to convert
;-------------------------------------------------------------------------------
XEOS.io.fat12.lbaToChs:
    
    @XEOS.reg.save
    
    ; Clears DX
    xor     dx,         dx
    
    ; Divides by the number of sectors per track
    mov     bx,         $XEOS.mbr.sectorsPerTrack
    div     bx
    
    ; Adds one
    inc     dl
    
    ; Stores the absolute sector
    mov     BYTE [ XEOS.io.fat12.absoluteSector ],    dl
    
    ; Clears DX
    xor     dx,         dx
    
    ; Mod by the number of heads
    mov     bx,         $XEOS.mbr.headsPerCylinder
    div     bx
    
    ; Stores the absolute head and absolute track
    mov     BYTE [ XEOS.io.fat12.absoluteHead ],  dl
    mov     BYTE [ XEOS.io.fat12.absoluteTrack ], al
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Converts a cluster number to LBA (Logical Block Addressing)
; 
; The result values will be placed in AX.
; 
; Formula:
;   
;   LBA	= (cluster - 2 ) * sectors per cluster
; 
; Necessary register values:
;       
;       - ax:       The cluster number to convert
;-------------------------------------------------------------------------------
XEOS.io.fat12.clusterToLba:
    
    ; Saves the vaue of CX as we are going to use it
    push    cx
    
    ; Substracts 2 to the cluster number
    sub     ax,         2
    
    ; Resets CS
    xor     cx,         cx
    
    ; Multiplies by the number of sectors per cluster
    mov     cl,         BYTE $XEOS.mbr.sectorsPerCluster
    mul     cx
    
    ; Restores CX
    pop     cx
    
    ret

;-------------------------------------------------------------------------------
; Loads the FAT-12 root directory into memory
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
; 
; Necessary register values:
;       
;       - bx:       The offset at which the root directory will be loaded
;                   (will be ES:BX)
;-------------------------------------------------------------------------------
XEOS.io.fat12.loadRootDirectory:
    
    @XEOS.reg.save
    
    ; Saves BX as we are going to alter it
    push    bx
    
    ; An entry of the root directory is 32 bits
    mov     ax,         0x20
    
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
    mov     [ XEOS.io.fat12.rootDirectoryStart ], ax
    add     [ XEOS.io.fat12.rootDirectoryStart ], cx
    
    ; Restores BX
    pop     bx
    
    ; Reads the necessary sectors to load the root directory into memory
    call    XEOS.io.fat12.readSectors
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Finds a file name in the FAT-12 root directory
; 
; Note that the root directory must be loaded in memory before calling this
; procedure (see XEOS.io.fat12.loadRootDirectory).
; If the file name is found, its starting cluster will be saved in
; XEOS.io.fat12.firstDataCluster. Otherwise, a fatal error will occure.
; 
; Necessary register values:
; 
;       - DI:       The offset at which the root directory is loaded
;       - SI:       The address of the filename to find
;-------------------------------------------------------------------------------
XEOS.io.fat12.findFile:
    
    @XEOS.reg.save
    
    ; Number of entries to read
    mov     cx,         WORD $XEOS.mbr.maxRootDirEntries
    
    ; We are going to loop through the root directory entries to find the name
    ; of the file
    .readRootDirectoryLoop:
    
    ; Saves the loop counter
    push    cx
    
    ; FAT12 filenames are limited to 11 characters
    mov     cx,         0x0B
    
    ; Saves the memory address containing the file name
    push    si
    
    ; Saves the memory address in which the root directory was loaded
    push    di
    
    ; Tries to find the name of the file
    rep     cmpsb
    
    ; Restores the address of the data we are reading
    pop     di
    
    ; Restores the address of the file name
    pop     si
    
    ; Restores the loop counter
    pop     cx
    
    ; The file was found - We are going to load it
    je      .found
    
    ; Address of the next entry
    add     di,         0x20
    
    ; Reads the next entry
    loop    .readRootDirectoryLoop
    
    ; The file was not found - Issues a fatal error
    call    XEOS.error.fatal
    
    .found
    
    ; Saves the first cluster of the file (first cluster is located at location
    ; 0x1A of a root directory entry)
    mov     ax,         WORD [ di + 0x1A ]
    mov     WORD [ XEOS.io.fat12.firstDataCluster ],    ax 
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Loads a file into memory
; 
; Note that the address of first cluster of the file must be present in
; XEOS.io.fat12.firstDataCluster. See XEOS.io.fat12.findFile to know how to
; find a file.
; 
; Necessary register values:
; 
;       - AX:       The memory address from which to load the file (will be
;                   placed in ES, so the real address will be AX:0)
;       - BX:       The offset at which to load the file allocation table
;                   (will be ES:BX)
;-------------------------------------------------------------------------------
XEOS.io.fat12.loadFile:
    
    @XEOS.reg.save
    
    ; Saves the values of AX and BX (addresses for the read operations)
    push    ax
    push    bx
    
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
    
    pop     bx
    
    ; Reads the necessary sectors to load the FAT into memory
    call    XEOS.io.fat12.readSectors
    
    ; Memory location at which to load the file
    pop     ax
    mov     es,         ax
    xor     bx,         bx
    
    ; Saves the value of BX
    push    bx
    
    mov     [ XEOS.io.fat12.fileSectors ],  WORD 0
    
    .read:
    
    ; We are going to read from the first cluster of the file
    mov     ax,         WORD [ XEOS.io.fat12.firstDataCluster ]
    
    ; Restores the offset of the read operation
    pop     bx
    
    ; Converts the cluster number to a logical block address
    call    XEOS.io.fat12.clusterToLba
    add     ax, WORD [ XEOS.io.fat12.rootDirectoryStart ]
    
    ; Number of sectors to read
    xor     cx,         cx
    mov     cl, BYTE $XEOS.mbr.sectorsPerCluster
    
    ; Reads the necessary sectors to load the file into memory
    call    XEOS.io.fat12.readSectors
    
    inc     WORD [ XEOS.io.fat12.fileSectors ]
    
    ; Saves the offset of the read operation
    push    bx
    
    mov     ax,         WORD [ XEOS.io.fat12.firstDataCluster ]
    mov     cx,         ax
    mov     dx,         ax
    shr     dx,         1
    add     cx,         dx
    mov     bx,         0x1000
    add     bx,         cx
    mov     dx,         WORD [ bx ]
    test    ax,         1
    
    jnz     .clusterOdd
    
    .clusterEven:
    
    ; Low twelve bits
    and     dx,         0000111111111111b
    jmp     .nextCluster
    
    .clusterOdd:
    
    ; Hight twelve bits
    shr     dx,         4
    
    .nextCluster:
    
    mov     WORD [ XEOS.io.fat12.firstDataCluster ],    dx
    
    ; Checks for the end of the file
    cmp     dx,         0x0FF0
    
    ; Continues loading the file, as there is still data to read
    jb      .read
    
    ; The value of BX is still on the stack, but we don't need it anymore
    pop     bx
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Storage for the XEOS.io.fat12.lbaToChs procedure
XEOS.io.fat12.absoluteSector        db  0
XEOS.io.fat12.absoluteHead          db  0
XEOS.io.fat12.absoluteTrack         db  0

; Storage for the XEOS.io.fat12.loadRootDirectory procedure
XEOS.io.fat12.rootDirectoryStart    dw  0

; Storage for the XEOS.io.fat12.findFile procedure
XEOS.io.fat12.firstDataCluster      dw  0

; Storage for the XEOS.io.fat12.loadFile procedure
XEOS.io.fat12.fileSectors           dw  0

%endif
