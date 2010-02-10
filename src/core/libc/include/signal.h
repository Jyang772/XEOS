/*******************************************************************************
 * XEOS - x86 Experimental Operating System
 * 
 * Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)
 * All rights reserved
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *  -   Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 *  -   Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *  -   Neither the name of 'Jean-David Gadina' nor the names of its
 *      contributors may be used to endorse or promote products derived from
 *      this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

/* $Id$ */

#ifndef __LIBC_SIGNAL_H__
#define __LIBC_SIGNAL_H__
#pragma once

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
#define SIG_DFL 0x07

/**
 * Signal return value indicating error
 */
#define SIG_ERR 0x08

/**
 * Specifies that signal should be ignored
 */
#define SIG_IGN 0x09

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
void ( *signal( int sig, void( *handler )( int ) ) )( int );

/**
 * Sends signal sig. Returns zero on success.
 */
int raise( int sig );

#endif /* __LIBC_SIGNAL_H__ */
