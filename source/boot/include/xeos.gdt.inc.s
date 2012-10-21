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
; Procedures and definitions for the GDT (Global Descriptor Table)
;-------------------------------------------------------------------------------

%ifndef __XEOS_GDT_INC_ASM__
%define __XEOS_GDT_INC_ASM__

;-------------------------------------------------------------------------------
; Installation of the GDT
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
XEOS.gdt.install:
    
    @XEOS.proc.start 0
    
    ; Clears the interrupts
    cli
    
    lgdt    [ $XEOS.gdt._pointer ]
    
    ; Restores the interrupts
    sti
    
    @XEOS.proc.end
    
    ret

;-------------------------------------------------------------------------------
; Addresses of the descriptors
;-------------------------------------------------------------------------------

%define @XEOS.gdt.descriptors.null      0x00
%define @XEOS.gdt.descriptors.code      0x08
%define @XEOS.gdt.descriptors.data      0x10

;-------------------------------------------------------------------------------
; GDT Descriptor
; 
; A descriptor is 8 bytes long, and has the following structure:
;       
;       - Bits  0 - 15: Segment limit (0-15)
;       - Bits 16 - 31: Base address (0-15)
;       - Bits 31 - 39: Base address (16-23)
;       - Bit  40:      Access bit (only for virtual memory)
;       - Bits 41 - 43: Descriptor type
;                           Bit 41: Readable and writeable
;                                       0:  Read only (data segment)
;                                           Execute only (code segment)
;                                       1:  Read and write (data segment)
;                                       1:  Read and execute (code segment)
;                           Bit 42: Expansion direction (for data segment)
;                                   or conforming (code segment)
;                           Bit 43: Executable segment
;                                       0:  Data segment
;                                       1:  Code segment
;       - Bit  44:      Descriptor bit
;                           0:      System descriptor
;                           1:      Code or data descriptor
;       - Bits 45 - 46: Descriptor privilege level (rings 0 to 3)
;       - Bit  47:      Segment is in memory (only for virtual memory)
;       - Bits 48 - 51: Segment limit (16-19)
;       - Bit  52:      Reserved (for OS)
;       - Bit  53:      Reserved
;       - Bit  54:      Segment type
;                           0:      16 bits
;                           1:      32 bits
;       - Bit  55:      Granularity
;                           0:      None
;                           1:      Limit is multiplied by 4K
;       - Bits 56 - 63: Base address (24-31)
;-------------------------------------------------------------------------------
struc XEOS.gdt.descriptor_t

    .segment1       resw    1
    .base1          resw    1
    .base2          resb    1
    .info           resb    1
    .segment        resb    1
    .base3          resb    1

endstruc

;-------------------------------------------------------------------------------
; GDT - Global Descriptor Table
; 
; Definition of the global memory map for the 32bits protected mode.
; 
; The GDT is composed of three descriptors:
;       
;       - Null descriptor - All zeros
;       - Code descriptor - Memory area that can be executed
;       - Data descriptor - Memory area that contains data
;-------------------------------------------------------------------------------
struc XEOS.gdt_t

    .null           resb    XEOS.gdt.descriptor_t_size
    .code           resb    XEOS.gdt.descriptor_t_size
    .data           resb    XEOS.gdt.descriptor_t_size

endstruc

;-------------------------------------------------------------------------------
; XEOS GDT
;-------------------------------------------------------------------------------
$XEOS.gdt
    
    istruc XEOS.gdt_t
        
        ;-----------------------------------------------------------------------
        ; Null descriptor
        ;-----------------------------------------------------------------------
        
        ; 8 bytes of zeros
        dd  0
        dd  0
        
        ;-----------------------------------------------------------------------
        ; Kernel space code descriptor
        ;-----------------------------------------------------------------------
        
        ; Segment limit (0-15)
        dw  0xFFFF
        
        ; Base address (0-15)
        dw  0
        
        ; Base address (16-23)
        db  0
        
        ; Access:                   0       - Not using virtual memory
        ; Descriptor type:          1       - Read and execute
        ;                           0       - ???
        ;                           1       - Code descriptor
        ; Descriptor bit:           1       - Code/Data descriptor
        ; Privilege level:          00      - Ring 0 (kernel level)
        ; In memory:                1       - ???
        db  10011010b
        
        ; Segment limit (16-19):    1111    - High bits for the segment limit
        ; OS reserved:              0       - Nothing
        ; Reserved:                 0       - Nothing
        ; Segment type:             1       - 32 bits
        ; Granularity:              1       - Segments bounded by 4K
        db  11001111b
        
        ; Base address (24-31)
        db  0
        
        ;-----------------------------------------------------------------------
        ; Kernel space data descriptor
        ;-----------------------------------------------------------------------
        
        ; Segment limit (0-15)
        dw  0xFFFF
        
        ; Base address (0-15)
        dw  0
        
        ; Base address (16-23)
        db  0
        
        ; Access:                   0       - Not using virtual memory
        ; Descriptor type:          1       - Read and write
        ;                           0       - ???
        ;                           0       - Data descriptor
        ; Descriptor bit:           1       - Code/Data descriptor
        ; Privilege level:          00      - Ring 0 (kernel level)
        ; In memory:                1       - ???
        db  10010010b
        
        ; Segment limit (16-19):    1111    - High bits for the segment limit
        ; OS reserved:              0       - Nothing
        ; Reserved:                 0       - Nothing
        ; Segment type:             1       - 32 bits
        ; Granularity:              1       - Segments bounded by 4K
        db  11001111b
        
        ; Base address (24-31)
        db  0
        
    iend

;-------------------------------------------------------------------------------
; Pointer for the GDT
;-------------------------------------------------------------------------------
$XEOS.gdt._pointer:
    
    dw  XEOS.gdt_t_size - 1
    dd  $XEOS.gdt
    
%endif

