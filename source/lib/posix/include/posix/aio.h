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

#ifndef __XEOS_LIB_POSIX_AIO_H__
#define __XEOS_LIB_POSIX_AIO_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <fcntl.h>
#include <signal.h>
#include <time.h>

#include <system/types/struct_aiocb.h>
#include <system/types/off_t.h>
#include <system/types/pthread_attr_t.h>
#include <system/types/size_t.h>
#include <system/types/ssize_t.h>
#include <system/types/struct_timespec.h>

struct sigevent;

#define AIO_ALLDONE         0x01
#define AIO_CANCELED        0x02
#define AIO_NOTCANCELED     0x04

#define LIO_NOP             0x00
#define LIO_READ            0x01
#define LIO_WRITE           0x02
#define LIO_WAIT            0x01
#define LIO_NOWAIT          0x02

int     aio_cancel( int fildes, struct aiocb * aiocbp );
int     aio_error( const struct aiocb * aiocbp );
int     aio_fsync( int op, struct aiocb * aiocbp );
int     aio_read( struct aiocb * aiocbp );
ssize_t aio_return( struct aiocb * aiocbp );
int     aio_suspend( const struct aiocb * const list[], int nent, const struct timespec * timeout );
int     aio_write( struct aiocb * aiocbp );
int     lio_listio( int mode, struct aiocb * restrict const list[ restrict ], int nent, struct sigevent * restrict sig );

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_POSIX_AIO_H__ */
