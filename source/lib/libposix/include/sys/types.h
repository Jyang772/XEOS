/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2012, Jean-David Gadina - www.xs-labs.com
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

#ifndef __LIBPOSIX_SYS_TYPES_H__
#define __LIBPOSIX_SYS_TYPES_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <sys/types/pid_t.h>
#include <xeos/types.h>

#ifndef __BLKCNT_T
#define __BLKCNT_T
    typedef XEOS_BlockCount                     blkcnt_t;
#endif

#ifndef __BLKSIZE_T
#define __BLKSIZE_T
    typedef XEOS_BlockSize                      blksize_t;
#endif

#ifndef __CLOCK_T
#define __CLOCK_T
    typedef XEOS_Clock                          clock_t;
#endif

#ifndef __CLOCKID_T
#define __CLOCKID_T
    typedef XEOS_ClockID                        clockid_t;
#endif

#ifndef __DEV_T
#define __DEV_T
    typedef XEOS_Device                         dev_t;
#endif

#ifndef __FSBLKCNT_T
#define __FSBLKCNT_T
    typedef XEOS_FSBlockCount                   fsblkcnt_t;
#endif

#ifndef __FSFILCNT_T
#define __FSFILCNT_T
    typedef XEOS_FSFileCount                    fsfilcnt_t;
#endif

#ifndef __GID_T
#define __GID_T
    typedef XEOS_GroupID                        gid_t;
#endif

#ifndef __ID_T
#define __ID_T
    typedef XEOS_ID                             id_t;
#endif

#ifndef __INO_T
#define __INO_T
    typedef XEOS_Inode                          ino_t;
#endif

#ifndef __KEY_T
#define __KEY_T
    typedef XEOS_Key                            key_t;
#endif

#ifndef __MODE_T
#define __MODE_T
    typedef XEOS_Mode                           mode_t;
#endif

#ifndef __NLINK_T
#define __NLINK_T
    typedef XEOS_NLink                          nlink_t;
#endif

#ifndef __OFF_T
#define __OFF_T
    typedef XEOS_Offset                         off_t;
#endif

#ifndef __PTHREAD_ATTR_T
#define __PTHREAD_ATTR_T
    typedef XEOS_PThreadAttribute               pthread_attr_t;
#endif

#ifndef __PTHREAD_BARRIER_T
#define __PTHREAD_BARRIER_T
    typedef XEOS_PThreadBarrier                 pthread_barrier_t;
#endif

#ifndef __PTHREAD_BARRIERATTR_T
#define __PTHREAD_BARRIERATTR_T
    typedef XEOS_PThreadBarrierAttribute        pthread_barrierattr_t;
#endif

#ifndef __PTHREAD_COND_T
#define __PTHREAD_COND_T
    typedef XEOS_PThreadCondition               pthread_cond_t;
#endif

#ifndef __PTHREAD_CONDATTR_T
#define __PTHREAD_CONDATTR_T
    typedef XEOS_PThreadConditionAttribute      pthread_condattr_t;
#endif

#ifndef __PTHREAD_KEY_T
#define __PTHREAD_KEY_T
    typedef XEOS_PThreadKey                     pthread_key_t;
#endif

#ifndef __PTHREAD_MUTEX_T
#define __PTHREAD_MUTEX_T
    typedef XEOS_PThreadMutex                   pthread_mutex_t;
#endif

#ifndef __PTHREAD_MUTEXATTR_T
#define __PTHREAD_MUTEXATTR_T
    typedef XEOS_PThreadMutexAttribute          pthread_mutexattr_t;
#endif

#ifndef __PTHREAD_ONCE_T
#define __PTHREAD_ONCE_T
    typedef XEOS_PThreadOnce                    pthread_once_t;
#endif

#ifndef __PTHREAD_RWLOCK_T
#define __PTHREAD_RWLOCK_T
    typedef XEOS_PThreadRWLock                  pthread_rwlock_t;
#endif

#ifndef __PTHREAD_RWLOCKATTR_T
#define __PTHREAD_RWLOCKATTR_T
    typedef XEOS_PThreadRWLockAttribute         pthread_rwlockattr_t;
#endif

#ifndef __PTHREAD_SPINLOCK_T
#define __PTHREAD_SPINLOCK_T__
    typedef XEOS_PThreadSpinlock                pthread_spinlock_t;
#endif

#ifndef __PTHREAD_T
#define __PTHREAD_T
    typedef XEOS_PThread                        pthread_t;
#endif

#ifndef __SIZE_T
#define __SIZE_T
    typedef XEOS_Size                           size_t;
#endif

#ifndef __SSIZE_T
#define __SSIZE_T
    typedef XEOS_SSize                          ssize_t;
#endif

#ifndef __SUSECONDS_T
#define __SUSECONDS_T
    typedef XEOS_SUSeconds                      suseconds_t;
#endif

#ifndef __TIME_T
#define __TIME_T
    typedef XEOS_Time                           time_t;
#endif

#ifndef __TIMER_T
#define __TIMER_T
    typedef XEOS_Timer                          timer_t;
#endif

#ifndef __TRACE_ATTR_T
#define __TRACE_ATTR_T
    typedef XEOS_TraceAttribute                 trace_attr_t;
#endif

#ifndef __TRACE_EVENT_ID_T
#define __TRACE_EVENT_ID_T
    typedef XEOS_TraceEventID                   trace_event_id_t;
#endif

#ifndef __TRACE_EVENT_SET_T
#define __TRACE_EVENT_SET_T
    typedef XEOS_TraceEventSet                  trace_event_set_t;
#endif

#ifndef __TRACE_ID_T
#define __TRACE_ID_T
    typedef XEOS_TraceID                        trace_id_t;
#endif

#ifndef __UID_T
#define __UID_T
    typedef XEOS_UserID                         uid_t;
#endif

#ifndef __USECONDS_T
#define __USECONDS_T
    typedef XEOS_USeconds                       useconds_t;
#endif

#ifdef __cplusplus
}
#endif

#endif /* __LIBPOSIX_SYS_TYPES_H__ */
