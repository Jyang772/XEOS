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
; Procedures for the ELF format
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------
%ifndef __XEOS_ELF_INC_16_ASM__
%define __XEOS_ELF_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.macros.inc.asm"          ; General macros
%include "XEOS.error.inc.16.asm"        ; Error management
%include "XEOS.ascii.inc.asm"           ; ASCII table

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Checks the ELF header to ensure it's a valid ELF binary file
; 
; The ELF header has the following structure:
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
; 
; Necessary register values:
;       
;       - ax:       The memory address at which the file is loaded
;-------------------------------------------------------------------------------
XEOS.elf.checkHeader:
    
    @XEOS.reg.save
    
    mov     es,         ax
    xor     ax,         ax
    mov     di,         ax
    
    mov     si,         XEOS.elf.signature
    mov     cx,         4
    
    rep     cmpsb
    
    je      .validSignature
    
    call    XEOS.error.fatal
    
    .validSignature:
        
        push    ds
        push    si
        
        mov     ax,         es
        mov     ds,         ax
        mov     ax,         di
        mov     si,         ax
        
        lodsb
        
        cmp     al,         0x01
        
        je      .validClass
        
        pop     si
        pop     ds
        
        call    XEOS.error.fatal
        
    .validClass:
        
        lodsb
        
        cmp     al,         0x00
        
        jg      .validEncoding
        
        pop     si
        pop     ds
        
        call    XEOS.error.fatal
        
    .validEncoding:
        
        pop     si
        pop     ds
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Gets the entry point address of an ELF file, loaded in memory
; 
; 
; Necessary register values:
;       
;       - ax:       The memory address at which the file is loaded
;-------------------------------------------------------------------------------
XEOS.elf.getEntryPointAddress:
    
    @XEOS.reg.save
    
    
    
    @XEOS.reg.restore
    
    ret
    
;-------------------------------------------------------------------------------
; Loads an ELF file into memory
; 
; Necessary register values:
;       
;       - si:       The name of the file to load
;       - ax:       The memory address at which the file will be loaded
;       - bx:       The memory address at which the buffer will be created
;                   (the buffer is used to load the FAT root directory and
;                   the file allocation table, so be sure to have enough
;                   memory available)
;-------------------------------------------------------------------------------
XEOS.elf.load:
    
    @XEOS.reg.save
    
    ; Saves some registers
    push    ax
    push    bx
    
    ; Loads the root directory into memory
    call    XEOS.io.fat12.loadRootDirectory
    
    ; Location of the data we read into memory
    pop     bx
    push    bx
    
    ; Tries to find the kernel file in the root directory
    call    XEOS.io.fat12.findFile
    
    ; Restores the needed memory registers
    pop     bx
    pop     ax
    
    ; Saves AX again
    push    ax
    
    ; Loads the kernel into memory
    call    XEOS.io.fat12.loadFile
    
    ; Checks the ELF header
    pop     ax
    push    ax
    call    XEOS.elf.checkHeader
    
    ; Restores AX
    pop    ax
    
    ; Gets the address of the entry point
    call    XEOS.elf.getEntryPointAddress
    
    @XEOS.reg.restore
    
    ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

XEOS.elf.signature      db  0x7F, 0x45, 0x4C, 0x46
XEOS.elf.entryPoint     dd  0

%endif
