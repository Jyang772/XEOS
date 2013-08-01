;-------------------------------------------------------------------------------
; XEOS - X86 Experimental Operating System
; 
; Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
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
; @file            System_Atomic.32.s
; @author          Jean-David Gadina
; @copyright       (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
;-------------------------------------------------------------------------------

global System_Atomic_MemoryBarrier
global System_Atomic_CompareAndSwap8
global System_Atomic_CompareAndSwap16
global System_Atomic_CompareAndSwap32
global System_Atomic_CompareAndSwap64
global System_Atomic_CompareAndSwapChar
global System_Atomic_CompareAndSwapShort
global System_Atomic_CompareAndSwapInt
global System_Atomic_CompareAndSwapLong
global System_Atomic_CompareAndSwapPtr
global System_Atomic_TestAndClear
global System_Atomic_TestAndSet
global System_Atomic_And32
global System_Atomic_Or32
global System_Atomic_Xor32
global System_Atomic_Add32
global System_Atomic_Add64
global System_Atomic_Decrement32
global System_Atomic_Decrement64
global System_Atomic_Increment32
global System_Atomic_Increment64
global System_Atomic_SpinLockLock
global System_Atomic_SpinLockTry
global System_Atomic_SpinLockUnlock

%macro __System_Atomic_BitOperation     1

    mov     edx,        [ esp + 8 ]
    cmp     edx,        0
    je      .end
    
    mov     eax,        [ esp + 4 ]
    shld    ecx,        edx,            3
    shl     edx,        3
    xor     eax,        7
    add     edx,        eax
    adc     ecx,        0
    mov     eax,        edx
    and     eax,        31
    xor     edx,        eax
    shrd    edx,        ecx,            3
    lock
    %1      [ edx ],    eax
    setc    al
    movzx   eax,        al
    
    .end:

%endmacro

%macro __System_Atomic_Arithmetic       1
    
    mov     ecx,        [ esp + 8 ]
    cmp     ecx,        0
    je      .end
    
    mov     eax,        [ ecx ]
    
    .1:
    
        mov 	edx,        [ esp + 4 ]
        %1      edx,        eax
        lock
        cmpxchg ecx,        edx
        jnz     .1
        
    mov 	eax,        edx
    
    .end:
    
%endmacro

;-------------------------------------------------------------------------------
; void System_Atomic_MemoryBarrier( void );
;-------------------------------------------------------------------------------
System_Atomic_MemoryBarrier:
    
    mfence
    
    ret

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwap8( int8_t oldValue,
;                                     int8_t newValue,
;                                     volatile int8_t * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwap8:
    
    xor         eax,        eax
    mov         ecx,        [ esp + 12 ]
    cmp         ecx,        0
    je          .end
    
    mov         eax,        [ esp + 4 ]
    mov         edx,        [ esp + 8 ]
    lock
    cmpxchg    [ ecx ],     dl
    sete       al
    movzx      eax,         al
    
    .end:
        
        ret
    
;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwap16( int16_t oldValue,
;                                      int16_t newValue,
;                                      volatile int16_t * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwap16:
    
    xor         eax,        eax
    mov         ecx,        [ esp + 12 ]
    cmp         ecx,        0
    je          .end
    
    mov         eax,        [ esp + 4 ]
    mov         edx,        [ esp + 8 ]
    lock
    cmpxchg    [ ecx ],     dx
    sete       al
    movzx      eax,         al
    
    .end:
        
        ret

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwap32( int32_t oldValue,
;                                      int32_t newValue,
;                                      volatile int32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwap32:
    
    xor         eax,        eax
    mov         ecx,        [ esp + 12 ]
    cmp         ecx,        0
    je          .end
    
    mov         eax,        [ esp + 4 ]
    mov         edx,        [ esp + 8 ]
    lock
    cmpxchg    [ ecx ],     edx
    sete       al
    movzx      eax,         al
    
    .end:
        
        ret

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwap64( int64_t oldValue,
;                                      int64_t newValue,
;                                      volatile int64_t * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwap64:
    
    push        ebx
    push        esi
    
    xor         eax,            eax
    mov         esi,            [ esp + 28 ]
    cmp         esi,            0
    je          .end
    
    mov         eax,            [ esp + 12 ]
    mov         edx,            [ esp + 16 ]
    mov         ebx,            [ esp + 20 ]
    mov         ecx,            [ esp + 24 ]
    lock
    cmpxchg8b   [ esi ]
    sete        al
    movzx       eax,            al
    pop         esi
    pop         ebx
    
    .end:
        
        ret

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwapChar( char oldValue,
;                                        char newValue,
;                                        volatile char * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwapChar:
    
    jmp     System_Atomic_CompareAndSwap8

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwapShort( short oldValue,
;                                         short newValue,
;                                         volatile short * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwapShort:
    
    jmp     System_Atomic_CompareAndSwap16

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwapInt( int oldValue,
;                                       int newValue,
;                                       volatile int * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwapInt:
    
    jmp     System_Atomic_CompareAndSwap32
 
;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwapLong( long oldValue,
;                                        long newValue,
;                                        volatile long * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwapLong:
    
    jmp     System_Atomic_CompareAndSwap32

;-------------------------------------------------------------------------------
; bool System_Atomic_CompareAndSwapPtr( void * oldValue,
;                                       void * newValue,
;                                       void * volatile * value );
;-------------------------------------------------------------------------------
System_Atomic_CompareAndSwapPtr:
    
    jmp     System_Atomic_CompareAndSwap32

;-------------------------------------------------------------------------------
; bool System_Atomic_TestAndClear( uint32_t n, volatile void * address );
;-------------------------------------------------------------------------------
System_Atomic_TestAndClear:
    
    __System_Atomic_BitOperation btr
    
    ret 

;-------------------------------------------------------------------------------
; bool System_Atomic_TestAndSet( uint32_t n, volatile void * address );
;-------------------------------------------------------------------------------
System_Atomic_TestAndSet:
    
    __System_Atomic_BitOperation bts
    
    ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_And32( uint32_t mask, volatile uint32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_And32:
    
    __System_Atomic_Arithmetic  and
    
    ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_Or32( uint32_t mask, volatile uint32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Or32:
    
    __System_Atomic_Arithmetic  or
    
    ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_Xor32( uint32_t mask, volatile uint32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Xor32:
    
    __System_Atomic_Arithmetic  xor
    
    ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_Add32( int32_t amount, volatile int32_t * value );
;-------------------------------------------------------------------------------    
System_Atomic_Add32:
    
    xor     eax,                eax
    mov     edx,                [ esp + 8 ]
    cmp     edx,                0
    je      .end
    
    mov     eax,                [ esp + 4 ]
    mov     ecx,                eax
    lock
    xadd    [ edx ],            eax
    add     eax,                ecx
    
    .end:
        
        ret

;-------------------------------------------------------------------------------
; int64_t System_Atomic_Add64( int64_t amount, volatile int64_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Add64:
    
    push 	ebx
    push    esi
    
    mov 	esi,                [ esp + 20 ]
    cmp     esi,                0
    je      .end
    
    mov 	eax,                [ esi ]
    mov 	edx,                [ esi + 4 ]
    
    .1:
    
    mov 	ebx,                [ esp + 12 ]
    mov 	ecx,                [ esp + 16 ]
    add 	ebx,                eax
    adc 	ecx,                edx
    
    lock
    cmpxchg8b                   [ esi ]
    
    jnz     .1
    
    mov 	eax,                ebx
    mov 	edx,                ecx
    
    .end:
        
        pop 	esi
        pop 	ebx
            
        ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_Decrement32( volatile int32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Decrement32:
    
    push    ebp
    mov     ebp,                esp
    sub     esp,                16
    
    mov     eax,                DWORD [ ebp + 8 ]
    mov     DWORD [ esp ],      0xFFFFFFFF
    mov     DWORD [ esp + 4 ],  eax
    
    call    System_Atomic_Add32
    
    add     esp,                16
    pop     ebp
    
    ret

;-------------------------------------------------------------------------------
; int64_t System_Atomic_Decrement64( volatile int64_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Decrement64:
    
    push    ebp
    mov     ebp,                esp
    sub     esp,                24
    
    mov     eax,                DWORD [ ebp + 8 ]
    mov     DWORD [ esp ],      0xFFFFFFFF
    mov     DWORD [ esp + 4 ],  0xFFFFFFFF
    mov     DWORD [ esp + 8 ],  eax
    
    call    System_Atomic_Add64
    
    add     esp,                24
    pop     ebp
    
    ret

;-------------------------------------------------------------------------------
; int32_t System_Atomic_Increment32( volatile int32_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Increment32:
    
    push    ebp
    mov     ebp,                esp
    sub     esp,                16
    
    mov     eax,                DWORD [ ebp + 8 ]
    mov     DWORD [ esp ],      1
    mov     DWORD [ esp + 4 ],  eax
    
    call    System_Atomic_Add32
    
    add     esp,                16
    pop     ebp
    
    ret

;-------------------------------------------------------------------------------
; int64_t System_Atomic_Increment64( volatile int64_t * value );
;-------------------------------------------------------------------------------
System_Atomic_Increment64:
    
    push    ebp
    mov     ebp,                esp
    sub     esp,                24
    
    mov     eax,                DWORD [ ebp + 8 ]
    mov     DWORD [ esp ],      1
    mov     DWORD [ esp + 4 ],  0
    mov     DWORD [ esp + 8 ],  eax
    
    call    System_Atomic_Add64
    
    add     esp,                24
    pop     ebp
    
    ret

;-------------------------------------------------------------------------------
; void System_Atomic_SpinLockLock( System_Atomic_SpinLock * lock );
;-------------------------------------------------------------------------------
System_Atomic_SpinLockLock:
    
    push    ebp
    mov 	ebp,                esp
    sub 	esp,                24
    
    mov 	eax,                DWORD [ ebp + 8 ]
    cmp     eax,                0
    je      .end
    
    mov 	DWORD [ esp ],      0
    mov 	DWORD [ esp + 4 ],  1
    mov 	DWORD [ esp + 8 ],  eax
    
    .compare:
        
        call	System_Atomic_CompareAndSwap32
        
        test    al,             al
        jnz     .end
        
        pause
        jmp     .compare
        
    .end:
        
        add 	esp,                24
        pop 	ebp
        
        ret

;-------------------------------------------------------------------------------
; bool System_Atomic_SpinLockTry( System_Atomic_SpinLock * lock );
;-------------------------------------------------------------------------------
System_Atomic_SpinLockTry:
    
    push    ebp
    mov 	ebp,                esp
    sub 	esp,                24
    
    mov 	eax,                DWORD [ ebp + 8 ]
    cmp     eax,                0
    je      .end
    
    mov 	DWORD [ esp ],      0
    mov 	DWORD [ esp + 4 ],  1
    mov 	DWORD [ esp + 8 ],  eax
    
    call	System_Atomic_CompareAndSwap32
    movzx	eax,                al
    
    add 	esp,                24
    pop 	ebp
    
    .end:
        
        ret

;-------------------------------------------------------------------------------
; void System_Atomic_SpinLockUnlock( System_Atomic_SpinLock * lock );
;-------------------------------------------------------------------------------
System_Atomic_SpinLockUnlock:
    
    mov     eax,                [ esp + 4 ]
    cmp     eax,                0
    je      .end
    
    mfence
    
	mov     DWORD [ eax ],      0
    
    .end:
        
        ret
    