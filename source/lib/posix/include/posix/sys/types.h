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

#ifndef __XEOS_LIB_POSIX_SYS_TYPES_H__
#define __XEOS_LIB_POSIX_SYS_TYPES_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <system/types/blkcnt_t.h>
#include <system/types/blksize_t.h>
#include <system/types/clock_t.h>
#include <system/types/clockid_t.h>
#include <system/types/dev_t.h>
#include <system/types/fsblkcnt_t.h>
#include <system/types/fsfilcnt_t.h>
#include <system/types/gid_t.h>
#include <system/types/id_t.h>
#include <system/types/ino_t.h>
#include <system/types/key_t.h>
#include <system/types/mode_t.h>
#include <system/types/nlink_t.h>
#include <system/types/off_t.h>
#include <system/types/pid_t.h>
#include <system/types/pthread_attr_t.h>
#include <system/types/pthread_barrier_t.h>
#include <system/types/pthread_barrierattr_t.h>
#include <system/types/pthread_cond_t.h>
#include <system/types/pthread_condattr_t.h>
#include <system/types/pthread_key_t.h>
#include <system/types/pthread_mutex_t.h>
#include <system/types/pthread_mutexattr_t.h>
#include <system/types/pthread_once_t.h>
#include <system/types/pthread_rwlock_t.h>
#include <system/types/pthread_rwlockattr_t.h>
#include <system/types/pthread_spinlock_t.h>
#include <system/types/pthread_t.h>
#include <system/types/size_t.h>
#include <system/types/ssize_t.h>
#include <system/types/suseconds_t.h>
#include <system/types/time_t.h>
#include <system/types/timer_t.h>
#include <system/types/trace_attr_t.h>
#include <system/types/trace_event_id_t.h>
#include <system/types/trace_event_set_t.h>
#include <system/types/trace_id_t.h>
#include <system/types/uid_t.h>
#include <system/types/useconds_t.h>

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_POSIX_SYS_TYPES_H__ */
