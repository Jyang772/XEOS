
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

; Location at which we were loaded by the first stage bootloader (0x0050:0000)
ORG     0x500

; We are in 16 bits mode
BITS    16

; DEBUG - Forces the 32 bits mode
%define XEOS32

; Jumps to the entry point
start: jmp main

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.constants.inc.s"     ; General constants
%include "xeos.macros.inc.s"        ; General macros
%include "bios.int.inc.s"           ; BIOS interrupts
%include "bios.video.inc.16.s"      ; BIOS video services
%include "xeos.io.fat12.inc.16.s"   ; FAT-12 IO procedures
%include "xeos.ascii.inc.s"         ; ASCII table
%include "xeos.cpu.inc.16.s"        ; CPU informations
%include "xeos.gdt.inc.s"           ; GDT - Global Descriptor Table
%include "xeos.a20.inc.16.s"        ; 20th address line enabling
%include "xeos.elf.inc.16.s"        ; ELF binary format support
%include "xeos.string.inc.16.s"     ; String utilities
%include "xeos.debug.inc.16.s"      ; Debugging

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.dataSector                    dw  0
$XEOS.boot.stage2.kernelSectors                 dw  0
$XEOS.boot.stage2.entryPoint                    dd  0
$XEOS.boot.stage2.nl                            db  @ASCII.NL,  @ASCII.NUL
$XEOS.files.kernel.32                           db  "XEOS32  ELF", @ASCII.NUL
$XEOS.files.kernel.64                           db  "XEOS64  ELF", @ASCII.NUL
$XEOS.boot.stage2.cpu.vendor                    db  "            ", @ASCII.NUL
$XEOS.boot.stage2.str                           db  "                              ", @ASCII.NUL
$XEOS.boot.stage2.longMonde                     db  0

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
$XEOS.boot.stage2.msg.copyright.4                       db  "                             All Rights Reserved                             ", @ASCII.NUL
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
$XEOS.boot.stage2.msg.kernel.verify.32                  db  "Verifiying the kernel image (ELF-32):            ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify.64                  db  "Verifiying the kernel image (ELF-64):            ", @ASCII.NUL
$XEOS.boot.stage2.msg.gdt                               db  "Installing the GDT:                              ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.check                         db  "Checking if the A-20 address line is enabled:    ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.bios                          db  "Enabling the A-20 address line (BIOS):           ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardControl               db  "Enabling the A-20 address line (KBDCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardOut                   db  "Enabling the A-20 address line (KBDOUT):         ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.systemControl                 db  "Enabling the A-20 address line (SYSCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.switch32                          db  "Switching the CPU to 32 bits (protected) mode:   ", @ASCII.NUL
$XEOS.boot.stage2.msg.switch64                          db  "Switching the CPU to 64 bits (long) mode:        ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.move                       db  "Moving the kernel image to its final location:   ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.address                    db  "0x00201000", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.run                        db  "Passing control to the kernel...                 ", @ASCII.NUL
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
$XEOS.boot.stage2.msg.error.verify.64                   db  "Error: invalid ELF-64 image", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.magic     db  "Error: invalid ELF-64 signature", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.class     db  "Error: invalid ELF-64 class", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.encoding  db  "Error: invalid ELF-64 encoding", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_ident.version   db  "Error: invalid ELF-64 version", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_type            db  "Error: invalid ELF-64 type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_machine         db  "Error: invalid ELF-64 machine type", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify.64.e_version         db  "Error: invalid ELF-64 version", @ASCII.NUL

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Addresses
%define @XEOS.boot.stage2.fat.offset        0x7900
%define @XEOS.boot.stage2.kernel.segment    0x1000
%define @XEOS.boot.stage2.kernel.address    0x00201000

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
    
    @BIOS.video.createScreenColor bl, %2, %3
    
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
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.color.white,        @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @BIOS.video.color.green.light,  @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.color.white,        @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.color.white,        @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @BIOS.video.color.red.light,    @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.color.white,        @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.color.white,        @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @BIOS.video.color.gray.light,   @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.color.white,        @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.color.white,        @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.prompt,           @BIOS.video.color.gray.light,   @BIOS.video.color.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.color.white,        @BIOS.video.color.black
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.gt,               @BIOS.video.color.white,        @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.color.white, @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.color.red.light, @BIOS.video.color.black
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
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.color.white, @BIOS.video.color.black
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
; So 0x0050 is 0x0050:0000 which is 0x00500.
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
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.top,               @BIOS.video.color.white,        @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.left,     @BIOS.video.color.white,        @BIOS.video.color.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1,          @BIOS.video.color.brown.light,  @BIOS.video.color.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.right,    @BIOS.video.color.white,        @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.2,          @BIOS.video.color.white,        @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.3,          @BIOS.video.color.gray.light,   @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.4,          @BIOS.video.color.gray.light,   @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.bottom,            @BIOS.video.color.white,        @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
        ; Prints the welcome message
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.greet
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print.color           $XEOS.boot.stage2.msg.version.name,     @BIOS.video.color.green.light,  @BIOS.video.color.black
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.slash
        @XEOS.boot.stage2.print.color           $XEOS.boot.stage2.msg.version.number,   @BIOS.video.color.green.light,  @BIOS.video.color.black
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
    ;---------------------------------------------------------------------------
    ; CPU check
    ;---------------------------------------------------------------------------
    .cpuid:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.cpu
        
        ; Checks if we can use CPUID
        call    XEOS.cpu.hasCPUID
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
            call    XEOS.cpu.vendor
            
            @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.cpu.vendor
            @XEOS.boot.stage2.print.bracket.green   di
            @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
            pop                             di
            
            ; Checks if the CPU has 64 bits capabilities
            call    XEOS.cpu.64
            
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
            mov     BYTE [ $XEOS.boot.stage2.longMonde ],   0
            
            jmp     .gdt
          
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
            mov     BYTE [ $XEOS.boot.stage2.longMonde ],   1
    
    ;---------------------------------------------------------------------------
    ; Installs the GDT (Global Descriptor Table)
    ;---------------------------------------------------------------------------
    .gdt:
        
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.gdt
        call                    XEOS.gdt.install
        @XEOS.boot.stage2.print.success
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
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
            call                    XEOS.a20.enabled
            
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
            call                    XEOS.a20.enable.bios
            
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
            call                    XEOS.a20.enable.systemControl
            call                    XEOS.a20.enabled
            
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
            call                    XEOS.a20.enable.keyboard.out
            call                    XEOS.a20.enabled
            
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
            call                    XEOS.a20.enable.keyboard.control
            call                    XEOS.a20.enabled
            
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
        cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
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
            cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
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
            call    XEOS.elf.32.checkHeader
            mov     DWORD [ $XEOS.boot.stage2.entryPoint ], edi
            cmp     ax,     0
            je      .load.verified
            
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
        ; Verifies the kernel image (64 bits ELF)
        ;-----------------------------------------------------------------------
        .load.verify.64:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify.64
            
            ; Verifies the kernel file header, and stores the entry point
            ; address
            mov     si,     @XEOS.boot.stage2.kernel.segment
            call    XEOS.elf.64.checkHeader
            mov     DWORD [ $XEOS.boot.stage2.entryPoint ], edi
            cmp     ax,     0
            je      .load.verified
            
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
            
        .load.verified
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            ; Checks if we must switch the CPU to 64 bits long mode
            cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
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
    
    .error.verify.64:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify.64
        jmp                                 .error
    
    .error:
        
        ; Prints the error message
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.error
        
        ; Waits for a key press
        xor     ax,         ax
        @BIOS.int.keyboard
        
        ; Reboot the computer
        @BIOS.int.reboot
    
    .end:
        
        ; Waits for a key press
        xor     ax,         ax
        @BIOS.int.keyboard
        
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
    
    @XEOS.proc.start 0
    
    ;---------------------------------------------------------------------------
    ; Loads the FAT-12 root directory
    ;---------------------------------------------------------------------------
    .start:
        
        ; Saves registers
        push    si
        
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.fat12.root
        
        ; Offset the FAT-12 root directory location
        mov     di,             @XEOS.boot.stage2.fat.offset
        call    XEOS.io.fat12.loadRootDirectory
        
        ; Checks for an error code
        cmp     ax,         0
        je      .findFile
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
        ; Error - Stores result code in AX
        mov     ax,         1
        
        ; Restores registers
        pop     si
        
        @XEOS.proc.end
        
        ret
    
    ;---------------------------------------------------------------------------
    ; Finds the requested file
    ;---------------------------------------------------------------------------
    .findFile:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.string.numberToString     es, 16, 4, dx, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.color.green.light, @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        @XEOS.string.numberToString     @XEOS.boot.stage2.fat.offset, 16, 4, dx, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.color.green.light, @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.fat12.find
        
        ; Restores registers
        pop     si
        
        ; Stores the location of the first data sector
        mov     WORD [ $XEOS.boot.stage2.dataSector ],  dx
        
        ; location of the FAT-12 root directory
        mov     di,         @XEOS.boot.stage2.fat.offset
        
        ; Finds the second stage bootloader
        call    XEOS.io.fat12.findFile
        
        ; Checks for an error code
        cmp     ax,         0
        je      .loadFile
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
        @XEOS.proc.end
        
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
        mov     bx,         @XEOS.boot.stage2.fat.offset
        
        ; Data sector location
        mov     cx,         WORD [ $XEOS.boot.stage2.dataSector ]
        
        ; Loads the second stage bootloader into memory
        call    XEOS.io.fat12.loadFile
        
        ; Number of sectors read
        mov     WORD[ $XEOS.boot.stage2.kernelSectors ], cx
        
        ; Restores registers
        pop    cx
        pop    bx
        
        ; Checks for an error code
        cmp     ax,         0
        je      .end
        
        @XEOS.boot.stage2.print.failure
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
        @XEOS.proc.end
        
        ; Error - Stores result code in AX
        mov     ax,         3
        
        ret
        
    ;---------------------------------------------------------------------------
    ; End of procedure
    ;---------------------------------------------------------------------------
    .end:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.string.numberToString     @XEOS.boot.stage2.kernel.segment, 16, 4, dx, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.color.green.light, @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        @XEOS.string.numberToString     ax, 16, 4, dx, $XEOS.boot.stage2.str
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.color.green.light, @BIOS.video.color.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
        @XEOS.proc.end
        
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
    
    @XEOS.proc.start 0
    
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
        @BIOS.int.video
        
        ; Restores registers
        pop     si
        
        ; Prints the string
        call BIOS.video.print
    
    @XEOS.proc.end
    
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

        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch32
        
        ; Resets registers
        xor     ax,         ax
        xor     bx,         bx
        xor     cx,         cx
        xor     dx,         dx
        
        ; Gets the cursor position, so it can be restored in 32 bits mode
        mov     ah,         0x03
        @BIOS.int.video
        
        ; Clears the interrupts
        cli
        
        ; Gets the value of the primary control register
        mov     eax,        cr0
        
        ; Sets the lowest bit, indicating the system must run in protected mode
        or      eax,        1
        
        ; Sets the new value - We are now in 32 bits protected mode
        mov     cr0,        eax
        
        ; Setup the 32 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp	    @XEOS.gdt.descriptors.code:.run
        
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

        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.switch64
        
        ; Resets registers
        xor     ax,         ax
        xor     bx,         bx
        xor     cx,         cx
        xor     dx,         dx
        
        ; Gets the cursor position, so it can be restored in 64 bits mode
        mov     ah,         0x03
        @BIOS.int.video
        
        ; Clears the interrupts
        cli
        
        ; Gets the value of the primary control register
        mov     eax,        cr0
        
        ; Sets the lowest bit, indicating the system must run in protected mode
        or      eax,        1
        
        ; Sets the new value - We are now in 64 bits protected mode
        mov     cr0,        eax
        
        ; Setup the 64 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp	    @XEOS.gdt.descriptors.code:.run
        
        ; Halts the system
        hlt
    
; We are in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

%include "xeos.video.inc.32.s"      ; XEOS video services

;-------------------------------------------------------------------------------
; Setups and executes the 32 bits kernel
; 
; Input registers:
;       
;       - DX:       The current cursor position
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
    mov     ax,         @XEOS.gdt.descriptors.data
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    mov     esp,        0x90000
    
    ; Restores the cursor position
    @XEOS.video.cursor.move dl, dh
    
    ; Sets color attributes
    @XEOS.video.setForegroundColor  @XEOS.video.color.white
    @XEOS.video.setBackgroundColor  @XEOS.video.color.black
    
    @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
    @XEOS.video.print               $XEOS.boot.stage2.msg.space
    @XEOS.video.setForegroundColor  @XEOS.video.color.green.light
    @XEOS.video.print               $XEOS.boot.stage2.msg.success
    @XEOS.video.setForegroundColor  @XEOS.video.color.white
    @XEOS.video.print               $XEOS.boot.stage2.msg.space
    @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
    @XEOS.video.print               $XEOS.boot.stage2.nl
    
    .copy:
        
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        @XEOS.video.print               $XEOS.boot.stage2.msg.prompt
        @XEOS.video.setForegroundColor  @XEOS.video.color.white
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
        @XEOS.video.print               $XEOS.boot.stage2.msg.gt
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.move
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        
        ; Number of sectors loaded for the kernel
        mov     eax,        [ $XEOS.boot.stage2.kernelSectors ]
        
        ; Multiplies by the number of bytes per sector
        mov     ebx,        @XEOS.fat12.mbr.bytesPerSector
        mul     ebx
        
        ; We are going to read doubles, so divides the bytes by 4
        mov     ebx,        0x04
        div     ebx
        
        ; Location of the kernel in memory
        mov    esi,         @XEOS.boot.stage2.kernel.segment

        ; Destination for the kernel
        mov     edi,        @XEOS.boot.stage2.kernel.address
        
        ; Clears the direction flag
        cld
        
        ; Counter
        mov     ecx,        eax
        
        .copy.bytes:
            
            ; Moves bytes
            movsd
            
            .copy.bytes.symbol:
                
                ; Saves registers
                pusha
                
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
                    @XEOS.video.putc    0x7C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.2:
                    
                    ; Prints '/'
                    @XEOS.video.putc    0x2F
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.3:
                    
                    ; Prints '-'
                    @XEOS.video.putc    0x2D
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.4:
                    
                    ; Prints '\'      
                    @XEOS.video.putc    0x5C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.done:
                    
                    ; Restores registers
                    popa
            
            ; Continues to move bytes
            loop    .copy.bytes
            
            @XEOS.video.setForegroundColor  @XEOS.video.color.white
            @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
            @XEOS.video.print               $XEOS.boot.stage2.msg.space
            @XEOS.video.setForegroundColor  @XEOS.video.color.green.light
            @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.address
            @XEOS.video.setForegroundColor  @XEOS.video.color.white
            @XEOS.video.print               $XEOS.boot.stage2.msg.space
            @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
            @XEOS.video.print               $XEOS.boot.stage2.nl
    .run:
        
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        @XEOS.video.print               $XEOS.boot.stage2.msg.prompt
        @XEOS.video.setForegroundColor  @XEOS.video.color.white
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
        @XEOS.video.print               $XEOS.boot.stage2.msg.gt
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.run
        @XEOS.video.print               $XEOS.boot.stage2.nl
        
        ; Jumps to the kernel code
        jmp	@XEOS.gdt.descriptors.code:@XEOS.boot.stage2.kernel.address;
        
    ; Halts the system
    hlt

;-------------------------------------------------------------------------------
; Setups and executes the 64 bits kernel
; 
; Input registers:
;       
;       - DX:       The current cursor position
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
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         @XEOS.gdt.descriptors.data
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    mov     esp,        0x90000
    
    ; Restores the cursor position
    @XEOS.video.cursor.move dl, dh
    
    ; Sets color attributes
    @XEOS.video.setForegroundColor  @XEOS.video.color.white
    @XEOS.video.setBackgroundColor  @XEOS.video.color.black
    
    @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
    @XEOS.video.print               $XEOS.boot.stage2.msg.space
    @XEOS.video.setForegroundColor  @XEOS.video.color.green.light
    @XEOS.video.print               $XEOS.boot.stage2.msg.success
    @XEOS.video.setForegroundColor  @XEOS.video.color.white
    @XEOS.video.print               $XEOS.boot.stage2.msg.space
    @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
    @XEOS.video.print               $XEOS.boot.stage2.nl
    
    .copy:
        
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        @XEOS.video.print               $XEOS.boot.stage2.msg.prompt
        @XEOS.video.setForegroundColor  @XEOS.video.color.white
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
        @XEOS.video.print               $XEOS.boot.stage2.msg.gt
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.move
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        
        ; Number of sectors loaded for the kernel
        mov     eax,        [ $XEOS.boot.stage2.kernelSectors ]
        
        ; Multiplies by the number of bytes per sector
        mov     ebx,        @XEOS.fat12.mbr.bytesPerSector
        mul     ebx
        
        ; We are going to read doubles, so divides the bytes by 4
        mov     ebx,        0x04
        div     ebx
        
        ; Location of the kernel in memory
        mov    esi,         @XEOS.boot.stage2.kernel.segment

        ; Destination for the kernel
        mov     edi,        @XEOS.boot.stage2.kernel.address
        
        ; Clears the direction flag
        cld
        
        ; Counter
        mov     ecx,        eax
        
        .copy.bytes:
            
            ; Moves bytes
            movsd
            
            .copy.bytes.symbol:
                
                ; Saves registers
                pusha
                
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
                    @XEOS.video.putc    0x7C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.2:
                    
                    ; Prints '/'
                    @XEOS.video.putc    0x2F
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.3:
                    
                    ; Prints '-'
                    @XEOS.video.putc    0x2D
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.char.4:
                    
                    ; Prints '\'      
                    @XEOS.video.putc    0x5C
                    jmp                 .copy.bytes.symbol.done
                    
                .copy.bytes.symbol.done:
                    
                    ; Restores registers
                    popa
            
            ; Continues to move bytes
            loop    .copy.bytes
            
            @XEOS.video.setForegroundColor  @XEOS.video.color.white
            @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
            @XEOS.video.print               $XEOS.boot.stage2.msg.space
            @XEOS.video.setForegroundColor  @XEOS.video.color.green.light
            @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.address
            @XEOS.video.setForegroundColor  @XEOS.video.color.white
            @XEOS.video.print               $XEOS.boot.stage2.msg.space
            @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
            @XEOS.video.print               $XEOS.boot.stage2.nl
    .run:
        
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.left
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.setForegroundColor  @XEOS.video.color.gray.light
        @XEOS.video.print               $XEOS.boot.stage2.msg.prompt
        @XEOS.video.setForegroundColor  @XEOS.video.color.white
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.bracket.right
        @XEOS.video.print               $XEOS.boot.stage2.msg.gt
        @XEOS.video.print               $XEOS.boot.stage2.msg.space
        @XEOS.video.print               $XEOS.boot.stage2.msg.kernel.run
        @XEOS.video.print               $XEOS.boot.stage2.nl
        
        ; Jumps to the kernel code
        jmp	@XEOS.gdt.descriptors.code:@XEOS.boot.stage2.kernel.address;
        
    ; Halts the system
    hlt