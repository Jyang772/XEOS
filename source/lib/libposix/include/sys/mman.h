/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
 * All rights reserved.
 * 
 * XEOS Software License - Version 1.0 - December 21, 2012
 * 
 * Permission is hereby granted, free of charge, to any person or organisation
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to deal in the Software, with or without
 * modification, without restriction, including without limitation the rights
 * to use, execute, display, copy, reproduce, transmit, publish, distribute,
 * modify, merge, prepare derivative works of the Software, and to permit
 * third-parties to whom the Software is furnished to do so, all subject to the
 * following conditions:
 * 
 *      1.  Redistributions of source code, in whole or in part, must retain the
 *          above copyright notice and this entire statement, including the
 *          above license grant, this restriction and the following disclaimer.
 * 
 *      2.  Redistributions in binary form must reproduce the above copyright
 *          notice and this entire statement, including the above license grant,
 *          this restriction and the following disclaimer in the documentation
 *          and/or other materials provided with the distribution, unless the
 *          Software is distributed by the copyright owner as a library.
 *          A "library" means a collection of software functions and/or data
 *          prepared so as to be conveniently linked with application programs
 *          (which use some of those functions and data) to form executables.
 * 
 *      3.  The Software, or any substancial portion of the Software shall not
 *          be combined, included, derived, or linked (statically or
 *          dynamically) with software or libraries licensed under the terms
 *          of any GNU software license, including, but not limited to, the GNU
 *          General Public License (GNU/GPL) or the GNU Lesser General Public
 *          License (GNU/LGPL).
 * 
 *      4.  All advertising materials mentioning features or use of this
 *          software must display an acknowledgement stating that the product
 *          includes software developed by the copyright owner.
 * 
 *      5.  Neither the name of the copyright owner nor the names of its
 *          contributors may be used to endorse or promote products derived from
 *          this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
 * 
 * IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
 * THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

/* $Id$ */

#ifndef __LIBPOSIX_SYS_MMAN_H__
#define __LIBPOSIX_SYS_MMAN_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <libsystem/types/null.h>
#include <libsystem/types/size_t.h>
#include <libsystem/types/off_t.h>
#include <libsystem/types/mode_t.h>
#include <libsystem/types/struct_posix_typed_mem_info.h>

#define PROT_NONE                               0x0000
#define PROT_READ                               0x0001
#define PROT_WRITE                              0x0002
#define PROT_EXEC                               0x0004

#define MAP_SHARED                              0x0001
#define MAP_PRIVATE                             0x0002
#define MAP_FIXED                               0x0010

#define MS_ASYNC                                0x0001
#define MS_INVALIDATE                           0x0002
#define MS_SYNC                                 0x0010

#define MCL_CURRENT                             0x0001
#define MCL_FUTURE                              0x0002

#define POSIX_MADV_NORMAL                       0x0000
#define POSIX_MADV_RANDOM                       0x0001
#define POSIX_MADV_SEQUENTIAL                   0x0002
#define POSIX_MADV_WILLNEED                     0x0003
#define POSIX_MADV_DONTNEED                     0x0004
#define POSIX_TYPED_MEM_ALLOCATE                0x0005
#define POSIX_TYPED_MEM_ALLOCATE_CONTIG         0x0006
#define POSIX_TYPED_MEM_MAP_ALLOCATABLE         0x0007

int     mlock( const void * addr, size_t len );
int     mlockall( int flags );
void *  mmap( void * addr, size_t len, int prot, int flags, int fildes, off_t off );
int     mprotect( void * addr, size_t len, int prot );
int     msync( void * addr, size_t len, int flags );
int     munlock( const void * addr, size_t len );
int     munlockall( void );
int     munmap( void * addr, size_t len );
int     posix_madvise( void * addr, size_t len, int advice );
int     posix_mem_offset( const void * restrict addr, size_t len, off_t * restrict off, size_t * restrict contig_len, int * restrict fildes );
int     posix_typed_mem_get_info( int fildes, struct posix_typed_mem_info * info );
int     posix_typed_mem_open( const char * name, int oflag, int tflag );
int     shm_open( const char * name, int oflag, mode_t mode );
int     shm_unlink( const char * name );

#ifdef __cplusplus
}
#endif

#endif /* __LIBPOSIX_SYS_MMAN_H__ */
