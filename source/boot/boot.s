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

; DEBUG - Forces the 32 bits mode
%define XEOS32

; Jumps to the entry point
start: jmp main

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.s"     ; General constants
%include "XEOS.macros.inc.s"        ; General macros
%include "BIOS.int.inc.s"           ; BIOS interrupts
%include "BIOS.video.inc.16.s"      ; BIOS video services
%include "XEOS.io.fat12.inc.16.s"   ; FAT-12 IO procedures
%include "XEOS.ascii.inc.s"         ; ASCII table
%include "XEOS.cpu.inc.16.s"        ; CPU informations
%include "XEOS.gdt.inc.s"           ; GDT - Global Descriptor Table
%include "XEOS.a20.inc.16.s"        ; 20th address line enabling
%include "XEOS.elf.inc.16.s"        ; ELF binary format support
%include "XEOS.string.inc.16.s"     ; String utilities
%include "XEOS.debug.inc.16.s"      ; Debugging

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.dataSector                    dw  0
$XEOS.boot.stage2.kernelSectors                 dw  0
$XEOS.boot.stage2.nl                            db  @ASCII.NL,  @ASCII.NUL
$XEOS.files.kernel.32                           db  "XEOS32  ELF", @ASCII.NUL
$XEOS.files.kernel.64                           db  "XEOS64  ELF", @ASCII.NUL
$XEOS.boot.stage2.cpu.vendor                    db  "            ", @ASCII.NUL
$XEOS.boot.stage2.str                           db  "                              ", @ASCII.NUL
$XEOS.boot.stage2.longMonde                     db  0

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage2.msg.prompt                    db  "XEOS", @ASCII.NUL
$XEOS.boot.stage2.msg.pipe                      db  186, @ASCII.NUL
$XEOS.boot.stage2.msg.gt                        db  ">", @ASCII.NUL
$XEOS.boot.stage2.msg.lt                        db  "<", @ASCII.NUL
$XEOS.boot.stage2.msg.space                     db  " ", @ASCII.NUL
$XEOS.boot.stage2.msg.bracket.left              db  "[", @ASCII.NUL
$XEOS.boot.stage2.msg.bracket.right             db  "]", @ASCII.NUL
$XEOS.boot.stage2.msg.separator                 db  ":", @ASCII.NUL
$XEOS.boot.stage2.msg.yes                       db  "YES", @ASCII.NUL
$XEOS.boot.stage2.msg.no                        db  "NO", @ASCII.NUL
$XEOS.boot.stage2.msg.success                   db  "OK", @ASCII.NUL
$XEOS.boot.stage2.msg.failure                   db  "FAIL", @ASCII.NUL
$XEOS.boot.stage2.msg.greet                     db  "Entering the second stage bootloader:            ", @ASCII.NUL
$XEOS.boot.stage2.msg.version                   db  "XSBoot-x86/0.2.0", @ASCII.NUL
$XEOS.boot.stage2.msg.hr.top                    db  201, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 187, @ASCII.NUL
$XEOS.boot.stage2.msg.hr.bottom                 db  200, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, \
                                                    205, 205, 205, 205, 205, 205, 205, 188, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1.left          db  "                ", 4, @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1               db  " XEOS - x86 Experimental Operating System ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.1.right         db  4 ,"                 ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.2               db  "                                                                             ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.3               db  "      Copyright (c) 2010-2012 Jean-David Gadina <macmade@eosgarden.com>      ", @ASCII.NUL
$XEOS.boot.stage2.msg.copyright.4               db  "                             All Rights Reserved                             ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu                       db  "Getting CPU informations:                        ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.vendor                db  "            ", 26, " CPU vendor:                                  ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type                  db  "            ", 26, " CPU type:                                    ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions          db  "            ", 26, " CPU ISA:                                     ", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.32               db  "i386", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.type.64               db  "x86_64", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.32       db  "32-bits", @ASCII.NUL
$XEOS.boot.stage2.msg.cpu.instructions.64       db  "64-bits", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.load               db  "Loading the kernel image:                        ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.root                db  "            ", 26, " Loading the FAT-12 directory into memory:    ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.find                db  "            ", 26, " Locating the kernel image:                   ", @ASCII.NUL
$XEOS.boot.stage2.msg.fat12.load                db  "            ", 26, " Loading the kernel image into memory:        ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify.32          db  "Verifiying the kernel image (ELF-32):            ", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.verify.64          db  "Verifiying the kernel image (ELF-64):            ", @ASCII.NUL
$XEOS.boot.stage2.msg.gdt                       db  "Installing the GDT:                              ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.check                 db  "Checking if the A-20 address line is enabled:    ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.bios                  db  "Enabling the A-20 address line (BIOS):           ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardControl       db  "Enabling the A-20 address line (KBDCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.keyboardOut           db  "Enabling the A-20 address line (KBDOUT):         ", @ASCII.NUL
$XEOS.boot.stage2.msg.a20.systemControl         db  "Enabling the A-20 address line (SYSCTRL):        ", @ASCII.NUL
$XEOS.boot.stage2.msg.switch32                  db  "Switching the CPU to 32 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.switch64                  db  "Switching the CPU to 64 bits mode", @ASCII.NUL
$XEOS.boot.stage2.msg.kernel.run                db  "Moving and executing the kernel", @ASCII.NUL
$XEOS.boot.stage2.msg.error                     db  "Press any key to reboot: ", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.dir           db  "Error: cannot load the FAT-12 root directory",@ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.find          db  "Error: file not found", @ASCII.NUL
$XEOS.boot.stage2.msg.error.fat12.load          db  "Error: cannot load the requested file", @ASCII.NUL
$XEOS.boot.stage2.msg.error.a20                 db  "Error: cannot enable the A-20 address line", @ASCII.NUL
$XEOS.boot.stage2.msg.error.cpuid               db  "Error: processor does not support CPUID", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify32            db  "Error: invalid kernel ELF-32 image", @ASCII.NUL
$XEOS.boot.stage2.msg.error.verify64            db  "Error: invalid kernel ELF-64 image", @ASCII.NUL

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Segments and offsets
%define @XEOS.boot.stage2.fat.offset        0x7900
%define @XEOS.boot.stage2.kernel.segment    0x1000

; Prints text in color
%macro @XEOS.boot.stage2.print.color 3
    
    @BIOS.video.createScreenColor bl, %2, %3
    
    mov     si,         %1
    call    XEOS.boot.stage2.print.color
    
%endmacro

; Prints a strings with brackets
%macro @XEOS.boot.stage2.print.bracket.green 1
    
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.colors.white,       @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @BIOS.video.colors.green.light, @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.colors.white,       @BIOS.video.colors.black
    pop                             si
    
%endmacro

; Prints a strings with brackets
%macro @XEOS.boot.stage2.print.bracket.red 1
    
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.colors.white,       @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    push                            si
    @XEOS.boot.stage2.print.color   %1,                                     @BIOS.video.colors.red.light,   @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.colors.white,       @BIOS.video.colors.black
    pop                             si
    
%endmacro

; Prints the prompt
%macro @XEOS.boot.stage2.print.prompt 0
    
    push                            si
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.left,     @BIOS.video.colors.white,       @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.prompt,           @BIOS.video.colors.gray.light,  @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.bracket.right,    @BIOS.video.colors.white,       @BIOS.video.colors.black
    @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.gt,               @BIOS.video.colors.white,       @BIOS.video.colors.black
    @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
    pop                             si
    
%endmacro

; Prints the success message
%macro @XEOS.boot.stage2.print.success 0

    @XEOS.boot.stage2.print.bracket.green $XEOS.boot.stage2.msg.success

%endmacro

; Prints the success message
%macro @XEOS.boot.stage2.print.failure 0
    
    @XEOS.boot.stage2.print.bracket.red $XEOS.boot.stage2.msg.failure

%endmacro

; Prints the yes message
%macro @XEOS.boot.stage2.print.yes 0

    @XEOS.boot.stage2.print.bracket.green $XEOS.boot.stage2.msg.yes

%endmacro

; Prints the no message
%macro @XEOS.boot.stage2.print.no 0

    @XEOS.boot.stage2.print.bracket.red $XEOS.boot.stage2.msg.no

%endmacro

; Prints a new line with a message, prefixed by the prompt
%macro @XEOS.boot.stage2.print.line 1
    
    @XEOS.boot.stage2.print.prompt
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.colors.white, @BIOS.video.colors.black
    @BIOS.video.print               $XEOS.boot.stage2.nl
    
%endmacro

; Prints a new line with an error message, prefixed by the prompt
%macro @XEOS.boot.stage2.print.line.error 1
    
    @XEOS.boot.stage2.print.prompt
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.colors.red.light, @BIOS.video.colors.black
    @BIOS.video.print               $XEOS.boot.stage2.nl
    
%endmacro

; Prints a string
%macro @XEOS.boot.stage2.print      1
    
    push                            si
    @XEOS.boot.stage2.print.color   %1, @BIOS.video.colors.white, @BIOS.video.colors.black
    pop                             si
    
%endmacro

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
        
        ; Prints the copyright note
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.top,               @BIOS.video.colors.white,       @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.left,     @BIOS.video.colors.white,       @BIOS.video.colors.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1,          @BIOS.video.colors.brown.light, @BIOS.video.colors.black
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.1.right,    @BIOS.video.colors.white,       @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.2,          @BIOS.video.colors.white,       @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.3,          @BIOS.video.colors.gray.light,  @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.copyright.4,          @BIOS.video.colors.gray.light,  @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.pipe
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.msg.hr.bottom,            @BIOS.video.colors.white,       @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
        ; Prints the welcome message
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.greet
        @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.version
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
        ; call XEOS.debug.registers.dump
        
    ;---------------------------------------------------------------------------
    ; CPU check
    ;---------------------------------------------------------------------------
    .cpu:
        
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
        je      .x86_64
    
    ;---------------------------------------------------------------------------
    ; i386 CPU
    ;---------------------------------------------------------------------------
    .i386:
        
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.type
        @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.type.32
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.instructions
        @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.instructions.32
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
        ; 32 bits kernel is going to be loaded
        mov     si,             $XEOS.files.kernel.32
        
        ; We won't switch to 64 bits long mode
        mov     BYTE [ $XEOS.boot.stage2.longMonde ],   0
        
        jmp     .load
      
    ;---------------------------------------------------------------------------
    ; x86_c64 CPU
    ;---------------------------------------------------------------------------  
    .x86_64:
        
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.type
        @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.type.64
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.cpu.instructions
        @XEOS.boot.stage2.print.bracket.green   $XEOS.boot.stage2.msg.cpu.instructions.64
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.nl
        
        ; 64 bits kernel is going to be loaded
        mov     si,             $XEOS.files.kernel.64
        
        ; We'll need to switch to 64 bits long mode
        mov     BYTE [ $XEOS.boot.stage2.longMonde ],   1
        
    ;---------------------------------------------------------------------------
    ; Loads the kernel file
    ;---------------------------------------------------------------------------
    .load:
        
        ; Loads the XEOS kernel into memory
        push                            si
        @XEOS.boot.stage2.print.prompt
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.kernel.load
        pop                             si
        @XEOS.boot.stage2.print.bracket.green   si
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        call                            XEOS.boot.stage2.kernel.load
        
        cmp     ax,         1
        je      .error.fat12.dir
        
        cmp     ax,         2
        je      .error.fat12.find
        
        cmp     ax,         3
        je      .error.fat12.load
        
        ; Checks if we must check for an ELF-64 or ELF-32 image
        cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
        je      .verify64
        
        ;-----------------------------------------------------------------------
        ; Verifies the kernel image (32 bits ELF)
        ;-----------------------------------------------------------------------
        .verify32:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify.32
            
            ; Verifies the kernel file header
            mov     si,     @XEOS.boot.stage2.kernel.segment
            call    XEOS.elf.32.checkHeader
            cmp     ax,     0
            je      .verified
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.verify32
            
        ;-----------------------------------------------------------------------
        ; Verifies the kernel image (64 bits ELF)
        ;-----------------------------------------------------------------------
        .verify64:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.kernel.verify.64
            
            ; Verifies the kernel file header
            mov     si,     @XEOS.boot.stage2.kernel.segment
            call    XEOS.elf.64.checkHeader
            cmp     ax,     0
            je      .verified
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.verify64
            
        .verified
            
            @XEOS.boot.stage2.print.success
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
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
        .check:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.check
            call                    XEOS.a20.enabled
            
            cmp     ax,             0
            je      .enable
            
            @XEOS.boot.stage2.print.yes
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .a20enabled
            
        .enable:
            
            @XEOS.boot.stage2.print.no
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
        ;-----------------------------------------------------------------------
        ; A-20 enabling (BIOS)
        ;-----------------------------------------------------------------------
        .bios:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.bios
            call                    XEOS.a20.enable.bios
            
            cmp     ax,             0
            je      .a20success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
          
        ;-----------------------------------------------------------------------
        ; A-20 enabling (system controller)
        ;-----------------------------------------------------------------------  
        .system:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.systemControl
            call                    XEOS.a20.enable.systemControl
            call                    XEOS.a20.enabled
            
            cmp     ax,             1
            je      .a20success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
         
        ;-----------------------------------------------------------------------
        ; A-20 enabling (keyboard out port)
        ;-----------------------------------------------------------------------   
        .keyboard.out:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.keyboardOut
            call                    XEOS.a20.enable.keyboard.out
            call                    XEOS.a20.enabled
            
            cmp     ax,             1
            je      .a20success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
        ;-----------------------------------------------------------------------
        ; A-20 enabling (keyboard controller)
        ;-----------------------------------------------------------------------
        .keyboard.control:
            
            @XEOS.boot.stage2.print.prompt
            @XEOS.boot.stage2.print $XEOS.boot.stage2.msg.a20.keyboardControl
            call                    XEOS.a20.enable.keyboard.control
            call                    XEOS.a20.enabled
            
            cmp     ax,             1
            je      .a20success
            
            @XEOS.boot.stage2.print.failure
            @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
            
            jmp     .error.a20
            
    .a20success:
        
        @XEOS.boot.stage2.print.success
        @XEOS.boot.stage2.print $XEOS.boot.stage2.nl
        
    .a20enabled:
        
        ; Checks if we must switch the CPU to 64 bits long mode
        cmp     BYTE [ $XEOS.boot.stage2.longMonde ],   1
        je      .switch64
      
    ;---------------------------------------------------------------------------
    ; Switches the CPU to 32 bits mode
    ;---------------------------------------------------------------------------      
    .switch32:
            
        @XEOS.boot.stage2.print.line $XEOS.boot.stage2.msg.switch32
        @XEOS.boot.stage2.print.line $XEOS.boot.stage2.msg.kernel.run
        
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
        
        ; Setup the 32 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp	    @XEOS.gdt.descriptors.code.kernel:XEOS.boot.stage2.kernel.setup.32
      
    ;---------------------------------------------------------------------------
    ; Switches the CPU to 64 bits mode
    ;---------------------------------------------------------------------------
    .switch64:
        
        @XEOS.boot.stage2.print.line $XEOS.boot.stage2.msg.switch64
        @XEOS.boot.stage2.print.line $XEOS.boot.stage2.msg.kernel.run
        
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
        
        ; Setup the 32 bits kernel
        ; We are doing a far jump using our code descriptor
        ; This way, we are entering ring 0 (from the GDT), and CS is fixed.
        jmp	    @XEOS.gdt.descriptors.code.kernel:XEOS.boot.stage2.kernel.setup.64
        
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
    
    .error.verify32:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify32
        jmp                                 .error
    
    .error.verify64:
        
        @XEOS.boot.stage2.print.line.error  $XEOS.boot.stage2.msg.error.verify64
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
    
    ;---------------------------------------------------------------------------
    ; Loads the FAT-12 root directory
    ;---------------------------------------------------------------------------
    .start:
        
        ; Saves registers
        push    di
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
        pop     di
        
        ret
    
    ;---------------------------------------------------------------------------
    ; Finds the requested file
    ;---------------------------------------------------------------------------
    .findFile:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        
        mov     eax,        es
        mov     bx,         16
        mov     cx,         4
        xor     dx,         dx
        mov     di,         $XEOS.boot.stage2.str
        call    XEOS.string.utoa
        
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.colors.green.light, @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        
        mov     eax,        @XEOS.boot.stage2.fat.offset
        mov     bx,         16
        mov     cx,         4
        xor     dx,         dx
        mov     di,         $XEOS.boot.stage2.str
        call    XEOS.string.utoa
        
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.colors.green.light, @BIOS.video.colors.black
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
        
        ; Restores registers
        pop    di
        
        ; Checks for an error code
        cmp     ax,         0
        je      .loadFile
        
        @XEOS.boot.stage2.print.failure
        @BIOS.video.print   $XEOS.boot.stage2.nl
        
        ; Error - Stores result code in AX
        mov     ax,         2
        
        ret
    
    ;---------------------------------------------------------------------------
    ; Loads the requested file
    ;---------------------------------------------------------------------------
    .loadFile:
        
        @XEOS.boot.stage2.print.success
        @BIOS.video.print   $XEOS.boot.stage2.nl
        
        @XEOS.boot.stage2.print                 $XEOS.boot.stage2.msg.fat12.load
        
        ; Saves registers
        push    bx
        push    cx
        
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
        @BIOS.video.print   $XEOS.boot.stage2.nl
        
        ; Error - Stores result code in AX
        mov     ax,         3
        
        ret
        
    ;---------------------------------------------------------------------------
    ; End of procedure
    ;---------------------------------------------------------------------------
    .end:
        
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.left
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        
        mov     eax,        @XEOS.boot.stage2.kernel.segment
        mov     bx,         16
        mov     cx,         4
        xor     dx,         dx
        mov     di,         $XEOS.boot.stage2.str
        call    XEOS.string.utoa
        
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.colors.green.light, @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.separator
        
        xor     eax,        eax
        mov     bx,         16
        mov     cx,         4
        xor     dx,         dx
        mov     di,         $XEOS.boot.stage2.str
        call    XEOS.string.utoa
        
        @XEOS.boot.stage2.print.color   $XEOS.boot.stage2.str, @BIOS.video.colors.green.light, @BIOS.video.colors.black
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.space
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.msg.bracket.right
        @XEOS.boot.stage2.print         $XEOS.boot.stage2.nl
        
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
    
    ; Saves registers
    pusha
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
    
    ; Restores registers
    popa
    
    ret

; We are in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; Setups and executes the 64 bits kernel
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
XEOS.boot.stage2.kernel.setup.32:
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         @XEOS.gdt.descriptors.data.kernel
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    mov     esp,        0x90000
    
    ; We are going to move the kernel at 1Mb in memory
    .moveKernel:
        
        ; Number of sectors that were read to load the kernel at its current
        ; memory location (by the XEOS.io.fat12.loadFile procedure)
        mov     eax,        DWORD [ $XEOS.boot.stage2.kernelSectors ]
        
        ; Number of bytes per sector
        mov     ebx,        DWORD @XEOS.fat12.mbr.bytesPerSector
        
        ; Gets the number of bytes to read
        mul     ebx
        
        ; We are going to read doubles, so divides the bytes by 4
        mov     ebx,        4
        div     ebx
        
        ; Actual memory location for the kernel code
        ; 
        ; We loaded it at 0x1000:0000 in real mode, so the protected mode
        ; address is 0x10000 (0x1000 * 16 + 0).
        mov     esi,        0x10000
        add     esi,        0x1000
        
        ; Final destination for the kernel code (1MB)
        mov     edi,        0x100000
        
        ; Copies the kernel code
        mov     ecx,        eax
        rep     movsd
    
    ; We can now jump to the kernel code
    jmp     @XEOS.gdt.descriptors.code.kernel:0x100000
    
    ; Halts the system
    cli
    hlt

;-------------------------------------------------------------------------------
; Setups and executes the 64 bits kernel
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
XEOS.boot.stage2.kernel.setup.64:
    
    ; Sets the data segments to the GDT data descriptor
    mov     ax,         @XEOS.gdt.descriptors.data.kernel
    mov     ds,         ax
    mov     ss,         ax
    mov     es,         ax
    mov     esp,        0x90000
    
    ; Halts the system
    cli
    hlt