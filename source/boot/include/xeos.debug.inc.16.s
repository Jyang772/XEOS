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
; Debug procedures
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------
%ifndef __XEOS_DEBUG_INC_16_ASM__
%define __XEOS_DEBUG_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.s"     ; General constants
%include "XEOS.macros.inc.s"        ; General macros
%include "XEOS.ascii.inc.s"         ; ASCII table
%include "BIOS.video.inc.16.s"      ; BIOS video services
%include "XEOS.string.inc.16.s"     ; String utilities

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.debug.register.eax                        dd  0
$XEOS.debug.register.ebx                        dd  0
$XEOS.debug.register.ecx                        dd  0
$XEOS.debug.register.edx                        dd  0
$XEOS.debug.register.esi                        dd  0
$XEOS.debug.register.edi                        dd  0
$XEOS.debug.register.esp                        dd  0
$XEOS.debug.register.ebp                        dd  0
$XEOS.debug.register.cs                         dw  0
$XEOS.debug.register.ds                         dw  0
$XEOS.debug.register.es                         dw  0
$XEOS.debug.register.fs                         dw  0
$XEOS.debug.register.gs                         dw  0
$XEOS.debug.register.ss                         dw  0
$XEOS.debug.register.eflags                     dd  0
$XEOS.debug.str                                 db  "                              ", @ASCII.NUL

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.debug.nl                              db  @ASCII.NL, @ASCII.NUL
$XEOS.debug.pipe                            db  32,  179, 32, @ASCII.NUL
$XEOS.debug.pipe.start                      db  179, 32, @ASCII.NUL
$XEOS.debug.hr.top                          db  218, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 191, 32, @ASCII.NUL
$XEOS.debug.hr.middle.top                   db  195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 194, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 194, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 194, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                194, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, 32, @ASCII.NUL
$XEOS.debug.hr.middle                       db  195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 197, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, 32, @ASCII.NUL
$XEOS.debug.hr.middle.short                 db  195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 197, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                180, 32, @ASCII.NUL
$XEOS.debug.hr.middle.bottom                db  195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                180, 32, @ASCII.NUL
$XEOS.debug.hr.bottom                       db  192, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 217, 32, @ASCII.NUL
$XEOS.debug.hr.segment                      db  32,  195, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, 32, @ASCII.NUL
$XEOS.debug.hr.flags.top                    db  195, 196, 196, 196, 196, 196, 196, 196, 196, 194, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 197, 196, 196, 196, 196, 196, 196, 196, 196, 194, 196, 196, 196, 193, 196, 196, 196, \
                                                196, 194, 196, 196, 196, 196, 196, 193, 196, 196, 194, 196, 196, 196, 196, 196, 196, 196, \
                                                193, 194, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, 32, @ASCII.NUL
$XEOS.debug.hr.flags.bottom                 db  195, 196, 196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 193, 196, 196, 196, 196, 196, 196, 196, \
                                                196, 193, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 180, 32, @ASCII.NUL
$XEOS.debug.str.registers.dump.header.left  db  "                   ", 4, @ASCII.NUL
$XEOS.debug.str.registers.dump.header       db  " DEBUG - x86 registers ", @ASCII.NUL
$XEOS.debug.str.registers.dump.header.right db  4, "                   ", @ASCII.NUL
$XEOS.debug.str.registers.dump.footer       db  "                   Press any key to continue                   ", @ASCII.NUL
$XEOS.debug.str.register.eax                db  "EAX: ", @ASCII.NUL
$XEOS.debug.str.register.ax                 db  "AX: ", @ASCII.NUL
$XEOS.debug.str.register.ah                 db  "AH: ", @ASCII.NUL
$XEOS.debug.str.register.al                 db  "AL: ", @ASCII.NUL
$XEOS.debug.str.register.ebx                db  "EBX: ", @ASCII.NUL
$XEOS.debug.str.register.bx                 db  "BX: ", @ASCII.NUL
$XEOS.debug.str.register.bh                 db  "BH: ", @ASCII.NUL
$XEOS.debug.str.register.bl                 db  "BL: ", @ASCII.NUL
$XEOS.debug.str.register.ecx                db  "ECX: ", @ASCII.NUL
$XEOS.debug.str.register.cx                 db  "CX: ", @ASCII.NUL
$XEOS.debug.str.register.ch                 db  "CH: ", @ASCII.NUL
$XEOS.debug.str.register.cl                 db  "CL: ", @ASCII.NUL
$XEOS.debug.str.register.edx                db  "EDX: ", @ASCII.NUL
$XEOS.debug.str.register.dx                 db  "DX: ", @ASCII.NUL
$XEOS.debug.str.register.dh                 db  "DH: ", @ASCII.NUL
$XEOS.debug.str.register.dl                 db  "DL: ", @ASCII.NUL
$XEOS.debug.str.register.esi                db  "ESI: ", @ASCII.NUL
$XEOS.debug.str.register.si                 db  "SI: ", @ASCII.NUL
$XEOS.debug.str.register.edi                db  "EDI: ", @ASCII.NUL
$XEOS.debug.str.register.di                 db  "DI: ", @ASCII.NUL
$XEOS.debug.str.register.esp                db  "ESP: ", @ASCII.NUL
$XEOS.debug.str.register.sp                 db  "SP: ", @ASCII.NUL
$XEOS.debug.str.register.ebp                db  "EBP: ", @ASCII.NUL
$XEOS.debug.str.register.bp                 db  "BP: ", @ASCII.NUL
$XEOS.debug.str.register.cs                 db  "CS: ", @ASCII.NUL
$XEOS.debug.str.register.ds                 db  "DS: ", @ASCII.NUL
$XEOS.debug.str.register.es                 db  "ES: ", @ASCII.NUL
$XEOS.debug.str.register.fs                 db  "FS: ", @ASCII.NUL
$XEOS.debug.str.register.gs                 db  "GS: ", @ASCII.NUL
$XEOS.debug.str.register.ss                 db  "SS: ", @ASCII.NUL
$XEOS.debug.str.register.flags.cf           db  " CF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.bf           db  " BF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.af           db  " AF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.zf           db  " ZF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.sf           db  " SF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.tf           db  " TF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.if           db  " IF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.df           db  " DF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.of           db  " OF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.io           db  " IO: ", @ASCII.NUL
$XEOS.debug.str.register.flags.pl           db  " PL: ", @ASCII.NUL
$XEOS.debug.str.register.flags.nt           db  " NT: ", @ASCII.NUL
$XEOS.debug.str.register.flags.rf           db  " RF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.vm           db  " VM: ", @ASCII.NUL
$XEOS.debug.str.register.flags.ac           db  " AC: ", @ASCII.NUL
$XEOS.debug.str.register.flags.vif          db  "VIF: ", @ASCII.NUL
$XEOS.debug.str.register.flags.vip          db  "VIP: ", @ASCII.NUL
$XEOS.debug.str.register.flags.id           db  " ID: ", @ASCII.NUL
$XEOS.debug.str.pad.16                      db  177, 177, 177, 177, 177, 177, 177, 177, 177, 177, @ASCII.NUL
$XEOS.debug.str.pad.8                       db  177, 177, 177, 177, 177, 177, 177, 177, @ASCII.NUL
$XEOS.debug.str.pad.flags                   db  177, 177, 177, 177, 177, 177, 177, 177, 177, @ASCII.NUL

;-------------------------------------------------------------------------------
; Definitions & Macros
;-------------------------------------------------------------------------------

; Prints text in color
%macro @XEOS.debug.print.color 3
    
    @BIOS.video.createScreenColor bl, %2, %3
    
    mov     si,         %1
    call    XEOS.debug.print.color
    
%endmacro

; Prints text
%macro @XEOS.debug.print 1
    
     @XEOS.debug.print.color %1, @BIOS.video.colors.white, @BIOS.video.colors.black
    
%endmacro

%macro @XEOS.debug.print.register.gp8 1
    
    @XEOS.debug.print   $XEOS.debug.pipe.start
    
    @XEOS.debug.print.color $XEOS.debug.str.register.e%1x, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1x ]
    mov                     bx,     16
    mov                     cx,     8
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
    @XEOS.debug.print.color $XEOS.debug.str.register.%1x, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1x ]
    and                     eax,    0x0000FFFF
    mov                     bx,     16
    mov                     cx,     4
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
    @XEOS.debug.print.color $XEOS.debug.str.register.%1h, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1x ]
    and                     eax,    0x0000FFFF
    shr                     eax,    8
    mov                     bx,     16
    mov                     cx,     2
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
    @XEOS.debug.print.color $XEOS.debug.str.register.%1l, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1x ]
    and                     eax,    0x000000FF
    mov                     bx,     16
    mov                     cx,     2
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
%endmacro

%macro @XEOS.debug.print.register.gp16 1
    
    @XEOS.debug.print   $XEOS.debug.pipe.start
    
    @XEOS.debug.print.color $XEOS.debug.str.register.e%1, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1 ]
    mov                     bx,     16
    mov                     cx,     8
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
    @XEOS.debug.print.color $XEOS.debug.str.register.%1, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.e%1 ]
    and                     eax,    0x0000FFFF
    mov                     bx,     16
    mov                     cx,     4
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
%endmacro

%macro @XEOS.debug.print.register.segment 1
    
    @XEOS.debug.print.color $XEOS.debug.str.register.%1s, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.%1s ]
    and                     eax,    0x0000FFFF
    mov                     bx,     16
    mov                     cx,     4
    mov                     dx,     1
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
%endmacro

%macro @XEOS.debug.print.register.flag 2
    
    @XEOS.debug.print.color $XEOS.debug.str.register.flags.%1, @BIOS.video.colors.gray.light, @BIOS.video.colors.black
    mov                     eax,    DWORD [ $XEOS.debug.register.eflags ]
    shr                     eax,    %2
    and                     eax,    0x00000001
    mov                     bx,     16
    xor                     cx,     cx
    xor                     dx,     dx
    mov                     di,     $XEOS.debug.str
    call                    XEOS.string.utoa
    @XEOS.debug.print       $XEOS.debug.str
    
    @XEOS.debug.print   $XEOS.debug.pipe
    
%endmacro

XEOS.debug.registers.dump:
    
    pusha
    
    mov     DWORD [ $XEOS.debug.register.eax ], eax
    mov     DWORD [ $XEOS.debug.register.ebx ], ebx
    mov     DWORD [ $XEOS.debug.register.ecx ], ecx
    mov     DWORD [ $XEOS.debug.register.edx ], edx
    mov     DWORD [ $XEOS.debug.register.esi ], esi
    mov     DWORD [ $XEOS.debug.register.edi ], edi
    mov     DWORD [ $XEOS.debug.register.esp ], esp
    mov     DWORD [ $XEOS.debug.register.ebp ], ebp
    mov      WORD [ $XEOS.debug.register.cs  ], cs
    mov      WORD [ $XEOS.debug.register.ds  ], ds
    mov      WORD [ $XEOS.debug.register.es  ], es
    mov      WORD [ $XEOS.debug.register.fs  ], fs
    mov      WORD [ $XEOS.debug.register.gs  ], gs
    mov      WORD [ $XEOS.debug.register.ss  ], ss
    
    pushfd
    pop     eax
    mov     DWORD [ $XEOS.debug.register.eflags ],  eax
    
    @XEOS.debug.print       $XEOS.debug.hr.top
    @BIOS.video.print       $XEOS.debug.nl
    @XEOS.debug.print       $XEOS.debug.pipe.start
    @XEOS.debug.print       $XEOS.debug.str.registers.dump.header.left
    @XEOS.debug.print.color $XEOS.debug.str.registers.dump.header,  @BIOS.video.colors.brown.light, @BIOS.video.colors.black
    @XEOS.debug.print       $XEOS.debug.str.registers.dump.header.right
    @XEOS.debug.print       $XEOS.debug.pipe
    @BIOS.video.print       $XEOS.debug.nl
    @XEOS.debug.print       $XEOS.debug.hr.middle.top
    @BIOS.video.print       $XEOS.debug.nl
    
    @XEOS.debug.print.register.gp8      a
    @XEOS.debug.print.register.segment  c
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print.register.gp8      b
    @XEOS.debug.print.register.segment  d
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print.register.gp8      c
    @XEOS.debug.print.register.segment  e
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print.register.gp8      d
    @XEOS.debug.print.register.segment  f
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print                   $XEOS.debug.hr.middle.short
    @XEOS.debug.print.register.segment  g
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print.register.gp16     si
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.register.segment  s
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print.register.gp16     di
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.hr.segment
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print.register.gp16     sp
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.16, @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print.register.gp16     bp
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.8,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print.color             $XEOS.debug.str.pad.16, @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print                   $XEOS.debug.hr.flags.top
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print                   $XEOS.debug.pipe.start
    @XEOS.debug.print.register.flag     cf, 0
    @XEOS.debug.print.register.flag     bf, 2
    @XEOS.debug.print.register.flag     af, 4
    @XEOS.debug.print.register.flag     zf, 6
    @XEOS.debug.print.register.flag     sf, 7
    @XEOS.debug.print.register.flag     zf, 8
    
    @XEOS.debug.print.color             $XEOS.debug.str.pad.flags,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print                   $XEOS.debug.pipe.start
    @XEOS.debug.print.register.flag     if, 9
    @XEOS.debug.print.register.flag     df, 10
    @XEOS.debug.print.register.flag     of, 11
    @XEOS.debug.print.register.flag     io, 12
    @XEOS.debug.print.register.flag     pl, 13
    @XEOS.debug.print.register.flag     nt, 14
    
    @XEOS.debug.print.color             $XEOS.debug.str.pad.flags,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @BIOS.video.print                   $XEOS.debug.nl
    
    @XEOS.debug.print                   $XEOS.debug.pipe.start
    @XEOS.debug.print.register.flag     rf,  16
    @XEOS.debug.print.register.flag     vm,  17
    @XEOS.debug.print.register.flag     ac,  18
    @XEOS.debug.print.register.flag     vif, 19
    @XEOS.debug.print.register.flag     vip, 20
    @XEOS.debug.print.register.flag     id,  21
    
    @XEOS.debug.print.color             $XEOS.debug.str.pad.flags,  @BIOS.video.colors.gray, @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @BIOS.video.print                   $XEOS.debug.nl
    @XEOS.debug.print                   $XEOS.debug.hr.flags.bottom
    @XEOS.debug.print                   $XEOS.debug.nl
    @XEOS.debug.print                   $XEOS.debug.pipe.start
    @XEOS.debug.print.color             $XEOS.debug.str.registers.dump.footer,  @BIOS.video.colors.gray.light,  @BIOS.video.colors.black
    @XEOS.debug.print                   $XEOS.debug.pipe
    @XEOS.debug.print                   $XEOS.debug.nl
    @XEOS.debug.print                   $XEOS.debug.hr.bottom
    @XEOS.debug.print                   $XEOS.debug.nl
    
    xor     ax,         ax
    @BIOS.int.keyboard
    
    popa
    
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
XEOS.debug.print.color:
    
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
    
%endif
