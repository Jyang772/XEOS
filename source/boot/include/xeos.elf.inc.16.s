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
; Procedures for the ELF format
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------

%ifndef __XEOS_ELF_INC_16_ASM__
%define __XEOS_ELF_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.macros.inc.s"          ; General macros
%include "XEOS.ascii.inc.s"           ; ASCII table

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; The ELF-32 header has the following structure:
;       
;       - BYTE  e_ident[ 16 ]   File identification
;       - WORD  e_type          Object file type
;       - WORD  e_machine       Required architecture
;       - DWORD e_version       Object file version
;       - DWORD e_entry         Entry point address
;       - DWORD e_phoff         Program header table's file offset
;       - DWORD e_shoff         Section header table's file offset
;       - DWORD e_flags         Processor-specific flags
;       - WORD  e_ehsize        ELF header's size
;       - WORD  e_phentsize     Size of an entry in the program header table
;                               (all entries are the same size)
;       - WORD  e_phnum         Number of entries in the program header table
;       - WORD  e_shentsize     Section header's size
;       - WORD  e_shnum         Number of entries in the section header table
;       - WORD  e_shstrndx      Section header table index of the entry
;                               associated with the section name string table
;-------------------------------------------------------------------------------
struc XEOS.elf.32.header_t

    .e_ident:       resb    16
    .e_type:        resw    1
    .e_machine:     resw    1
    .e_version:     resd    1
    .e_entry:       resd    1
    .e_phoff:       resd    1
    .e_shoff:       resd    1
    .e_flags:       resd    1
    .e_ehsize:      resw    1
    .e_phentsize:   resw    1
    .e_phnum:       resw    1
    .e_shentsize:   resw    1
    .e_shnum:       resw    1
    .e_shstrndx:    resw    1

endstruc

;-------------------------------------------------------------------------------
; Checks the ELF-32 header to ensure it's a valid ELF-32 binary file
; 
; Input registers:
;       
;       - SI:       The memory address at which the file is loaded
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
; 
; Killed registers:
;       
;       None   
;-------------------------------------------------------------------------------
XEOS.elf.32.checkHeader:
    
    ret
    
;-------------------------------------------------------------------------------
; Checks the ELF-64 header to ensure it's a valid ELF-64 binary file
; 
; Input registers:
;       
;       - SI:       The memory address at which the file is loaded
; 
; Return registers:
;       
;       - AX:       The result code (0 if no error)
; 
; Killed registers:
;       
;       None   
;-------------------------------------------------------------------------------
XEOS.elf.64.checkHeader:
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

$XEOS.elf.32.signature      db  0x7F, 0x45, 0x4C, 0x46

%endif
