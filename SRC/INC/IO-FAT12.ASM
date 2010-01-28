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
;-------------------------------------------------------------------------------
%ifndef IO_ASM
%define IO_ASM

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "CONSTANTS.ASM"    ; General constants
%include "MACROS.ASM"       ; General macros
%include "BIOS-INT.ASM"     ; BIOS interrupts
%include "ERROR.ASM"        ; Error management
%include "ASCII.ASM"        ; ASCII table

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
; 
;-------------------------------------------------------------------------------
XEOS.io.fat12.findFile:
    
    ret

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.io.fat12.loadFile:
    
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

%endif
