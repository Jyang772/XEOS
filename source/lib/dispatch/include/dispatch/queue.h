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

#ifndef __XEOS_LIB_DISPATCH_QUEUE_H__
#define __XEOS_LIB_DISPATCH_QUEUE_H__

#ifdef __cplusplus
extern "C" {
#endif

#define DISPATCH_QUEUE_PRIORITY_HIGH        2
#define DISPATCH_QUEUE_PRIORITY_DEFAULT     0
#define DISPATCH_QUEUE_PRIORITY_LOW         ( -2 )
#define DISPATCH_QUEUE_PRIORITY_BACKGROUND  INT16_MIN

#define DISPATCH_QUEUE_SERIAL
#define DISPATCH_QUEUE_CONCURRENT

#include <dispatch/types/dispatch_block_t.h>
#include <dispatch/types/dispatch_queue_t.h>
#include <dispatch/types/dispatch_queue_attr_t.h>

void                dispatch_after( dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block );
void                dispatch_after_f( dispatch_time_t when, dispatch_queue_t queue, void * context, dispatch_function_t work );
void                dispatch_apply( size_t iterations, dispatch_queue_t queue, void ( ^ block )( size_t ) );
void                dispatch_apply_f( size_t iterations, dispatch_queue_t queue, void * context, void ( * work )( void *, size_t ) );
void                dispatch_async( dispatch_queue_t queue, dispatch_block_t block );
void                dispatch_async_f( dispatch_queue_t queue, void * context, dispatch_function_t work );
void                dispatch_barrier_async( dispatch_queue_t queue, dispatch_block_t block );
void                dispatch_barrier_async_f( dispatch_queue_t queue, void * context, dispatch_function_t work );
void                dispatch_barrier_sync( dispatch_queue_t queue, dispatch_block_t block );
void                dispatch_barrier_sync_f( dispatch_queue_t queue, void * context, dispatch_function_t work );
dispatch_queue_t    dispatch_get_current_queue( void );
dispatch_queue_t    dispatch_get_global_queue( long priority, unsigned long flags );
dispatch_queue_t    dispatch_get_main_queue( void );
void              * dispatch_get_specific( const void * key );
void                dispatch_main( void );
dispatch_queue_t    dispatch_queue_create( const char * label, dispatch_queue_attr_t attr );
const char        * dispatch_queue_get_label( dispatch_queue_t queue );
void              * dispatch_queue_get_specific( dispatch_queue_t queue, const void * key );
void                dispatch_queue_set_specific( dispatch_queue_t queue, const void * key, void * context, dispatch_function_t destructor );
void                dispatch_set_target_queue( dispatch_object_t object, dispatch_queue_t queue );
void                dispatch_sync( dispatch_queue_t queue, dispatch_block_t block );
void                dispatch_sync_f( dispatch_queue_t queue, void * context, dispatch_function_t work );

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_DISPATCH_QUEUE_H__ */
