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

#ifndef __XEOS_LIB_DISPATCH_SOURCE_H__
#define __XEOS_LIB_DISPATCH_SOURCE_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <system/types/uint64_t.h>
#include <dispatch/types/dispatch_source_type_t.h>
#include <dispatch/types/dispatch_source_t.h>
#include <dispatch/types/dispatch_block_t.h>
#include <dispatch/types/dispatch_function_t.h>
#include <dispatch/types/dispatch_queue_t.h>

#define DISPATCH_SOURCE_TYPE_DATA_ADD
#define DISPATCH_SOURCE_TYPE_DATA_OR
#define DISPATCH_SOURCE_TYPE_MACH_RECV
#define DISPATCH_SOURCE_TYPE_MACH_SEND
#define DISPATCH_SOURCE_TYPE_PROC
#define DISPATCH_SOURCE_TYPE_READ
#define DISPATCH_SOURCE_TYPE_SIGNAL
#define DISPATCH_SOURCE_TYPE_TIMER
#define DISPATCH_SOURCE_TYPE_VNODE
#define DISPATCH_SOURCE_TYPE_WRITE

enum
{
    DISPATCH_MACH_SEND_DEAD = 0x01,
};

enum
{
    DISPATCH_PROC_EXIT      = 0x80000000,
    DISPATCH_PROC_FORK      = 0x40000000,
    DISPATCH_PROC_EXEC      = 0x20000000,
    DISPATCH_PROC_SIGNAL    = 0x08000000
};

enum
{
    DISPATCH_VNODE_DELETE   = 0x01,
    DISPATCH_VNODE_WRITE    = 0x02,
    DISPATCH_VNODE_EXTEND   = 0x04,
    DISPATCH_VNODE_ATTRIB   = 0x08,
    DISPATCH_VNODE_LINK     = 0x10,
    DISPATCH_VNODE_RENAME   = 0x20,
    DISPATCH_VNODE_REVOKE   = 0x40
};

void                dispatch_source_cancel( dispatch_source_t source );
dispatch_source_t   dispatch_source_create( dispatch_source_type_t type, uintptr_t handle, unsigned long mask, dispatch_queue_t queue );
unsigned long       dispatch_source_get_data( dispatch_source_t source );
uintptr_t           dispatch_source_get_handle( dispatch_source_t source );
unsigned long       dispatch_source_get_mask( dispatch_source_t source );
void                dispatch_source_merge_data( dispatch_source_t source, unsigned long value );
void                dispatch_source_set_cancel_handler( dispatch_source_t source, dispatch_block_t cancel_handler );
void                dispatch_source_set_cancel_handler_f( dispatch_source_t source, dispatch_function_t cancel_handler );
void                dispatch_source_set_event_handler( dispatch_source_t source, dispatch_block_t handler );
void                dispatch_source_set_event_handler_f( dispatch_source_t source, dispatch_function_t handler );
void                dispatch_source_set_registration_handler( dispatch_source_t source, dispatch_block_t registration_handler );
void                dispatch_source_set_registration_handler_f( dispatch_source_t source, dispatch_function_t registration_handler );
void                dispatch_source_set_timer( dispatch_source_t source, dispatch_time_t start, uint64_t interval, uint64_t leeway );
long                dispatch_source_testcancel( dispatch_source_t source );

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_DISPATCH_SOURCE_H__ */
