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
; Defines, macros and procedures for the System Management BIOS (SMBIOS)
; 
; The System Management BIOS Reference Specification addresses how motherboard
; and system vendors present management information about their products in a
; standard format by extending the BIOS interface on Intel architecture systems.
; The information is intended to allow generic instrumentation to deliver this
; data to management applications that use CIM (the WBEM data model) or direct
; access and eliminates the need for error prone operations like probing system
; hardware for presence detection.
; 
; Those procedures and macros are intended to be used only in 32 bits protected
; mode.
;-------------------------------------------------------------------------------

%ifndef __XEOS_SMBIOS_INC_32_ASM__
%define __XEOS_SMBIOS_INC_32_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.macros.inc.asm"          ; General macros
%include "XEOS.video.inc.32.asm"        ; XEOS video services

; We are in 32 bits mode
BITS    32

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.smbios.verifyChecksum:
    
    @XEOS.reg.save
    
    ; Address of the SMBIOS entry point structure
    mov     esi,        [ XEOS.smbios.table ]
    
    ; Resets the registers we are going to use
    xor     eax,        eax
    xor     edx,        edx
    
    ; Length of the SMBIOS entry point structure
    movzx   ecx,        BYTE [ XEOS.smbios.entryPointLength ]
    
    ; Process each byte of the SMBIOS entry point structure
    .loop:
        
        ; Loads the current byte
        lodsb
        
        ; Adds it to the other bytes, stored in DL
        add     dl,         al
        
        ; Process the next byte till the end of the SMBIOS entry point structure
        loop    .loop
    
    ; DL should be 0 for a valid SMBIOS entry point structure
    cmp     dl,         0
    
    je     .success
        
    @XEOS.reg.restore
    
    ; Error - Invalid checksum
    mov     eax,        1
    
    ret
    
    .success:
        
        @XEOS.reg.restore
        
        ; Success - Valid checksum
        xor     eax,        eax
        
        ret

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
XEOS.smbios.find:
    
    @XEOS.reg.save
    
    ; String to look for (SMBIOS signature)
    mov     edi,        XEOS.smbios.signature
    
    ; Start of the memory location we need to scan
    mov     esi,        [ XEOS.smbios.memory.start ]
    
    ; Computes the ammount of memory we need to scan
    xor     ecx,        ecx
    mov     eax,        [ XEOS.smbios.memory.end ]
    sub     eax,        [ XEOS.smbios.memory.start ]
    
    ; Divides by 4, as we will read by 4 bytes
    mov     ebx,        4
    div     ebx
    
    ; Stores the amount of memory to scan in ECX, so we can loopx
    xchg    ecx,        eax
    
    ; Now, let's scan the memory for the SMBIOS signature
    .checkSignature
        
        ; Saves the loop counter
        push    ecx
        
        ; SMBIOS signature is 4 bytes (_SM_)
        mov     ecx,        4
        
        ; Saves ESI and EDI
        push    esi
        push    edi
        
        ; Compares the memory bytes with the SMBIOS signature
        rep     cmpsb
        
        ; Restores the saved registers
        pop     edi
        pop     esi
        pop     ecx
        
        ; SMBIOS signature found
        je      .signatureFound
        
        ; We are going to read the next 4 bytes
        add     esi,        4
        
        ; Continues scanning the memory
        loop    .checkSignature
        
        @XEOS.reg.restore
        
        ; Result code - SMBIOS table was not found
        mov     eax,        1
        
        ret
    
    ; The SMBIOS signature was found
    .signatureFound
        
        ; Now we need to check the DMI signature, located at offset 0x10
        add     esi,        10h
        mov     edi,        XEOS.smbios.dmiSignature
        
        ; Saves the initial loop counter, so we'll be able to continue the
        ; memory scan if the DMI signature is not present at the expected
        ; location (meaning we haven't located the SMBIOS)
        push    ecx
        
        ; DMI signature is 5 bytes (_DMI_)
        mov     ecx,        5
        
        ; Saves ESI and EDI
        push    esi
        push    edi
        
        ; Compares the memory bytes with the DMI signature
        rep     cmpsb
        
        ; Restores the saved registers
        pop     edi
        pop     esi
        pop     ecx
        
        ; DMI signature found
        je      .dmiSignatureFound
        
        ; Not found - Go back to the memory scanning
        sub     esi,        0x0C
        loop    .checkSignature
    
    ; The DMI signature was found
    .dmiSignatureFound:
        
        ; No we need to check the length of the entry point structure
        sub     esi,        0x0B
        mov     edi,        XEOS.smbios.entryPointLength
        
        ; Saves the initial loop counter, so we'll be able to continue the
        ; memory scan if the length is not correct (meaning we haven't located
        ; the SMBIOS)
        push    ecx
        
        ; Entry point length is 1 bytes (0x1F)
        mov     ecx,        1
        
        ; Saves ESI and EDI
        push    esi
        push    edi
        
        ; Compares the memory bytes with the entry point length
        rep     cmpsb
        
        ; Restores the saved registers
        pop     edi
        pop     esi
        pop     ecx
        
        ; Entry point length is correct
        je      .entryPointLengthCorrect
        
        ; Incorrect - Go back to the memory scanning
        inc     esi
        loop    .checkSignature
    
    ; The entry point length is correct
    ; 
    ; This means we surely located the SMBIOS.
    .entryPointLengthCorrect:
        
        ; Back to the start of the entry point structure
        sub     esi,        0x05
        
        ; Stores the memory location of the SMBIOS table
        mov     [ XEOS.smbios.table ],  esi
        
        @XEOS.reg.restore
        
        ; Result code - SMBIOS table was found
        xor     eax,        eax
        
        ret

;-------------------------------------------------------------------------------
; Variables
;-------------------------------------------------------------------------------

XEOS.smbios.signature           db  0x5F, 0x53, 0x4D, 0x5F
XEOS.smbios.dmiSignature        db  0x5F, 0x44, 0x4D, 0x49, 0x5F
XEOS.smbios.entryPointLength    db  0x1F
XEOS.smbios.memory.start        dd  0x000F0000
XEOS.smbios.memory.end          dd  0x000FFFFF
XEOS.smbios.table               dd  0

%endif
