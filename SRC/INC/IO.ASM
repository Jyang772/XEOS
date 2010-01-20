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
%include "BIOS-INT.ASM"     ; BIOS interrupts
%include "ERROR.ASM"        ; Error management
%include "ASCII.ASM"        ; ASCII table

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.io.readSectors:
    
    ; Resets DI, so we can count the number of read tries
    xor     di,         di
    
    .start:
    
    @XEOS.reg.save
    
    ; Resets the floppy controller
    call    BIOS.llds.resetFloppyDrive
    
    ; Read sectors (BIOS low level disk services function)
    mov     ah,         2
    
    ; Number of sectors to read
    mov     al,         1
    
    ; Track number
    mov     ch,         BYTE [XEOS.io.absoluteTrack]
    
    ; Sector number
    mov     cl,         BYTE [XEOS.io.absoluteSector]
    
    ; Head number
    mov     dh,         BYTE [XEOS.io.absoluteHead]
    
    ; Drive number
    mov     dl,         $XEOS.mbr.driveNumber
    
    ; Calls the BIOS low level disk services
    $BIOS.int.llds
    
    ; Checks if an error occued
    jnc     .succes
    
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
    add     bx, WORD [$XEOS.mbr.bytesPerSector]
    
    ; We are now reading the next sector
    inc     ax
    loop    XEOS.io.readSectors
    
    ret
   
;-------------------------------------------------------------------------------
; Converts LBA (Logical Block Addressing) to CHS (Cylinder Head Sector)
; 
; The result values will be placed in absoluteSector, absoluteHead and
; absoluteTrack.
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
XEOS.io.lbaToChs:
    
    @XEOS.reg.save
    
    ; Clears DX
    xor     dx,         dx
    
    ; Divides by the number of sectors per track
    mov     bx,         $XEOS.mbr.sectorsPerTrack
    div     bx
    
    ; Adds one
    inc     dl
    
    ; Stores the absolute sector
    mov     BYTE [XEOS.io.absoluteSector],  dl
    
    ; Clears DX
    xor     dx,         dx
    
    ; Mod by the number of heads
    mov     bx,         $XEOS.mbr.headsPerCylinder
    div     bx
    
    ; Stores the absolute head and absolute track
    mov     BYTE [XEOS.io.absoluteHead],    dl
    mov     BYTE [XEOS.io.absoluteTrack],   al
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

; Storage for the XEOS_boot1_lbaToChs procedure
XEOS.io.absoluteSector      db  0
XEOS.io.absoluteHead        db  0
XEOS.io.absoluteTrack       db  0

%endif
