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
; @file            boot.s
; @author          Jean-David Gadina
; @copyright       (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
;-------------------------------------------------------------------------------

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

; Location at which we were loaded by the first stage bootloader (0x0050:0000)
ORG     0x500

; We are in 16 bits mode
BITS    16

; DEBUG - Forces the 32 bits mode
; %define XEOS32

; Jumps to the entry point
start: jmp main

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.constants.inc.s"     ; General constants
%include "xeos.macros.inc.s"        ; General macros
%include "xeos.16.int.inc.s"        ; BIOS interrupts
%include "xeos.16.video.inc.s"      ; BIOS video services
%include "xeos.16.io.fat12.inc.s"   ; FAT-12 IO procedures
%include "xeos.ascii.inc.s"         ; ASCII table
%include "xeos.16.cpu.inc.s"        ; CPU informations
%include "xeos.gdt.inc.s"           ; GDT - Global Descriptor Table
%include "xeos.16.a20.inc.s"        ; 20th address line enabling
%include "xeos.16.elf.inc.s"        ; ELF binary format support
%include "xeos.16.string.inc.s"     ; String utilities
%include "xeos.16.debug.inc.s"      ; Debugging
%include "xeos.16.mem.inc.s"        ; Memory related procedures

;-------------------------------------------------------------------------------
; Types definition
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Memory informations Structure:
;-------------------------------------------------------------------------------
struc XEOS.info.memory_t

    .address:   resd    1
    .length:    resd    1

endstruc

;-------------------------------------------------------------------------------
; Informations Structure:
;-------------------------------------------------------------------------------
struc XEOS.info_t

    .memory:    resb    XEOS.info.memory_t_size

endstruc

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.kernel.32.entry               dd  0
$XEOS.boot.stage2.kernel.64.entry               dd  0
$XEOS.boot.stage2.dataSector                    dw  0
$XEOS.boot.stage2.kernel.sectors                dw  0
$XEOS.boot.stage2.nl                            db  @ASCII.NL,  @ASCII.NUL
$XEOS.files.kernel.32                           db  "XEOS32  ELF", @ASCII.NUL
$XEOS.files.kernel.64                           db  "XEOS64  ELF", @ASCII.NUL
$XEOS.files.kernel.asm                          db  "KERNEL  BIN", @ASCII.NUL
$XEOS.boot.stage2.cpu.vendor                    db  "            ", @ASCII.NUL
$XEOS.boot.stage2.str                           dd  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @ASCII.NUL
$XEOS.boot.stage2.longMode                      db  0

$XEOS.boot.stage2.info:
    
    istruc XEOS.info_t
        
        dd  0
        dd  0
        
    iend

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.msg.prompt                            db  "XEOS", @ASCII.NUL
$XEOS.boot.stage2.msg.pipe                              db  186, @ASCII.NUL
$XEOS.boot.stage2.msg.gt                                db  ">", @ASCII.NUL
$XEOS.boot.stage2.msg.lt                                db  "<", @ASCII.NUL
$XEOS.boot.stage2.msg.space                             db  " ", @ASCII.NUL
$XEOS.boot.stage2.msg.bracket.left                      db  "[", @ASCII.NUL
$XEOS.boot.stage2.msg.bracket.right                     db  "]", @ASCII.NUL
$XEOS.boot.stage2.msg.separator                         db  ":", @ASCII.NUL
$XEOS.boot.stage2.msg.slash                             db  "/", @ASCII.NUL
$XEOS.boot.stage2.msg.yes                               db  "YES", @ASCII.NUL
$XEOS.boot.stage2.msg.no                                db  "NO", @ASCII.NUL
$XEOS.boot.stage2.msg.success                           db  "OK", @ASCII.NUL
$XEOS.boot.stage2.msg.failure                           db  "FAIL", @ASCII.NUL
$XEOS.boot.stage2.msg.greet                             db  "Entering the second stage bootloader:            ", @ASCII.NUL
$XEOS.boot.stage2.msg.version.name                      db  "XSBoot-x86", @ASCII.NUL
$XEOS.boot.stage2.msg.version.number                    db  "0.2.0", @ASCII.NUL
$XEOS.boot.stage2.msg.hr.top                            db  201, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 187, @ASCII.NUL
$XEOS.boot.stage2.msg.hr.bottom                         db  200, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                            205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 188, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1.left                  db  "                ", 4, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1                       db  " XEOS - x86 Experimental Operating System ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1.right                 db  4 ,"                 ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.2                       db  "                                                                             ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.3                       db  "      Copyright (c) 2010-2012 Jean-David Gadina <macmade@eosgarden.com>      ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.4                       db  "                       All rights (& wrongs) reserved                        ", @ASCII.NUL
$XEOS.boot.stage2.msg.memory                            db  "Detecting available memory:                      ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu                               db  "Getting CPU informations:                        ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.vendor                        db  "            ", 26, " CPU vendor:                                  ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type                          db  "            ", 26, " CPU type:                                    ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions                  db  "            ", 26, " CPU ISA:                                     ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.32                       db  "i386", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.64                       db  "x86_64", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.32               db  "32-bits", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.64               db  "64-bits", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.load                       db  "Loading the kernel image:                        ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.root                        db  "            ", 26, " Loading the FAT-12 directory into memory:    ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.find                        db  "            ", 26, " Locating the kernel image:                   ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.load                        db  "            ", 26, " Loading the kernel image into memory:        ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify.32                  db  "Verifying the kernel image (ELF-32):             ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify.64                  db  "Verifying the kernel image (ELF-64):             ", @ASCII.NUL
$XEOS.boot.stage2.msg.gdt.32                            db  "Installing the GDT (32 bits):                    ", @ASCII.NUL
$XEOS.boot.stage2.msg.gdt.64                            db  "Installing the GDT (64 bits):                    ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.check                         db  "Checking if the A-20 address line is enabled:    ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.bios                          db  "Enabling the A-20 address line (BIOS):           ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardControl               db  "Enabling the A-20 address line (KBDCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardOut                   db  "Enabling the A-20 address line (KBDOUT):         ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.systemControl                 db  "Enabling the A-20 address line (SYSCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.switch32                          db  "Switching the CPU to 32 bits mode:               ", @ASCII.NUL
$XEOS.boot.stage2.msg.switch64                          db  "Switching the CPU to 64 bits mode:               ", @ASCII.NUL
$XEOS.boot.stage2.msg.error                             db  "Press any key to reboot: ", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.dir                   db  "Error: cannot load the FAT-12 root directory",@ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.find                  db  "Error: file not found", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.load                  db  "Error: cannot load the requested file", @ASCII.NUL
$XEOS.boot.stage2.msg.error.a20                         db  "Error: cannot enable the A-20 address line", @ASCII.NUL
$XEOS.boot.stage2.msg.error.cpuid                       db  "Error: processor does not support CPUID", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32                   db  "Error: invalid ELF-32 image", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_ident.magic     db  "Error: invalid ELF-32 signature", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_ident.class     db  "Error: invalid ELF-32 class", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_ident.encoding  db  "Error: invalid ELF-32 encoding", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_ident.version   db  "Error: invalid ELF-32 version", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_type            db  "Error: invalid ELF-32 type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_machine         db  "Error: invalid ELF-32 machine type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_version         db  "Error: invalid ELF-32 version", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.32.e_entry           db  "Error: invalid ELF-32 entry point address", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64                   db  "Error: invalid ELF-64 image", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.magic     db  "Error: invalid ELF-64 signature", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.class     db  "Error: invalid ELF-64 class", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.encoding  db  "Error: invalid ELF-64 encoding", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.version   db  "Error: invalid ELF-64 version", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_type            db  "Error: invalid ELF-64 type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_machine         db  "Error: invalid ELF-64 machine type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_version         db  "Error: invalid ELF-64 version", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_entry           db  "Error: invalid ELF-64 entry point address", @ASCII.NUL
$XEOS.boot.stage2.msg.error.memory                      db  "Error: unable to detect available memory", @ASCII.NUL

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Addresses
%define @XEOS.boot.stage2.fat12.root.offset     0x7900      ; 0050:7900 - 0x007E00
%define @XEOS.boot.stage2.fat12.fat.offset      0x9500      ; 0050:9500 - 0x009A00
%define @XEOS.boot.stage2.memory.info.segment   0x1500      ; 1500:0000 - 0x015000
%define @XEOS.boot.stage2.kernel.segment        0x2000      ; 2000:0000 - 0x020000
%define @XEOS.boot.stage2.kernel.address        0x00100000
%define @XEOS.boot.stage2.kernel.text.offset    0x1000

;-------------------------------------------------------------------------------
; Prints text in color
; 
; Parameters:
; 
;       1:          The text to print
;       2:          The foreground color
;       3:          The background color
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.color 3
    
    pusha
    
    @XEOS.16.video.createScreenColor bl, %2, %3
    
    mov     si,         %1
    call    XEOS.boot.stage2.print.color
    
    popa
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a strings with brackets (green text)
; 
; Parameters:
; 
;       1:          The text to print
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.bracket.green 1
    
    pusha
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @XEOS.16.video.color.green.light,   @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    pop                             si
    popa
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a strings with brackets (red text)
; 
; Parameters:
; 
;       1:          The text to print
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.bracket.red 1
    
    pusha
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @XEOS.16.video.color.red.light,     @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    pop                             si
    popa
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a strings with brackets (orange text)
; 
; Parameters:
; 
;       1:          The text to print
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.bracket.gray 1
    
    pusha
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @XEOS.16.video.color.gray.light,    @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    pop                             si
    popa
    
%endmacro

;-------------------------------------------------------------------------------
; Prints the prompt
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.prompt 0
    
    pusha
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.prompt,           @XEOS.16.video.color.gray.light,    @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.gt,               @XEOS.16.video.color.white,         @XEOS.16.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    popa
    
%endmacro

;-------------------------------------------------------------------------------
; Prints the success message
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.success 0

    @XEOS.boot.stage2.print.bracket.green $XEOS.boot.stage2.msg.success

%endmacro

;-------------------------------------------------------------------------------
; Prints the failure message
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.failure 0
    
    @XEOS.boot.stage2.print.bracket.red $XEOS.boot.stage2.msg.failure

%endmacro

;-------------------------------------------------------------------------------
; Prints the 'yes' message
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.yes 0

    @XEOS.boot.stage2.print.bracket.green $XEOS.boot.stage2.msg.yes

%endmacro

;-------------------------------------------------------------------------------
; Prints the 'no' message
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.no 0

    @XEOS.boot.stage2.print.bracket.red $XEOS.boot.stage2.msg.no

%endmacro

;-------------------------------------------------------------------------------
; Prints the 'no' message (orange text)
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.no.gray 0

    @XEOS.boot.stage2.print.bracket.gray $XEOS.boot.stage2.msg.no

%endmacro

;-------------------------------------------------------------------------------
; Prints a new line with a message, prefixed by the prompt
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.line 1
    
    @XEOS.boot.stage2.print.prompt
    @XEOS.boot.stage2.print.color   %1, @XEOS.16.video.color.white, @XEOS.16.video.color.black
    @XEOS.boot.stage2.print             $XEOS.boot.stage2.nl
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a new line with an error message, prefixed by the prompt
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print.line.error 1
    
    @XEOS.boot.stage2.print.prompt
    @XEOS.boot.stage2.print.color   %1, @XEOS.16.video.color.red.light, @XEOS.16.video.color.black
    @XEOS.boot.stage2.print             $XEOS.boot.stage2.nl
    
%endmacro

;-------------------------------------------------------------------------------
; Prints a string
; 
; Parameters:
; 
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
%macro @XEOS.boot.stage2.print      1
    
    push                            si
    @XEOS.boot.stage2.print.color   %1, @XEOS.16.video.color.white, @XEOS.16.video.color.black
    pop                             si
    
%endmacro

;-------------------------------------------------------------------------------
; Procedures
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Second stage bootloader
; 
; This section is the bootloader's code that will be runned by first stage
; bootloader, and which is reponsible to setup and load the XEOS kernel
; 
; At this time, the memory layout is the following:
; 
;       0x000000 - 0x00003F:      1'024 bytes       ISR vectors addresses
;       0x000400 - 0x0004F0         256 bytes       BIOS data
;       0x000500 - 0x007BF0:     30'464 bytes       2nd stage boot loader
;       0x007C00 - 0x007DF0:        512 bytes       1st stage boot loader
;       0x007E00 - 0x09FFF0:    623'104 bytes       Free
;       0x0A0000 - 0x0BFFF0:    131'072 bytes       BIOS video sub-system
;       0x0C0000 - 0x0EFFF0:    196'608 bytes       BIOS ROM
;       0x0F0000 - 0x0FFFF0:     65'536 bytes       System ROM
; 
; Stuff will be loaded at the following locations:
; 
;       0x007E00 - 0x0099FF:      7'168 bytes 	    FAT-12 Root Directory
;       0x009A00 - 0x00FFFF:     18'432 bytes       FATs
;       0x010000 - 0x010FFF:      4'096 bytes       PML4T
;       0x011000 - 0x011FFF:      4'096 bytes       PDPT
;       0x012000 - 0x012FFF:      4'096 bytes       PDT
;       0x013000 - 0x013FFF:      4'096 bytes       PT
;       0x015000 - 0x01FFFF:     45'056 bytes       INT 0x15 data
;       0x020000 - 0x09FFFF:    524'288 bytes       Kernel data (temporary)
;       0x100000 - 0x??????:                        Kernel data (executable)
;-------------------------------------------------------------------------------
main:
    
    ;---------------------------------------------------------------------------
    ; Bootloader start
    ;---------------------------------------------------------------------------
    .start:
        
        ; Clears the interrupts as we are setting-up the segments and stack space
        cli
        
        ; Sets the data and extra segments. We use the ORG instruction, so we
        ; simply need to set them to 0.
        xor     ax,         ax
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
        
        ; Prints the copyright note
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.top,               @XEOS.16.video.color.white,         @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.left,     @XEOS.16.video.color.white,         @XEOS.16.video.color.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1,          @XEOS.16.video.color.brown.light,   @XEOS.16.video.color.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.right,    @XEOS.16.video.color.white,         @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.2,          @XEOS.16.video.color.white,         @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.3,          @XEOS.16.video.color.gray.light,    @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.4,          @XEOS.16.video.color.gray.light,    @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.bottom,            @XEOS.16.video.color.white,         @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
        ; Prints the welcome message
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.greet
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.version.name,         @XEOS.16.video.color.green.light,   @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.slash
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.version.number,       @XEOS.16.video.color.green.light,   @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
    ;---------------------------------------------------------------------------
    ; Memory detection
    ;---------------------------------------------------------------------------
    .memory:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.memory
        
        ; Detects memory
        mov     ax,         @XEOS.boot.stage2.memory.info.segment
        call    XEOS.16.mem.getMemoryLayout
        cmp     eax,        0x00
        jg      .memory.success
        
        .memory.fail:
        
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            jmp     .error.memory
            
        .memory.success:
            
            mov DWORD [ $XEOS.boot.stage2.info + XEOS.info_t.memory + XEOS.info.memory_t.address ], @XEOS.boot.stage2.memory.info.segment * 0x10
            mov DWORD [ $XEOS.boot.stage2.info + XEOS.info_t.memory + XEOS.info.memory_t.length ],  eax
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
    ;---------------------------------------------------------------------------
    ; CPU check
    ;---------------------------------------------------------------------------
    .cpuid:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.cpu
        
        ; Checks if we can use CPUID
        call    XEOS.16.cpu.hasCPUID
        cmp     ax,         1
        je      .cpuid.ok
        
        .cpuid.fail:
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            jmp     .error.cpuid
            
        .cpuid.ok:
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            ; Gets the CPU vendor ID
            push    di
            mov     di,     $XEOS.boot.stage2.cpu.vendor 
            call    XEOS.16.cpu.vendor
            
            @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.cpu.vendor
            @XEOS.boot.stage2.print.bracket.green   di
            @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
            pop                             di
            
            ; Checks if the CPU has 64 bits capabilities
            call    XEOS.16.cpu.64
            
            ; DEBUG - Forces the 32 bits mode
            %ifdef XEOS32
            xor     ax,         ax
            %endif
            
            ; Checks if the CPU has 64 bits capabilities
            cmp     ax,         1
            je      .cpuid.x86_64
        
        ;-----------------------------------------------------------------------
        ; i386 CPU
        ;-----------------------------------------------------------------------
        .cpuid.i386:
            
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.type
            @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.type.32
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.instructions
            @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.instructions.32
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
            
            ; We won't switch to 64 bits long mode
            mov     BYTE [ $XEOS.boot.stage2.longMode ],   0
            
            jmp     .a20
          
        ;-----------------------------------------------------------------------
        ; x86_c64 CPU
        ;-----------------------------------------------------------------------
        .cpuid.x86_64:
            
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.type
            @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.type.64
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.instructions
            @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.instructions.64
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
            
            ; We'll need to switch to 64 bits long mode
            mov     BYTE [ $XEOS.boot.stage2.longMode ],   1
    
    ;---------------------------------------------------------------------------
    ; A-20 address line
    ;--------------------------------------------------------------------------- 
    .a20:
        
        ;-----------------------------------------------------------------------
        ; A-20 status check
        ;-----------------------------------------------------------------------
        .a20.check:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.check
            call                    XEOS.16.a20.enabled
            
            cmp     ax,             0
            je      .a20.enable
            
            @XEOS.boot.stage2.print.yes
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .load
            
        .a20.enable:
            
            @XEOS.boot.stage2.print.no.gray
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
        ;-----------------------------------------------------------------------
        ; A-20 enabling (BIOS)
        ;-----------------------------------------------------------------------
        .a20.enable.bios:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.bios
            call                    XEOS.16.a20.enable.bios
            
            cmp     ax,             0
            je      .a20.enable.success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
          
        ;-----------------------------------------------------------------------
        ; A-20 enabling (system controller)
        ;-----------------------------------------------------------------------
        .a20.enable.system:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.systemControl
            call                    XEOS.16.a20.enable.systemControl
            call                    XEOS.16.a20.enabled
            
            cmp     ax,             1
            je      .a20.enable.success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
         
        ;-----------------------------------------------------------------------
        ; A-20 enabling (keyboard out port)
        ;-----------------------------------------------------------------------
        .a20.enable.keyboard.out:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.keyboardOut
            call                    XEOS.16.a20.enable.keyboard.out
            call                    XEOS.16.a20.enabled
            
            cmp     ax,             1
            je      .a20.enable.success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
        ;-----------------------------------------------------------------------
        ; A-20 enabling (keyboard controller)
        ;-----------------------------------------------------------------------
        .a20.enable.keyboard.control:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.keyboardControl
            call                    XEOS.16.a20.enable.keyboard.control
            call                    XEOS.16.a20.enabled
            
            cmp     ax,             1
            je      .a20.enable.success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.a20
            
        .a20.enable.success:
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
       
    ;---------------------------------------------------------------------------
    ; Loads the kernel file
    ;---------------------------------------------------------------------------
    .load:
        
        ; Loads the XEOS kernel into memory
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.kernel.load
        
        ; Checks if we must load the 32 or 64 bits kernel
        cmp     BYTE [ $XEOS.boot.stage2.longMode ],   1
        je      .load.64
        
        .load.32:
            
            ; 32 bits kernel is going to be loaded
            mov     si,             $XEOS.files.kernel.32
            jmp     .load.start
            
        .load.64:
            
            ; 64 bits kernel is going to be loaded
            mov     si,             $XEOS.files.kernel.64
            
        .load.start:
            
            @XEOS.boot.stage2.print.bracket.green   si
            @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
            call                                    XEOS.boot.stage2.kernel.load
            
            cmp     ax,         1
            je      .error.fat12.dir
            
            cmp     ax,         2
            je      .error.fat12.find
            
            cmp     ax,         3
            je      .error.fat12.load
            
            ; Checks if we must check for an ELF-64 or ELF-32 image
            cmp     BYTE [ $XEOS.boot.stage2.longMode ],   1
            je      .load.verify.64
        
        ;-----------------------------------------------------------------------
        ; Verifies the kernel image (32 bits ELF)
        ;-----------------------------------------------------------------------
        .load.verify.32:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify.32
            
            ; Verifies the kernel file header, and stores the entry point
            ; address
            mov     si,     @XEOS.boot.stage2.kernel.segment
            call    XEOS.16.elf.32.checkHeader
            mov     DWORD [ $XEOS.boot.stage2.kernel.32.entry ],    edi
            cmp     ax,     0
            je      .load.verify.32.e_entry
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            ; Checks the error code
            cmp     ax,     0x01
            je      .error.verify.32.e_ident.magic
            cmp     ax,     0x02
            je      .error.verify.32.e_ident.class
            cmp     ax,     0x03
            je      .error.verify.32.e_ident.encoding
            cmp     ax,     0x04
            je      .error.verify.32.e_ident.version
            cmp     ax,     0x05
            je      .error.verify.32.e_type
            cmp     ax,     0x06
            je      .error.verify.32.e_machine
            cmp     ax,     0x07
            je      .error.verify.32.e_version
            jmp     .error.verify.32
            
        ;-----------------------------------------------------------------------
        ; Verifies the kernel entry point address
        ;-----------------------------------------------------------------------
        .load.verify.32.e_entry:
            
            ; DEBUG - Dumps registers
            ; call    XEOS.16.debug.registers.dump
            
            cmp     DWORD [ $XEOS.boot.stage2.kernel.32.entry ],    @XEOS.boot.stage2.kernel.address
            jge     .load.verified
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.verify.32.e_entry
            
        ;-----------------------------------------------------------------------
        ; Verifies the kernel image (64 bits ELF)
        ;-----------------------------------------------------------------------
        .load.verify.64:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify.64
            
            ; Verifies the kernel file header, and stores the entry point
            ; address
            mov     si,     @XEOS.boot.stage2.kernel.segment
            call    XEOS.16.elf.64.checkHeader
            mov     DWORD [ $XEOS.boot.stage2.kernel.64.entry ],    edi
            cmp     ax,     0
            je      .load.verify.64.e_entry
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            ; Checks the error code
            cmp     ax,     0x01
            je      .error.verify.64.e_ident.magic
            cmp     ax,     0x02
            je      .error.verify.64.e_ident.class
            cmp     ax,     0x03
            je      .error.verify.64.e_ident.encoding
            cmp     ax,     0x04
            je      .error.verify.64.e_ident.version
            cmp     ax,     0x05
            je      .error.verify.64.e_type
            cmp     ax,     0x06
            je      .error.verify.64.e_machine
            cmp     ax,     0x07
            je      .error.verify.64.e_version
            jmp     .error.verify.64
            
        ;-----------------------------------------------------------------------
        ; Verifies the kernel entry point address
        ;-----------------------------------------------------------------------
        .load.verify.64.e_entry:
            
            ; DEBUG - Dumps registers
            ; call    XEOS.16.debug.registers.dump
            
            cmp     DWORD [ $XEOS.boot.stage2.kernel.64.entry ],    @XEOS.boot.stage2.kernel.address
            jge     .load.verified
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.verify.64.e_entry
            
        .load.verified
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            ; Checks if we must switch the CPU to 64 bits long mode
            cmp     BYTE [ $XEOS.boot.stage2.longMode ],   1
            je      .switch64
    
    ;---------------------------------------------------------------------------
    ; Switches the CPU to 32 bits mode
    ;---------------------------------------------------------------------------
    .switch32:
        
        call    XEOS.boot.stage2.32
      
    ;---------------------------------------------------------------------------
    ; Switches the CPU to 64 bits mode
    ;---------------------------------------------------------------------------
    .switch64:
        
        call    XEOS.boot.stage2.64
        
    ;---------------------------------------------------------------------------
    ; Error management
    ;---------------------------------------------------------------------------
    .error.fat12.dir:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.fat12.dir
        jmp                                 .error
    
    .error.fat12.find:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.fat12.find
        jmp                                 .error
    
    .error.fat12.load:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.fat12.load
        jmp                                 .error
    
    .error.a20:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.a20
        jmp                                 .error
    
    .error.cpuid:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.cpuid
        jmp                                 .error
    
    .error.verify.32.e_ident.magic:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_ident.magic
        jmp                                 .error
        
    .error.verify.32.e_ident.class:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_ident.class
        jmp                                 .error
        
    .error.verify.32.e_ident.encoding:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_ident.encoding
        jmp                                 .error
        
    .error.verify.32.e_ident.version:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_ident.version
        jmp                                 .error
        
    .error.verify.32.e_type:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_type
        jmp                                 .error
        
    .error.verify.32.e_machine:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_machine
        jmp                                 .error
        
    .error.verify.32.e_version:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_version
        jmp                                 .error
    
    .error.verify.32.e_entry:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32.e_entry
        jmp                                 .error
        
    .error.verify.32:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.32
        jmp                                 .error
    
    .error.verify.64.e_ident.magic:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_ident.magic
        jmp                                 .error
        
    .error.verify.64.e_ident.class:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_ident.class
        jmp                                 .error
        
    .error.verify.64.e_ident.encoding:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_ident.encoding
        jmp                                 .error
        
    .error.verify.64.e_ident.version:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_ident.version
        jmp                                 .error
        
    .error.verify.64.e_type:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_type
        jmp                                 .error
        
    .error.verify.64.e_machine:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_machine
        jmp                                 .error
        
    .error.verify.64.e_version:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_version
        jmp                                 .error
    
    .error.verify.64.e_entry:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64.e_entry
        jmp                                 .error
        
    .error.verify.64:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64
        jmp                                 .error
        
    .error.memory:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.memory
        jmp                                 .error
        
    .error:
        
        ; Prints the error message
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error
        
        ; Waits for a key press
        xor     ax,         ax
        @XEOS.16.int.keyboard
        
        ; Reboot the computer
        @XEOS.16.int.reboot
    
    .end:
        
        ; Waits for a key press
        xor     ax,         ax
        @XEOS.16.int.keyboard
        
        ; Halts the system
        cli
        hlt

;-------------------------------------------------------------------------------
; Loads the XEOS kernel file into memory
; 
; Input registers:
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
    
    @XEOS.16.proc.start 0
    
    ;---------------------------------------------------------------------------
    ; Loads the FAT-12 root directory
    ;---------------------------------------------------------------------------
    .start:
        
        ; Saves registers
        push    si
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.fat12.root
        
        ; Offset the FAT-12 root directory location
        mov     di,             @XEOS.boot.stage2.fat12.root.offset
        call    XEOS.16.io.fat12.loadRootDirectory
        
        ; Checks for an error code
        cmp     ax,         0
        je      .findFile
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
        ; Restores registers
        pop     si
        
        @XEOS.16.proc.end
        
        ret
    
    ;---------------------------------------------------------------------------
    ; Finds the requested file
    ;---------------------------------------------------------------------------
    .findFile:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.16.string.numberToString  cs, 16, 4, 0, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @XEOS.16.video.color.green.light, @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        @XEOS.16.string.numberToString  @XEOS.boot.stage2.fat12.root.offset, 16, 4, dx, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @XEOS.16.video.color.green.light, @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.fat12.find
        
        ; Restores registers
        pop     si
        
        ; Stores the location of the first data sector
        mov     WORD [ $XEOS.boot.stage2.dataSector ],  dx
        
        ; location of the FAT-12 root directory
        mov     di,         @XEOS.boot.stage2.fat12.root.offset
        
        ; Finds the second stage bootloader
        call    XEOS.16.io.fat12.findFile
        
        ; Checks for an error code
        cmp     ax,         0
        je      .loadFile
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
        @XEOS.16.proc.end
        
        ; Error - Stores result code in AX
        mov     ax,         2
        
        ret
        
    ;---------------------------------------------------------------------------
    ; Loads the requested file
    ;---------------------------------------------------------------------------
    .loadFile:
        
        ; Saves registers
        push    bx
        push    cx
        
        @XEOS.boot.stage2.print.success
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.fat12.load
        
        ; Kernel location
        mov     ax,         @XEOS.boot.stage2.kernel.segment
        
        ; FAT location
        mov     bx,         @XEOS.boot.stage2.fat12.fat.offset
        
        ; Data sector location
        mov     cx,         WORD [ $XEOS.boot.stage2.dataSector ]
        
        ; Loads the second stage bootloader into memory
        call    XEOS.16.io.fat12.loadFile
        
        ; Number of sectors read
        mov     WORD [ $XEOS.boot.stage2.kernel.sectors ],  cx
        
        ; Restores registers
        pop    cx
        pop    bx
        
        ; Checks for an error code
        cmp     ax,         0
        je      .end
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
        @XEOS.16.proc.end
        
        ; Error - Stores result code in AX
        mov     ax,         3
        
        ret
        
    ;---------------------------------------------------------------------------
    ; End of procedure
    ;---------------------------------------------------------------------------
    .end:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.16.string.numberToString  @XEOS.boot.stage2.kernel.segment, 16, 4, 0, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @XEOS.16.video.color.green.light, @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        @XEOS.16.string.numberToString  0, 16, 4, 0, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @XEOS.16.video.color.green.light, @XEOS.16.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
        @XEOS.16.proc.end
        
        ; DEBUG - Dumps the kernel data
        ; mov     si,         @XEOS.boot.stage2.kernel.segment
        ; call    XEOS.16.debug.memory.dump
        
        ; Success - Stores result code in AX
        xor     ax,         ax
        
        ret
        
;-------------------------------------------------------------------------------
; Prints text in color
; 
; Input registers:
;       
;       - SI:       The text to print
;       - BL:       The BIOS color
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.boot.stage2.print.color:
    
    @XEOS.16.proc.start 0
    
    ; Saves registers
    push    si
    
    ; Resets CS
    xor     cx,         cx
    
    ; Process a byte from the string
    .repeat:
        
        ; Gets a byte from the string placed in SI (will be placed in AL)
        lodsb
        
        ; Checks for the end of the string (ASCII 0)
        cmp     al,         @ASCII.NUL
        
        ; End of the string detected
        je      .done
        
        ; Increments CX (string length)
        inc     cx
        
        ; Process the next byte from the string
        jmp     .repeat
    
    ; End of the string
    .done:
        
        ; Sets the color attributes
        mov     ah,         0x09
        mov     al,         32
        mov     bh,         0
        @XEOS.16.int.video
        
        ; Restores registers
        pop     si
        
        ; Prints the string
        call XEOS.16.video.print
    
    @XEOS.16.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Enables paging
; 
; If PAE (Physical Address Extension) is available, the layout will be
; the following:
; 
;       PML4T:    0x010000 (Page-Map Level-4 Table)
;       PDPT:     0x011000 (Page Directory Pointer Table)
;       PDT:      0x012000 (Page Directory Table)
;       PT:       0x013000 (Page Table)
; 
; Otherwise:
; 
;       PDT:      0x012000 (Page Directory Table)
;       PT:       0x013000 (Page Table)
; 
; PAE will be set accordingly.
; 
; Depending on whether PAE is available, the first megabytes of memory will
; be mapped. First two megabytes with PAE, First 4 megabytes without PAE.
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.boot.stage2.enablePaging:
    
    @XEOS.16.proc.start 0
    
    ; Saves registers
    push    ds
    push    es
    
    ; Sets the data and extra segments to the location of the first table (PML4T)
    ; (1000:0000 -> 0x10000)
    mov     ax,         0x1000
    mov     ds,         ax
    mov     es,         ax
    
    ; Clears the PG-bit of the control register (bit 31)
    mov     eax,        cr0
    and     eax,        0x7FFFFFFF    
    mov     cr0,        eax
    
    ; Checks if PAE is available
    call XEOS.16.cpu.pae
    
    ; Saves registers
    push    ax
    
    ; Set-ups PAE if available
    cmp     ax,         0x01
    je      .setup.pae
    
    .setup:
        
        ; Loads CR3 with the absolute location of the first table (PDT)
        mov     edi,        0x00012000
        mov     cr3,        edi
        
        ; Clears the page tables
        ; Each entry is 4096 bytes
        ; 2 x 4096 bytes tables, starting at 1000:2000, moving double words
        xor     eax,        eax
        mov     edi,        0x2000
        mov     ecx,        0x0400
        rep     stosd
        
        ; Indirect location of the first table;
        ; (PDT -> 1000:1200 -> 0x00012000)
        mov     edi,        0x2000
        
        ; PDT points to PT (0x00013000)
        ; 3 is for the first two bits (present + read/write)
        mov     DWORD [ edi ],  0x00013003
        
        ; Indirect location of the second table
        ; (PT -> PDT + 0x1000 -> 1000:1300 -> 0x00013000)
        add     edi,            0x00001000
        
        ; Entry flags (preset + read/write)
        mov     ebx,            0x00000003
        
        ; 1024 32 bits entries in PT
        mov     ecx,            0x00000400
    
        ; Sets page entries
        .setup.entry.set:
            
            ; Stores the entry data
            mov     DWORD [ edi ],  ebx
            
            ; Next page address (aligned on 4096 bytes)
            add     ebx,            0x1000
            
            ; Process next entry
            add     edi,            0x0004
            loop    .setup.entry.set
        
        jmp     .setup.done

    .setup.pae:
        
        ; Loads CR3 with the absolute location of the first table (PML4T)
        mov     edi,        0x00010000
        mov     cr3,        edi
        
        ; Clears the page tables
        ; Each entry is 4096 bytes
        ; 4 x 4096 bytes tables, starting at 1000:0000, moving double words
        xor     eax,        eax
        mov     edi,        eax
        mov     ecx,        0x1000
        rep     stosd
        
        ; Indirect location of the first table
        ; (PML4T -> 1000:0000 -> 0x00010000)
        xor     eax,        eax
        mov     edi,        eax
        
        ; PML4T points to PDPT (0x00011000)
        ; 3 is for the first two bits (present + read/write)
        mov     DWORD [ edi ],  0x00011003
        
        ; Indirect location of the second table
        ; (PDPT -> PML4T + 0x1000 -> 1000:1100 -> 0x00011000)
        add     edi,            0x00001000
        
        ; PDPT points to PDT (0x00012000)
        ; 3 is for the first two bits (present + read/write)
        mov     DWORD [ edi ],  0x00012003
        
        ; Indirect location of the third table;
        ; (PDT -> PDPT + 0x1000 -> 1000:1200 -> 0x00012000)
        add     edi,            0x00001000
        
        ; PDT points to PT (0x00013000)
        ; 3 is for the first two bits (present + read/write)
        mov     DWORD [ edi ],  0x00013003
        
        ; Indirect location of the fourth table
        ; (PT -> PDT + 0x1000 -> 1000:1300 -> 0x00013000)
        add     edi,            0x00001000
        
        ; Entry flags (preset + read/write)
        mov     ebx,            0x00000003
        
        ; 512 64 bits entries in PT
        mov     ecx,            0x00000200
    
        ; Sets page entries
        .setup.pae.entry.set:
            
            ; Stores the entry data
            mov     DWORD [ edi ],  ebx
            
            ; Next page address (aligned on 4096 bytes)
            add     ebx,            0x1000
            
            ; Process next entry
            add     edi,            0x0008
            loop    .setup.pae.entry.set
            
    .setup.done:
        
        ; Restores registers
        pop     ax
        
        ; Enables PAE if available
        cmp     ax,         0x01
        jne     .end
    
    .pae.enable:
        
        ; Enables PAE-paging by setting the PAE-bit in the fourth control register
        mov     eax,        cr4
        or      eax,        0x20
        mov     cr4,        eax
    
    .end:
    
    ; Restores registers
    pop     es
    pop     ds
    
    @XEOS.16.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Switches the CPU to 32 bits protected mode
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       N/A (This procudure does not return)
; 
; Killed registers:
;       
;       N/A (This procudure does not return)
;-------------------------------------------------------------------------------
XEOS.boot.stage2.32:
    
    ;---------------------------------------------------------------------------
    ; Installs the GDT (Global Descriptor Table)
    ;---------------------------------------------------------------------------
    .gdt:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.gdt.32
            
        ; Installs the 32 bits GDT
        call                    XEOS.gdt.install.32
            
        @XEOS.boot.stage2.print.success
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
    
    ;---------------------------------------------------------------------------
    ; Switch the processor to 32 bits protected mode
    ;---------------------------------------------------------------------------
    .switch:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch32
        
        ; Resets registers
        xor     ax,         ax
        xor     bx,         bx
        xor     cx,         cx
        xor     dx,         dx
        
        ; Gets the cursor position, so it can be restored in 32 bits mode
        mov     ah,         0x03
        @XEOS.16.int.video
        
        ; Kernel sectors and kernel entry points parameters
        mov     cx,          WORD [ $XEOS.boot.stage2.kernel.sectors ]
        mov     edi,        DWORD [ $XEOS.boot.stage2.kernel.32.entry ]
        
        ; Saves registers
        push    dx
        push    cx
        push    edi
        
        ; Clears the interrupts
        cli
        
        ; Enables paging
        call XEOS.boot.stage2.enablePaging
        
        ; Gets the value of the primary control register
        mov     eax,        cr0
        
        ; Sets the lowest bit, indicating the system must run in protected mode
        or      eax,        1
        
        ; Sets the new value - We are now in 32 bits protected mode
        mov     cr0,        eax
        
        ; Restores registers
        pop     edi
        pop     cx
        pop     dx
        
        ; Setup the 32 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp	    @XEOS.gdt.descriptors.32.code:XEOS.boot.stage2.32.run
    
    ; Halts the system
    hlt

;-------------------------------------------------------------------------------
; Switches the CPU to 64 bits long mode
; 
; Input registers:
;       
;       None
; 
; Return registers:
;       
;       N/A (This procudure does not return)
; 
; Killed registers:
;       
;       N/A (This procudure does not return)
;-------------------------------------------------------------------------------
XEOS.boot.stage2.64:
    
    ;---------------------------------------------------------------------------
    ; Installs the GDT (Global Descriptor Table)
    ;---------------------------------------------------------------------------
    .gdt:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.gdt.64
            
        ; Installs the 32 bits GDT
        call                    XEOS.gdt.install.64
            
        @XEOS.boot.stage2.print.success
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
    
    ;---------------------------------------------------------------------------
    ; Switch the processor to 64 bits long mode
    ;---------------------------------------------------------------------------
    .switch:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch64
        
        ; Resets registers
        xor     ax,         ax
        xor     bx,         bx
        xor     cx,         cx
        xor     dx,         dx
        
        ; Gets the cursor position, so it can be restored in 64 bits mode
        mov     ah,         0x03
        @XEOS.16.int.video
        
        ; Kernel sectors and kernel entry points parameters
        mov     cx,          WORD [ $XEOS.boot.stage2.kernel.sectors ]
        mov     edi,        DWORD [ $XEOS.boot.stage2.kernel.64.entry ]
        
        ; Saves registers
        push    dx
        push    cx
        push    edi
        
        ; Clears the interrupts
        cli
        
        ; Enables paging
        call XEOS.boot.stage2.enablePaging
        
        ; Sets the long mode bit in the EFER MSR
        mov     ecx,        0xC0000080
        rdmsr
        or      eax,        0x100
        wrmsr
        
        ; Enables protected mode
        mov     eax,        cr0
        or      eax,        0x01
        mov     cr0,        eax
        
        ; Enables paging
        mov     eax,        cr0
        or      eax,        0x80000000
        mov     cr0,        eax
        
        ; Restores registers
        pop     edi
        pop     cx
        pop     dx
        
        ; Setup the 64 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp     @XEOS.gdt.descriptors.64.code:XEOS.boot.stage2.64.run
        
    ; Halts the system
    hlt
    
; We are in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.32.video.inc.s"      ; XEOS video services
%include "xeos.32.string.inc.s"     ; String utilities

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.32.kernel.entry           dd  0
$XEOS.boot.stage2.32.kernel.sectors         dw  0
$XEOS.boot.stage2.32.nl                     db  @ASCII.NL,  @ASCII.NUL
$XEOS.boot.stage2.32.str                    dd  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @ASCII.NUL

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.msg.32.prompt             db  "XEOS", @ASCII.NUL
$XEOS.boot.stage2.msg.32.gt                 db  ">", @ASCII.NUL
$XEOS.boot.stage2.msg.32.space              db  " ", @ASCII.NUL
$XEOS.boot.stage2.msg.32.bracket.left       db  "[", @ASCII.NUL
$XEOS.boot.stage2.msg.32.bracket.right      db  "]", @ASCII.NUL
$XEOS.boot.stage2.msg.32.success            db  "OK", @ASCII.NUL
$XEOS.boot.stage2.msg.32.failure            db  "FAIL", @ASCII.NUL
$XEOS.boot.stage2.msg.32.kernel.move        db  "Moving the kernel image to its final location:   ", @ASCII.NUL
$XEOS.boot.stage2.msg.32.kernel.run         db  "Passing control to the kernel:                   ", @ASCII.NUL

;-------------------------------------------------------------------------------
; Setups and executes the 32 bits kernel
; 
; Input registers:
;       
;       - CX:       The number of sectors for the kernel file
;       - DX:       The current cursor position
;       - EDI:      The kernel entry point
; 
; Return registers:
;       
;       N/A (This procudure does not return)
; 
; Killed registers:
;       
;       N/A (This procudure does not return)
;-------------------------------------------------------------------------------
XEOS.boot.stage2.32.run:
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         @XEOS.gdt.descriptors.32.data
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    
    ; Sets the stack pointer
    mov     esp,        0x90000
    
    ; Restores the cursor position
    @XEOS.32.video.cursor.move dl, dh
    
    ; Saves kernel sectors and kernel entry points parameters
    mov      WORD [ $XEOS.boot.stage2.32.kernel.sectors ],  cx
    mov     DWORD [ $XEOS.boot.stage2.32.kernel.entry ],    edi
    
    ; Sets color attributes
    @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
    @XEOS.32.video.setBackgroundColor   @XEOS.32.video.color.black
    
    @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.left
    @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
    @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.green.light
    @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.success
    @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
    @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
    @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.right
    @XEOS.32.video.print                $XEOS.boot.stage2.32.nl
    
    .copy:
        
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.left
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.gray.light
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.prompt
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.right
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.gt
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.kernel.move
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.gray.light
        
        ; Location of the kernel in memory (multiplies the segment address by 16)
        mov     eax,        @XEOS.boot.stage2.kernel.segment
        mov     ebx,        0x10
        mul     ebx
        mov     esi,        eax
        
        ; Destination for the kernel
        mov     edi,        @XEOS.boot.stage2.kernel.address
        
        ; The .text section is located at offset 0x1000
        ; Keep the ELF header, but copy it below
        sub     edi,        @XEOS.boot.stage2.kernel.text.offset
        
        ; Resets registers
        xor     eax,        eax
        xor     ebx,        ebx
        
        ; Number of sectors loaded for the kernel
        mov     ax,        WORD [ $XEOS.boot.stage2.32.kernel.sectors ]
        
        ; Multiplies by the number of bytes per sector
        mov     bx,        @XEOS.io.fat12.mbr.bytesPerSector
        mul     ebx
        
        ; We are going to read double words, so divides the bytes by 4
        mov     ebx,        0x04
        div     ebx
        
        ; Clears the direction flag
        cld
        
        ; Counter
        mov     ecx,        eax
        
        .copy.bytes:
            
            ; Moves bytes
            movsd
            
            .copy.bytes.symbol:
                
                ; Saves registers
                pushad
                
                ; We've got 4 different symbols, so divide the counter
                ; by 4 and checks the reminder
                mov     eax,        ecx
                xor     edx,        edx
                mov     ebx,        0x04
                div     ebx
                cmp     edx,        0x00
                je      .copy.bytes.symbol.char.1
                cmp     edx,        0x01
                je      .copy.bytes.symbol.char.2
                cmp     edx,        0x02
                je      .copy.bytes.symbol.char.3
                cmp     edx,        0x03
                je      .copy.bytes.symbol.char.4
                
                .copy.bytes.symbol.char.1:
                    
                    ; Prints '|'
                    @XEOS.32.video.putc 0x7C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.2:
                    
                    ; Prints '/'
                    @XEOS.32.video.putc 0x2F
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.3:
                    
                    ; Prints '-'
                    @XEOS.32.video.putc 0x2D
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.4:
                    
                    ; Prints '\'      
                    @XEOS.32.video.putc 0x5C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.done:
                    
                    ; Restores registers
                    popad
            
            ; Continues to move bytes
            loop    .copy.bytes
            
            @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
            @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.left
            @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
            @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.green.light
            @XEOS.32.string.numberToString      @XEOS.boot.stage2.kernel.address - @XEOS.boot.stage2.kernel.text.offset, 16, 8, 1, $XEOS.boot.stage2.32.str
            @XEOS.32.video.print                $XEOS.boot.stage2.32.str
            @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
            @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
            @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.right
            @XEOS.32.video.print                $XEOS.boot.stage2.32.nl
            
    .run:
        
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.left
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.gray.light
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.prompt
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.right
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.gt
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.kernel.run
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.left
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.green.light
        @XEOS.32.string.numberToString      DWORD [ $XEOS.boot.stage2.32.kernel.entry ], 16, 8, 1, $XEOS.boot.stage2.32.str
        @XEOS.32.video.print                $XEOS.boot.stage2.32.str
        @XEOS.32.video.setForegroundColor   @XEOS.32.video.color.white
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.space
        @XEOS.32.video.print                $XEOS.boot.stage2.msg.32.bracket.right
        @XEOS.32.video.print                $XEOS.boot.stage2.32.nl
        
        ; Kernel entry point
        mov     eax,        DWORD [ $XEOS.boot.stage2.32.kernel.entry ]
        
        ; Boot infos
        mov     edi,        $XEOS.boot.stage2.info
        
        ; Jumps to the kernel code
        jmp     @XEOS.gdt.descriptors.32.code:eax
        
    ; Halts the system
    hlt

; We are in 64 bits mode
BITS    64

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.64.video.inc.s"      ; XEOS video services
%include "xeos.64.string.inc.s"     ; String utilities

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.64.kernel.entry           dd  0
$XEOS.boot.stage2.64.kernel.sectors         dw  0
$XEOS.boot.stage2.64.nl                     db  @ASCII.NL,  @ASCII.NUL
$XEOS.boot.stage2.64.str                    dd  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @ASCII.NUL

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.msg.64.prompt             db  "XEOS", @ASCII.NUL
$XEOS.boot.stage2.msg.64.gt                 db  ">", @ASCII.NUL
$XEOS.boot.stage2.msg.64.space              db  " ", @ASCII.NUL
$XEOS.boot.stage2.msg.64.bracket.left       db  "[", @ASCII.NUL
$XEOS.boot.stage2.msg.64.bracket.right      db  "]", @ASCII.NUL
$XEOS.boot.stage2.msg.64.success            db  "OK", @ASCII.NUL
$XEOS.boot.stage2.msg.64.failure            db  "FAIL", @ASCII.NUL
$XEOS.boot.stage2.msg.64.kernel.move        db  "Moving the kernel image to its final location:   ", @ASCII.NUL
$XEOS.boot.stage2.msg.64.kernel.run         db  "Passing control to the kernel:                   ", @ASCII.NUL

;-------------------------------------------------------------------------------
; Setups and executes the 64 bits kernel
; 
; Input registers:
;       
;       - CX:       The number of sectors for the kernel file
;       - DX:       The current cursor position
;       - EDI:      The kernel entry point
; 
; Return registers:
;       
;       N/A (This procudure does not return)
; 
; Killed registers:
;       
;       N/A (This procudure does not return)
;-------------------------------------------------------------------------------
XEOS.boot.stage2.64.run:
    
    ; Sets the stack pointer
    mov     rsp,        0x90000
    
    ; Restores the cursor position
    @XEOS.64.video.cursor.move dl, dh
    
    ; Saves kernel sectors and kernel entry points parameters
    mov      WORD [ $XEOS.boot.stage2.64.kernel.sectors ],  cx
    mov     DWORD [ $XEOS.boot.stage2.64.kernel.entry ],    edi
    
    ; Sets color attributes
    @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
    @XEOS.64.video.setBackgroundColor   @XEOS.64.video.color.black
    
    @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.left
    @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
    @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.green.light
    @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.success
    @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
    @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
    @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.right
    @XEOS.64.video.print                $XEOS.boot.stage2.64.nl
    
    .copy:
        
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.left
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.gray.light
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.prompt
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.right
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.gt
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.kernel.move
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.gray.light
        
        ; Location of the kernel in memory (multiplies the segment address by 16)
        mov     rax,        @XEOS.boot.stage2.kernel.segment
        mov     rbx,        0x10
        mul     rbx
        mov     rsi,        rax
        
        ; Destination for the kernel
        mov     rdi,        @XEOS.boot.stage2.kernel.address
        
        ; The .text section is located at offset 0x1000
        ; Keep the ELF header, but copy it below
        sub     rdi,        @XEOS.boot.stage2.kernel.text.offset
        
        ; Resets registers
        xor     rax,        rax
        xor     rbx,        rbx
        
        ; Number of sectors loaded for the kernel
        mov     ax,        WORD [ $XEOS.boot.stage2.64.kernel.sectors ]
        
        ; Multiplies by the number of bytes per sector
        mov     bx,        @XEOS.io.fat12.mbr.bytesPerSector
        mul     rbx
        
        ; We are going to read quad words, so divides the bytes by 8
        mov     rbx,        0x08
        div     rbx
        
        ; Clears the direction flag
        cld
        
        ; Counter
        mov     rcx,        rax
        
        .copy.bytes:
            
            ; Moves bytes
            movsq
            
            .copy.bytes.symbol:
                
                ; Saves registers
                push    rax
                push    rbx
                push    rcx
                push    rdx
                push    rdi
                
                ; We've got 4 different symbols, so divide the counter
                ; by 4 and checks the reminder
                mov     rax,        rcx
                xor     rdx,        rdx
                mov     rbx,        0x04
                div     rbx
                cmp     rdx,        0x00
                je      .copy.bytes.symbol.char.1
                cmp     rdx,        0x01
                je      .copy.bytes.symbol.char.2
                cmp     rdx,        0x02
                je      .copy.bytes.symbol.char.3
                cmp     rdx,        0x03
                je      .copy.bytes.symbol.char.4
                
                .copy.bytes.symbol.char.1:
                    
                    ; Prints '|'
                    @XEOS.64.video.putc 0x7C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.2:
                    
                    ; Prints '/'
                    @XEOS.64.video.putc 0x2F
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.3:
                    
                    ; Prints '-'
                    @XEOS.64.video.putc 0x2D
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.4:
                    
                    ; Prints '\'      
                    @XEOS.64.video.putc 0x5C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.done:
                    
                    ; Restores registers
                    pop     rdi
                    pop     rdx
                    pop     rcx
                    pop     rbx
                    pop     rax
            
            ; Continues to move bytes
            loop    .copy.bytes
            
            @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
            @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.left
            @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
            @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.green.light
            @XEOS.64.string.numberToString      @XEOS.boot.stage2.kernel.address - @XEOS.boot.stage2.kernel.text.offset, 16, 8, 1, $XEOS.boot.stage2.64.str
            @XEOS.64.video.print                $XEOS.boot.stage2.64.str
            @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
            @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
            @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.right
            @XEOS.64.video.print                $XEOS.boot.stage2.64.nl
            
    .run:
        
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.left
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.gray.light
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.prompt
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.right
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.gt
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.kernel.run
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.left
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.green.light
        xor                                 rax, rax
        mov                                 eax, DWORD [ $XEOS.boot.stage2.64.kernel.entry ]
        @XEOS.64.string.numberToString      rax, 16, 8, 1, $XEOS.boot.stage2.64.str
        @XEOS.64.video.print                $XEOS.boot.stage2.64.str
        @XEOS.64.video.setForegroundColor   @XEOS.64.video.color.white
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.space
        @XEOS.64.video.print                $XEOS.boot.stage2.msg.64.bracket.right
        @XEOS.64.video.print                $XEOS.boot.stage2.64.nl
        
        ; Kernel entry point
        xor     rax,        rax
        mov     eax,        DWORD [ $XEOS.boot.stage2.64.kernel.entry ]
        
        ; Boot infos
        mov     rdi,        $XEOS.boot.stage2.info
        
        ; Jumps to the kernel code
        jmp     @XEOS.gdt.descriptors.64.code:rax
        
    ; Halts the system
    hlt
