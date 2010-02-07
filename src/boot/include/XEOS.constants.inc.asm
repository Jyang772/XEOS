;-------------------------------------------------------------------------------
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
;-------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; Constants
;-------------------------------------------------------------------------------

%ifndef __XEOS_CONSTANTS_INC_ASM__
%define __XEOS_CONSTANTS_INC_ASM__

; Standard PC boot signature
%define $BIOS.boot.signature            0xAA55

; Master boot record values
%define $XEOS.mbr.jump                  XEOS.boot.stage1
%define $XEOS.mbr.oemName               "XEOS-0.1"
%define $XEOS.mbr.bytesPerSector        512
%define $XEOS.mbr.sectorsPerCluster     1
%define $XEOS.mbr.reservedSectors       1
%define $XEOS.mbr.numberOfFat           2
%define $XEOS.mbr.maxRootDirEntries     224
%define $XEOS.mbr.totalSectors          2880
%define $XEOS.mbr.mediaDescriptor       0xF8
%define $XEOS.mbr.sectorsPerFat         9
%define $XEOS.mbr.sectorsPerTrack       18
%define $XEOS.mbr.headsPerCylinder      2
%define $XEOS.mbr.hiddenSectors         0
%define $XEOS.mbr.lbaSectors            0
%define $XEOS.mbr.driveNumber           0
%define $XEOS.mbr.reserved              0
%define $XEOS.mbr.bootSignature         41
%define $XEOS.mbr.volumeId              0
%define $XEOS.mbr.volumeLabel           "XEOS-0.1", 32, 32, 32
%define $XEOS.mbr.filesystem            "FAT12", 32, 32, 32

%endif
