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

; We are in 16 bits mode
BITS    16

; Jumps to the effective code section
jmp     XEOS.boot.stage2

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.asm"       ; General constants
%include "XEOS.macros.inc.asm"          ; General macros
%include "BIOS.int.inc.asm"             ; BIOS interrupts
%include "BIOS.video.inc.16.asm"        ; BIOS video services
%include "BIOS.llds.inc.16.asm"         ; BIOS low-level disk services
%include "XEOS.io.fat12.inc.16.asm"     ; FAT-12 IO procedures
%include "XEOS.ascii.inc.asm"           ; ASCII table
%include "XEOS.gdt.inc.asm"             ; GDT - Global Descriptor Table
%include "XEOS.a20.inc.16.asm"          ; 20th address line enabling
%include "XEOS.elf.inc.16.asm"          ; ELF support

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Prints a new line with a message, prefixed by the prompt
%macro @XEOS.boot.stage2.print 1
    
    @BIOS.video.print    XEOS.boot.stage2.prompt
    @BIOS.video.print    %1
    @BIOS.video.print    XEOS.boot.stage2.nl
    
%endmacro

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

XEOS.files.kernel               db  'KERNEL  ELF'
XEOS.boot.stage2.nl             db   $ASCII.NL,  $ASCII.NUL
XEOS.boot.stage2.hr             db  '         --------------------------------------------------------------------', $ASCII.NL, $ASCII.NUL
XEOS.boot.stage2.prompt         db  '<BOOT2>: ', $ASCII.NUL
XEOS.boot.stage2.revision       db  '         $Revision$', $ASCII.NL, $ASCII.NUL
XEOS.boot.stage2.date           db  '         $Date$', $ASCII.NL, $ASCII.NUL
XEOS.boot.stage2.greet          db  'Entering the second stage bootloader...', $ASCII.NUL
XEOS.boot.stage2.gdt            db  'Installing the global descriptor table - GDT...', $ASCII.NUL
XEOS.boot.stage2.a20            db  'Enabling the A-20 address line...', $ASCII.NUL
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
    
    ; Prints status messages
    @BIOS.video.print       XEOS.boot.stage2.nl
    @XEOS.boot.stage2.print XEOS.boot.stage2.greet
    @BIOS.video.print       XEOS.boot.stage2.hr
    @BIOS.video.print       XEOS.boot.stage2.revision
    @BIOS.video.print       XEOS.boot.stage2.date
    @BIOS.video.print       XEOS.boot.stage2.nl
    @XEOS.boot.stage2.print XEOS.boot.stage2.loadKernel
    
    ; Name of the kernel file
    mov     si,             XEOS.files.kernel
    
    ; We are going to load the kernel at 0x1000:0
    mov     ax,             0x1000
    
    ; Buffer will be placed after the stack space (ES:BX = 0x07C0:0x1000).
    mov     bx,             0x1000
    
    ; Loads the kernel file
    call    XEOS.elf.load
    
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
    
    ; We are doing a far jump using our code descriptor
    ; 
    ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
    jmp	    $XEOS.gdt.descriptors.code.kernel:.kernelSetup

; We are now in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Moves the kernel to an absolute memory location, as we are now in 32 bits
; protected mode, and executes it
;-------------------------------------------------------------------------------
XEOS.boot.stage2.kernelSetup:
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         $XEOS.gdt.descriptors.data.kernel
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
        add     esi,        0x1000
        
        ; Final destination for the kernel code (1MB)
        mov     edi,        0x100000
        
        ; Copies the kernel code
        mov     ecx,        eax
        rep     movsd
    
    ; We can now jump to the kernel code
    jmp     $XEOS.gdt.descriptors.code.kernel:0x100000
    
    ; Infinite loop
    jmp     $
