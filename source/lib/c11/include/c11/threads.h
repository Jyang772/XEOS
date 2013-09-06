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

#ifndef __XEOS_LIB_C11_THREADS_H__
#define __XEOS_LIB_C11_THREADS_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <time.h>

#include <system/types/cnd_t.h>
#include <system/types/thrd_t.h>
#include <system/types/tss_t.h>
#include <system/types/mtx_t.h>
#include <system/types/tss_dtor_t.h>
#include <system/types/thrd_start_t.h>
#include <system/types/once_flag.h>

#define thread_local            _Thread_local
#define TSS_DTOR_ITERATIONS     1

enum
{
    mtx_plain       = 0x01,
    mtx_recursive   = 0x02,
    mtx_timed       = 0x04
};

enum
{
    thrd_success    = 0x00,
    thrd_error      = 0x01,
    thrd_timedout   = 0x02,
    thrd_busy       = 0x03,
    thrd_nomem      = 0x04
};

void call_once( once_flag * flag, void ( * func )( void ) );

int  cnd_broadcast( cnd_t * cond );
void cnd_destroy( cnd_t * cond );
int  cnd_init( cnd_t * cond );
int  cnd_signal( cnd_t * cond );
int  cnd_timedwait( cnd_t * restrict cond, mtx_t * restrict mtx, const struct timespec * restrict ts );
int  cnd_wait( cnd_t * cond, mtx_t * mtx );

void mtx_destroy( mtx_t * mtx );
int  mtx_init( mtx_t * mtx, int type );
int  mtx_lock( mtx_t * mtx );
int  mtx_timedlock( mtx_t * restrict mtx, const struct timespec * restrict ts );
int  mtx_trylock( mtx_t * mtx );
int  mtx_unlock( mtx_t * mtx );

          int    thrd_create( thrd_t * thr, thrd_start_t func, void * arg );
          thrd_t thrd_current( void );
          int    thrd_detach( thrd_t thr );
          int    thrd_equal( thrd_t thr0, thrd_t thr1 );
_Noreturn void   thrd_exit( int res );
          int    thrd_join( thrd_t thr, int * res );
          int    thrd_sleep( const struct timespec * duration, struct timespec * remaining );
          void   thrd_yield( void );

int    tss_create( tss_t * key, tss_dtor_t dtor );
void   tss_delete( tss_t key );
void * tss_get( tss_t key );
int    tss_set( tss_t key, void * val );

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_C11_THREADS_H__ */
