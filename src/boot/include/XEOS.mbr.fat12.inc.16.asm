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
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.asm"        ; General constants

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; MBR - Master Boot Record
; 
; This section is used to create a valid floppy disk MBR (FAT-12)
;-------------------------------------------------------------------------------

; 0x00 (2) - Jumps to the bootloader code (bypass the MBR)
jmp     short   $XEOS.mbr.jump

; 0x02 (1) - Padding
nop

; 0x03 (8) - OEM name
; 
; This value determines in which system disk was formatted
db      $XEOS.mbr.oemName

; 0x0B (2) - Bytes per sector
dw      $XEOS.mbr.bytesPerSector

; 0x0D (1) - Sectors per cluster
db      $XEOS.mbr.sectorsPerCluster

; 0x0E (2) - Reserved sector count
; 
; The number of sectors before the first FAT in the file system image.
; Should be 1 for FAT12/FAT16. Usually 32 for FAT32.
dw      $XEOS.mbr.reservedSectors

; 0x10 (1) - Number of file allocation tables
; Almost always 2
db      $XEOS.mbr.numberOfFat

; 0x11 (2) - Maximum number of root directory entries
; 
; Only used on FAT12 and FAT16, where the root directory is handled specially.
; Should be 0 for FAT32. This value should always be such that the root
; directory ends on a sector boundary (i.e. such that its size becomes a
; multiple of the sector size).
; 224 is typical for floppy disks
dw      $XEOS.mbr.maxRootDirEntries

; 0x13 (2) - Total sectors
dw      $XEOS.mbr.totalSectors

; 0x15 (1) - Media descriptor
; 
; Possible values are:
; 
;   - 0xF0	3.5" Double Sided, 80 tracks per side, 18 or 36 sectors per track
;           (1.44MB or 2.88MB)
;           5.25" Double Sided, 15 sectors per track (1.2MB)
;   - 0xF8	Fixed disk (i.e. Hard disk)
;   - 0xF9	3.5" Double sided, 80 tracks per side, 9 sectors per track (720K)
;           5.25" Double sided, 40 tracks per side, 15 sectors per track (1.2MB)
;   - 0xFA	5.25" Single sided, 80 tracks per side, 8 sectors per track (320K)
;   - 0xFB	3.5" Double sided, 80 tracks per side, 8 sectors per track (640K)
;   - 0xFC	5.25" Single sided, 40 tracks per side, 9 sectors per track (180K)
;   - 0xFD	5.25" Double sided, 40 tracks per side, 9 sectors per track (360K)
;   - 0xFE	5.25" Single sided, 40 tracks per side, 8 sectors per track (160K)
;   - 0xFF	5.25" Double sided, 40 tracks per side, 8 sectors per track (320K)
db      $XEOS.mbr.mediaDescriptor

; 0x16 (2) - Sectors per File Allocation Table for FAT12/FAT16
dw      $XEOS.mbr.sectorsPerFat

; 0x18 (2) - Sectors per track
dw      $XEOS.mbr.sectorsPerTrack

; 0x1A (2) - Number of heads per cylinder
dw      $XEOS.mbr.headsPerCylinder

; 0x1C (4) -  Hidden sectors
dd      $XEOS.mbr.hiddenSectors

; 0x20 (4) - Number of LBA sectors
dd      $XEOS.mbr.lbaSectors

; 0x24 (1) - Physical drive number
db      $XEOS.mbr.driveNumber

; 0x25 (1) - Reserved ("current head")
; 
; In Windows NT bit 0 is a dirty flag to request chkdsk at boot time
; Bit 1 requests surface scan too.
db      $XEOS.mbr.reserved

; 0x26 (1) - Extended boot signature
db      $XEOS.mbr.bootSignature

; 0x27 (4) - Volume ID (serial number)
dd      $XEOS.mbr.volumeId

; 0x2B (11) - Volume label
db      $XEOS.mbr.volumeLabel

; 0x36 - (8) - FAT file system type
; 
; This is not meant to be used to determine drive type, however, some utilities
; use it in this way.
db      $XEOS.mbr.filesystem
