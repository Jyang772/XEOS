/*******************************************************************************
 * Copyright (c) <YEAR>, <OWNER>
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

#ifndef __LIBC_SIGNAL_H__
#define __LIBC_SIGNAL_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

void __libc_signal_dfl( int sig );
void __libc_signal_err( int sig );
void __libc_signal_ign( int sig );

/**
 * Abnormal termination
 */
#define SIGABRT 0x01

/**
 * Arithmetic error
 */
#define SIGFPE  0x02

/**
 * Invalid execution
 */
#define SIGILL  0x03

/**
 * (Asynchronous) interactive attention
 */
#define SIGINT  0x04

/**
 * Illegal storage access
 */
#define SIGSEGV 0x05

/**
 * (Asynchronous) termination request
 */
#define SIGTERM 0x06

/**
 * Specifies default signal handling
 */
#define SIG_DFL __libc_signal_dfl

/**
 * Signal return value indicating error
 */
#define SIG_ERR __libc_signal_err

/**
 * Specifies that signal should be ignored
 */
#define SIG_IGN __libc_signal_ign

/**
 * Install handler for subsequent signal sig. If handler is SIG_DFL,
 * implementation-defined default behaviour will be used; if SIG_IGN, signal
 * will be ignored; otherwise function pointed to by handler will be invoked
 * with argument sig. In the last case, handling is restored to default
 * behaviour before handler is called. If handler returns, execution resumes
 * where signal occurred. signal returns the previous handler or SIG_ERR on
 * error. Initial state is implementation-defined. Implementations may may
 * define signals additional to those listed here.
 */
void ( * signal( int sig, void( * handler )( int ) ) )( int );

/**
 * Sends signal sig. Returns zero on success.
 */
int raise( int sig );

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_SIGNAL_H__ */
