;-------------------------------------------------------------------------------
; XEOS - X86 Experimental Operating System
; 
; Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
; All rights reserved.
; 
; XEOS Software License - Version 1.0 - December 21, 2012
; 
; Permission is hereby granted, free of charge, to any person or organisation
; obtaining a copy of the software and accompanying documentation covered by
; this license (the "Software") to deal in the Software, with or without
; modification, without restriction, including without limitation the rights
; to use, execute, display, copy, reproduce, transmit, publish, distribute,
; modify, merge, prepare derivative works of the Software, and to permit
; third-parties to whom the Software is furnished to do so, all subject to the
; following conditions:
; 
;       1.  Redistributions of source code, in whole or in part, must retain the
;           above copyright notice and this entire statement, including the
;           above license grant, this restriction and the following disclaimer.
; 
;       2.  Redistributions in binary form must reproduce the above copyright
;           notice and this entire statement, including the above license grant,
;           this restriction and the following disclaimer in the documentation
;           and/or other materials provided with the distribution, unless the
;           Software is distributed by the copyright owner as a library.
;           A "library" means a collection of software functions and/or data
;           prepared so as to be conveniently linked with application programs
;           (which use some of those functions and data) to form executables.
; 
;       3.  The Software, or any substancial portion of the Software shall not
;           be combined, included, derived, or linked (statically or
;           dynamically) with software or libraries licensed under the terms
;           of any GNU software license, including, but not limited to, the GNU
;           General Public License (GNU/GPL) or the GNU Lesser General Public
;           License (GNU/LGPL).
; 
;       4.  All advertising materials mentioning features or use of this
;           software must display an acknowledgement stating that the product
;           includes software developed by the copyright owner.
; 
;       5.  Neither the name of the copyright owner nor the names of its
;           contributors may be used to endorse or promote products derived from
;           this software without specific prior written permission.
; 
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
; THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
; PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
; 
; IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
; THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
; WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
; THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
; OF THE POSSIBILITY OF SUCH DAMAGE.
;-------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; IO procedures
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------
%ifndef __XEOS_IO_FAT12_INC_16_ASM__
%define __XEOS_IO_FAT12_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.s"       ; General constants
%include "XEOS.macros.inc.s"          ; General macros
%include "BIOS.int.inc.s"             ; BIOS interrupts
%include "XEOS.ascii.inc.s"           ; ASCII table

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Loads the FAT-12 root directory into memory
; 
; Description:
;       
;       The structure of the FAT-12 root directory is:
;           
;           - 0x00 - 0x07:  File name
;           - 0x08 - 0x0A:  File extension
;           - 0x0B - 0x0B:  File attributes
;           - 0x0C - 0x0C:  Reserved
;           - 0x0D - 0x0D:  Create time - fine resolution
;           - 0x0E - 0x0F:  Create time - hours, minutes and seconds
;           - 0x10 - 0x11:  Create date
;           - 0x12 - 0x13:  Last access date
;           - 0x14 - 0x15:  EA-Index (used by OS/2 and NT)
;           - 0x16 - 0x17:  Last modified time
;           - 0x18 - 0x19:  Last modified date
;           - 0x1A - 0x1B:  First cluster of the file
;           - 0x1C - 0x20:  File size in bytes
;
;       After calling this procedure, the start of the root directory can be
;       accessed in $XEOS.io.fat12.rootDirectoryStart (WORD).
; 
; Input registers:
;       
;       - DI:       The offset at which the root directory will be loaded
;                   (ES:BX)
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
;       - DX:       The starting sector for the data
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.io.fat12.loadRootDirectory:    
    
    ; Saves registers
    pusha
    
    ; Resets registers
    xor     cx,         cx
    xor     dx,         dx
    
    ; An entry of the root directory is 32 bits
    mov     ax,         32
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Multiplies by the maximum number of entries to get the root directory size
        mov     bx,         @XEOS.fat12.mbr.maxRootDirEntries
        mul     bx
        
    %else
        
        ; Multiplies by the maximum number of entries to get the root directory size
        mul     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.maxRootDirEntries ]
        
    %endif
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Number of sectors used by the root directory
        mov     bx,         @XEOS.fat12.mbr.bytesPerSector
        div     bx
        
    %else
        
        ; Number of sectors used by the root directory
        div     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.bytesPerSector ]
        
    %endif
    
    ; Stores the size of the root directory in CX
    xchg    ax,         cx
    
    ; Number of file allocation tables
    mov     al,         @XEOS.fat12.mbr.numberOfFATs
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Multiplies by the number of sectors that a FAT uses
        mov     bx,         @XEOS.fat12.mbr.sectorsPerFAT
        mul     bx
        
    %else
        
        ; Multiplies by the maximum number of entries to get the root directory size
        mul     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.sectorsPerFAT ]
        
    %endif
    
    ; Adds the number of reserved sectors, so we now have the starting
    ; sector of the root directory
    add     ax,         @XEOS.fat12.mbr.reservedSectors
    
    ; Now we can guess and store the starting sector for the data
    mov     WORD [ $XEOS.io.fat12._dataSector ], ax
    add     WORD [ $XEOS.io.fat12._dataSector ], cx
    
    ; Read sectors at ES:DI
    mov     bx,         di
    call    XEOS.io.fat12.readSectors
    
    ; Checks for an error code
    cmp     ax,         0
    je      .success
    
    .error
        
        ; Restores registers
        popa
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
        ret
        
    .success
        
        ; Restores registers
        popa
        
        ; Success - Stores result code in AX
        xor     ax,         ax
        
        ; Stores data sector in DX
        mov     dx,         WORD [ $XEOS.io.fat12._dataSector ]
        
        ret

;-------------------------------------------------------------------------------
; Finds a file name in the FAT-12 root directory
; 
; Note that the root directory must be loaded in memory before calling this
; procedure (see XEOS.io.fat12.loadRootDirectory).
; 
; Input registers:
; 
;       - DI:       The location of the root directory in memory (ES:DI)
;       - SI:       The address of the filename to find
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
;       - DI:       The first cluster of the file
; 
; Killed registers:
;       
;       - CX
;-------------------------------------------------------------------------------
XEOS.io.fat12.findFile:
    
    .start
        
        ; Process each entry of the FAT-12 root directory
        mov     cx,         @XEOS.fat12.mbr.maxRootDirEntries
    
    .loop:
        
        ; Saves registers
        push    cx
        push    di
        push    si
        
        ; A FAT-12 filename is eleven characters long
        mov     cx,         4
        
        ; Compare the strings
        rep     cmpsb
        
        ; Restore registers
        pop     si
        pop     di
        pop     cx
        
        ; Checks for a match
        je      .success
        
        ; Process next entry (32 bytes)
        add     di,         32
        loop    .loop
        
    .failure
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
        ret
        
    .success
        
        ; Success - Stores result code in AX
        xor     ax,         ax
        
        ; Start cluster from the root directory entry (byte 26)
        add     di,         26
        
        ret

;-------------------------------------------------------------------------------
; Loads a file from a FAT-12 drive
; 
; Input registers:
; 
;       - AX:       The segment where the file will be loaded (AX:00)
;       - BX:       The offset of where to load the FAT (ES:BX)
;       - CX:       The location of the first data sector
;       - DI:       The first cluster of the file
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
; 
; Killed registers:
;       
;       - AX
;       - BX
;       - CX
;       - DX
;-------------------------------------------------------------------------------
XEOS.io.fat12.loadFile:
    
    .loadFAT:
        
        ; Saves the location of the first data cluster
        mov     WORD [ $XEOS.io.fat12._fatOffset ],     bx
        
        
        ; Saves the location of the first data cluster
        mov     cx,         WORD [ $XEOS.io.fat12._dataSector ]
        
        ; Saves registers
        push    ax
        push    bx
        
        ; Saves the start cluster of the file
        mov     dx,                                         WORD [ di ]
        mov     WORD [ $XEOS.io.fat12._currentCluster ],    dx
        
        ; Resets AX
        xor     ax,         ax
        
        ; Number of FATs
        mov     al,         @XEOS.fat12.mbr.numberOfFATs
        
        ; Saves a few bytes of code if we can access the MBR variables directly
        %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
            
            ; Multiplies by the number of sectors per FAT
            mov     bx,         @XEOS.fat12.mbr.sectorsPerFAT
            mul     bx
            
        %else
            
            ; Multiplies by the number of sectors per FAT
            mul     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.sectorsPerFAT ]
            
        %endif
        
        ; Stores the FAT size in CX
        mov     cx,         ax
        
        ; Starting sector (bypass the reserved sectors)
        mov     ax,         @XEOS.fat12.mbr.reservedSectors
        
        ; Loads the FAT at ES:BX
        pop     bx
        call    XEOS.io.fat12.readSectors
        
        ; Checks for an error code
        cmp     ax,         0
        je      .fatLoaded
        
        ret
    
    .fatLoaded
        
        ; Segment of the file
        pop     es
        xor     bx,         bx
        
        ; Saves registers
        push    bx
        
    .loadFile:
        
        ; Current cluster
        mov     ax,         WORD [ $XEOS.io.fat12._currentCluster ]
        
        ; Data sector location
        mov     bx,         WORD [ $XEOS.io.fat12._dataSector ]
        
        ; Converts cluster to LBA
        call    XEOS.io.fat12._clusterToLBA
        
        ; Read buffer
        pop     bx
        
        ; Resets CX
        xor     cx,         cx
        
        ; Number of sectors to read
        mov     cl, @XEOS.fat12.mbr.sectorsPerCluster
        
        ; Read sectors
        call    XEOS.io.fat12.readSectors
        
        ; Checks for an error code
        cmp     ax,         0
        je      .success
        
        ret
        
    .success:
        
        ; Restore registers
        push    bx
        
        ; Stores current cluster
        mov     ax, WORD [ $XEOS.io.fat12._currentCluster ]
        mov     cx,         ax
        mov     dx,         ax
        
        ; Divides by two (so we can find if it's even or odd)
        shr     dx,         1
        add     cx,         dx
        
        ; Location of FAT in memory
        mov     bx,         WORD [ $XEOS.io.fat12._fatOffset ]
        
        ; Index in FAT
        add     bx,         cx
        
        ; Get two bytes from the FAT
          mov     dx,       WORD [ bx ]
          
        ; Checks if we are reading an odd or even cluster
        test    ax,         1
        jnz     .odd
          
        .even:
            
            ; Keep low twelve bytes
            and     dx,         0000111111111111b
            jmp     .end
            
        .odd:
            
            ; Keep high twelve bytes
            shr     dx,         4
              
        .end:
            
            ; Stores the start of the new cluster
            mov     WORD [ $XEOS.io.fat12._currentCluster ],    dx
            
            ; Test for EOF
            cmp     dx,         0x0FF0
            
            ; Continues reading
            jb      .loadFile
        
    ; Success - Stores result code in AX
    xor     ax,             ax
    
    ; Restore registers
    pop bx
    
    ret
        
;-------------------------------------------------------------------------------
; Reads sectors from a drive
; 
; Input registers:
;       
;       - AX:       The starting sector
;       - BX:       The read buffer location (ES:BX)
;       - CX:       The number of sectors to read
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
;       - BX:       The read buffer end location (ES:BX), so multiple calls can
;                   be chained whithout adjusting the read buffer
; 
; Killed registers:
;       
;       - CX
;       - DX
;-------------------------------------------------------------------------------
XEOS.io.fat12.readSectors:
    
    ; Saves registers
    push di
    
    .start:
    
        ; Allows five read attempts before returning an error, as we may need
        ; to reset the floppy disk before successfully reading
        mov     di,         5
        
    .loop
        
        ; Saves registers
        pusha
        
        ; Converts the logical block address to cluster, head and cylinder
        ; (needed for int 0x13)
        call    XEOS.io.fat12._lbaToCHS
        
        ; Number of sectors to read
        mov     al,         1
        
        ; BIOS read sector function (for int 0x13)
        mov     ah,         2
        
        ; Track, sector and head parameters
        mov     ch,         BYTE [ $XEOS.io.fat12._absoluteTrack ]
        mov     cl,         BYTE [ $XEOS.io.fat12._absoluteSector ]
        mov     dh,         BYTE [ $XEOS.io.fat12._absoluteHead ]
        
        ; Drive number parameter
        mov     dl,         @XEOS.fat12.mbr.driveNumber
        
        ; Calls the BIOS LLDS
        @BIOS.int.llds
        
        ; Checks the return value
        jnc     .success
        
    .error:
    
        ; Resets the floppy disk
        xor     ax,         ax
        @BIOS.int.llds
        
        ; Decrements the error counter
        dec     di
        
        ; Restores registers
        popa
        
        ; Attempts to read again
        jnz     .loop
        
        ; Restores registers
        pop di
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
    .success
        
        ; Restores registers
        popa
    
        ; Memory area in which the next sector will be read
        add     bx,         @XEOS.fat12.mbr.bytesPerSector
        
        ; Reads the next sector
        inc     ax
        loop    .start
    
    .end:
    
        ; Restores registers
        pop di
        
        ; Success - Stores result code in AX
        xor     eax,        eax
        
        ret

;-------------------------------------------------------------------------------
; Converts a cluster number to LBA (Logical Block Addressing)
; 
; Description:
;   
;       Formula is: LBA = (cluster - 2 ) * sectors per cluster
; 
; Input registers:
;       
;       - AX:       The cluster number to convert
;       - BX:       The start of the FAT-12 root directory
; 
; Return registers:
;       
;       - AX:       The LBA value
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.io.fat12._clusterToLBA:
    
    ; Saves registers
    push cx
    
    ; Substracts 2 to the cluster number
    sub     ax,         2
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Multiplies by the number of sectors per cluster
        mov     cx,         @XEOS.fat12.mbr.sectorsPerCluster
        mul     cx
        
    %else
        
        ; Multiplies by the number of sectors per cluster
        mul     BYTE [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.sectorsPerCluster ]
        
    %endif
    
    ; Adds result value to the start of the FAT-12 root directory
    add     ax,         bx
    
    ; Restores registers
    pop     cx
    
    ret

;-------------------------------------------------------------------------------
; Converts LBA (Logical Block Addressing) to CHS (Cylinder Head Sector)
; 
; Description:
; 
;       The result values will be placed in XEOS.io.fat12.absoluteSector,
;       XEOS.io.fat12.absoluteHead and XEOS.io.fat12.absoluteTrack.
;       
;       absolute sector = (logical sector / sectors per track) + 1
;       absolute head   = (logical sector / sectors per track) % number of heads
;       absolute track  = logical sector / (sectors per track * number of heads)
;       
;       After calling this procedure, converted values can be accessed in:
;           
;           - $XEOS.io.fat12._absoluteSector
;           - $XEOS.io.fat12._absoluteTrack
;           - $XEOS.io.fat12._absoluteHead
; 
; Inpur registers:
;       
;       - AX:       The LBA address to convert
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       - AX
;       - CX
;-------------------------------------------------------------------------------
XEOS.io.fat12._lbaToCHS:
    
    ; Saves registers
    push    dx
    
    ; Clears DX
    xor     dx,         dx
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Divides by the number of sectors per track
        mov     cx,         @XEOS.fat12.mbr.sectorsPerTrack
        div     cx
        
    %else
        
        ; Divides by the number of sectors per track
        div     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.sectorsPerTrack ]
        
    %endif
    
    ; Adds one
    inc     dl
    
    ; Stores the absolute sector
    mov     BYTE [ $XEOS.io.fat12._absoluteSector ],    dl
    
    ; Clears DX
    xor     dx,         dx
    
    ; Saves a few bytes of code if we can access the MBR variables directly
    %ifndef __XEOS_IO_FAT12_MBR_INC_16_ASM__
        
        ; Mod by the number of heads
        mov     cx,         @XEOS.fat12.mbr.headsPerCylinder
        div     cx
        
    %else
        
        ; Divides by the number of sectors per track
        div     WORD [ $XEOS.fat12.mbr + XEOS.fat12.mbr_t.headsPerCylinder ]
        
    %endif
    
    ; Stores the absolute head and absolute track
    mov     BYTE [ $XEOS.io.fat12._absoluteHead ],  dl
    mov     BYTE [ $XEOS.io.fat12._absoluteTrack ], al
    
    ; Restores registers
    pop     dx
    
    ret

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.io.fat12._dataSector              dw  0
$XEOS.io.fat12._absoluteSector          db  0
$XEOS.io.fat12._absoluteHead            db  0
$XEOS.io.fat12._absoluteTrack           db  0
$XEOS.io.fat12._currentCluster          dw  0
$XEOS.io.fat12._fatOffset               dw  0

%endif
