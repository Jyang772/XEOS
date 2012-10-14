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
;       - nasm -f bin -o [boot.flp] [boot.s]
;       - yasm -f bin -o [boot.flp] [boot.s]
;-------------------------------------------------------------------------------

; Location at which we were loaded by the first stage bootloader (0x50:0)
ORG     0

; We are in 16 bits mode
BITS    16

; Jumps to the entry point
start: jmp main

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.s"       ; General constants
%include "XEOS.macros.inc.s"          ; General macros
%include "BIOS.int.inc.s"             ; BIOS interrupts
%include "BIOS.video.inc.16.s"        ; BIOS video services
%include "XEOS.io.fat12.inc.16.s"     ; FAT-12 IO procedures
%include "XEOS.ascii.inc.s"           ; ASCII table
%include "XEOS.cpu.inc.16.s"          ; CPU informations
%include "XEOS.gdt.inc.s"             ; GDT - Global Descriptor Table

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Prints a new line with a message, prefixed by the prompt
%macro @XEOS.boot.stage2.print 1
    
    push                si
    @BIOS.video.print   $XEOS.boot.stage2.msg.prompt
    @BIOS.video.print   %1
    @BIOS.video.print   $XEOS.boot.stage2.nl
    pop                 si
    
%endmacro

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.dataSector                dw  0
$XEOS.boot.stage2.nl                        db  @ASCII.NL,  @ASCII.NUL
$XEOS.files.kernel.32                       db  "XEOS32  BIN", @ASCII.NUL
$XEOS.files.kernel.64                       db  "XEOS64  BIN", @ASCII.NUL
$XEOS.boot.stage2.cpu.vendor                db  "            ", @ASCII.NUL
$XEOS.boot.stage2.longMonde                 db  0

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.msg.prompt                db  "[ XEOS ]> ", @ASCII.NUL
$XEOS.boot.stage2.msg.quote                 db  '"', @ASCII.NUL
$XEOS.boot.stage2.msg.greet                 db  "Entering the second stage bootloader:", @ASCII.NUL
$XEOS.boot.stage2.msg.hr                    db  "          ---------------------------------------------------------------------", @ASCII.NL, @ASCII.NUL
$XEOS.boot.stage2.msg.xeos                  db  "          XEOS - x86 Experimental Operating System", @ASCII.NL, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1           db  "          Copyright (c) 2010-2012 Jean-David Gadina <macmade@eosgarden.com>", @ASCII.NL, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.2           db  "          All Rights Reserved", @ASCII.NL, @ASCII.NUL
$XEOS.boot.stage2.msg.cpu                   db  "Getting CPU informations:", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.vendor            db  "              - CPU vendor:            ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type              db  "              - CPU type:              ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions      db  "              - CPU instruction set:   ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.32           db  "i386", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.64           db  "x86_64", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.32   db  "32 bits", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.64   db  "64 bits", @ASCII.NUL
$XEOS.boot.stage2.msg.32                    db  "XEOS will run in 32 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.64                    db  "XEOS will run in 64 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.load           db  "Preparing to load the XEOS kernel", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.root            db  "Loading the FAT-12 root directory into memory", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.find            db  "Locating the XEOS kernel file: ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.load            db  "Loading the XEOS kernel into memory: 0x1000:0000", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify         db  "Verifiying the XEOS kernel image", @ASCII.NUL
$XEOS.boot.stage2.msg.gdt                   db  "Installing the GDT", @ASCII.NUL
$XEOS.boot.stage2.msg.a20                   db  "Enabling the A-20 address line", @ASCII.NUL
$XEOS.boot.stage2.msg.switch32              db  "Switching the CPU to 32 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.switch64              db  "Switching the CPU to 64 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.error                 db  "Press any key to reboot", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.dir       db  "Error: cannot load the FAT-12 root directory",@ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.find      db  "Error: file not found", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.load      db  "Error: cannot load the requested file", @ASCII.NUL

;-------------------------------------------------------------------------------
; Second stage bootloader
; 
; This section is the bootloader's code that will be runned by first stage
; bootloader, and which is reponsible to setup and load the XEOS kernel
; 
; At this time, the memory layout is the following:
; 
;       - 0x0000 - 0x003F:  ISR vectors addresses (Interrupt Service Routine)
;       - 0x0040 - 0x004F:  BIOS data
;       - 0x0050 - 0x07BF:  Second stage bootloader
;       - 0x07C0 - 0x07DF:  First stage bootloader
;       - 0x07CE - 0x9FFF:  Free
;       - 0xA000 - 0xBFFF:  BIOS video sub-system
;       - 0xC000 - 0xEFFF:  BIOS ROM
;       - 0xF000 - 0xFFFF:  System ROM
; 
; Note that those addresses uses the segment:offset addressing mode:
; 
;       base address = base address * segment size (16) + offset
; 
; So 0x07C0 is 0x07C0:0 which is 0x07C00.
;-------------------------------------------------------------------------------
main:
    
    .start:
        
        ; Clears the interrupts as we are setting-up the segments and stack space
        cli
        
        ; Sets the data and extra segments to where we were loaded by the first
        ; stage bootloader (0x50), so we don't have to add 0x50 to all our data
        mov     ax,         0x50
        mov     ds,         ax
        mov     es,         ax
        mov     fs,         ax
        mov     gs,         ax
        
        ; Sets up the of stack space
        xor     ax,         ax
        mov     ss,         ax
        mov     sp,         0xFFFF
        
        ; Restores the interrupts
        sti
        
        ; Prints the welcome message
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.greet
        @BIOS.video.print       $XEOS.boot.stage2.msg.hr
        @BIOS.video.print       $XEOS.boot.stage2.msg.xeos
        @BIOS.video.print       $XEOS.boot.stage2.nl
        @BIOS.video.print       $XEOS.boot.stage2.msg.copyright.1
        @BIOS.video.print       $XEOS.boot.stage2.msg.copyright.2
        @BIOS.video.print       $XEOS.boot.stage2.msg.hr
        
    .cpu:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.cpu
        
        ; Gets the CPU vendor ID
        push    di
        mov     di,     $XEOS.boot.stage2.cpu.vendor 
        call    XEOS.cpu.vendor
        
        @BIOS.video.print   $XEOS.boot.stage2.msg.cpu.vendor
        @BIOS.video.print   di
        @BIOS.video.print   $XEOS.boot.stage2.nl
        pop                 di
        
        ; Checks if the CPU has 64 bits capabilities
        call    XEOS.cpu.64
        cmp     ax,         1
        je      .x86_64
    
    .i386:
        
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.type
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.type.32
        @BIOS.video.print       $XEOS.boot.stage2.nl
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.instructions
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.instructions.32
        @BIOS.video.print       $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.32
        
        ; 32 bits kernel is going to be loaded
        mov     si,             $XEOS.files.kernel.32
        
        ; We won't switch to 64 bits long mode
        mov     BYTE [ $XEOS.boot.stage2.longMonde ],   0
        
        jmp     .load
        
    .x86_64:
        
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.type
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.type.64
        @BIOS.video.print       $XEOS.boot.stage2.nl
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.instructions
        @BIOS.video.print       $XEOS.boot.stage2.msg.cpu.instructions.64
        @BIOS.video.print       $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.64
        
        ; 64 bits kernel is going to be loaded
        mov     si,             $XEOS.files.kernel.64
        
        ; We'll need to switch to 64 bits long mode
        mov     BYTE [ $XEOS.boot.stage2.longMonde ],   1
        
    .load:
        
        ; Loads the XEOS kernel into memory
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.load
        call                    XEOS.boot.stage2.kernel.load
        
        cmp     ax,         1
        je      .error.fat12.dir
        
        cmp     ax,         2
        je      .error.fat12.find
        
        cmp     ax,         3
        je      .error.fat12.load
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify
    
    .gdt:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.gdt
        call                    XEOS.gdt.install
        
    .a20:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20
    
    ; Checks if we must switch the CPU to 64 bits long mode
    cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
    je      .switch64
        
    .switch32:
            
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch32
        
        ; Not ready yet...
        jmp     .end
        
        ; Clears the interrupts
        cli
        
        ; Gets the value of the primary control register
        mov     eax,        cr0
        
        ; Sets the lowest bit, indicating the system must run in protected mode
        or      eax,        1
        
        ; Sets the new value - We are now in 32bits protected mode
        mov     cr0,        eax
            
    .switch64:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch64
        
        ; Not ready yet...
        jmp     .end
        
        ; Clears the interrupts
        cli
        
        ; Gets the value of the primary control register
        mov     eax,        cr0
        
        ; Sets the lowest bit, indicating the system must run in protected mode
        or      eax,        1
        
        ; Sets the new value - We are now in 32bits protected mode
        mov     cr0,        eax
    
    .error.fat12.dir:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error.fat12.dir
        jmp                     .error
    
    .error.fat12.find:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error.fat12.find
        jmp                     .error
    
    .error.fat12.load:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error.fat12.load
        jmp                     .error
    
    .error:
        
        ; Prints the error message
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error
        
        ; Waits for a key press
        xor     ax,         ax
        @BIOS.int.keyboard
        
        ; Reboot the computer
        @BIOS.int.reboot
    
    .end:
        
        ; Halts the system
        cli
        hlt

;-------------------------------------------------------------------------------
; Loads the XEOS kernel file into memory
; 
; Inpur registers:
;       
;       - SI:       The name of the kernel file to load
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.boot.stage2.kernel.load:
    
    .start:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.fat12.root
        
        ; Saves registers
        push    di
        push    si
        
        ; Loads the FAT-12 root directory at ES:0x1000
        mov     di,         0x1000
        call    XEOS.io.fat12.loadRootDirectory
        
        ; Checks for an error code
        cmp     ax,         0
        je      .findFile
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
        ; Restore registers
        pop     si
        pop     di
        
        ret
    
    .findFile:
        
        ; Prints the name of the kernel file
        @BIOS.video.print   $XEOS.boot.stage2.msg.prompt
        @BIOS.video.print   $XEOS.boot.stage2.msg.fat12.find
        @BIOS.video.print   $XEOS.boot.stage2.msg.quote
        pop                 si
        push                si
        call                BIOS.video.print
        @BIOS.video.print   $XEOS.boot.stage2.msg.quote
        @BIOS.video.print   $XEOS.boot.stage2.nl
        pop                 si
        
        ; Stores the location of the first data sector
        mov     WORD [ $XEOS.boot.stage2.dataSector ],  dx
        
        ; Finds the second stage bootloader
        ; We have not altered DI, so it still contains the location of the FAT-12
        ; root directory
        call    XEOS.io.fat12.findFile
        
        ; Restore registers
        pop    di
        
        ; Checks for an error code
        cmp     ax,         0
        je      .loadFile
        
        ; Error - Stores result code in AX
        mov     ax,         2
        
        ret
    
    .loadFile:
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.fat12.load
        
        ; Saves registers
        push    bx
        push    cx
        
        ; Loads the file at 0x1000:00
        mov     ax,         0x1000
        
        ; Loads the FAT at ES:0x1000
        mov     bx,         0x1000
        
        ; Data sector location
        mov     cx,         WORD [ $XEOS.boot.stage2.dataSector ]
        
        ; Loads the second stage bootloader into memory
        call    XEOS.io.fat12.loadFile
        
        ; Restore registers
        pop    cx
        pop    bx
        
        ; Checks for an error code
        cmp     ax,         0
        je      .end
        
        ; Error - Stores result code in AX
        mov     ax,         3
        
        ret
        
    .end:
        
        ; Success - Stores result code in AX
        xor     ax,         ax
        
        ret
    