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

#ifndef __LIBC_LIMITS_H__
#define __LIBC_LIMITS_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Number of bits in a char
 */
#define CHAR_BIT    8

/**
 * Maximum value of type char
 */
#define CHAR_MAX    127

/**
 * Minimum value of type char
 */
#define CHAR_MIN    ( -CHAR_MAX - 1 )

/**
 * Maximum value of type signed char
 */
#define SCHAR_MAX   127

/**
 * Minimum value of type signed char
 */
#define SCHAR_MIN   ( -SCHAR_MAX - 1 )

/**
 * Maximum value of type unsigned char
 */
#define UCHAR_MAX   255U

/**
 * Maximum value of type short
 */
#define SHRT_MAX    32767

/**
 * Minimum value of type short
 */
#define SHRT_MIN    ( -SHRT_MAX - 1 )

/**
 * Maximum value of type unsigned short
 */
#define USHRT_MAX   65535U

/**
 * Maximum value of type int
 */
#define INT_MAX     2147483647

/**
 * Minimum value of type int
 */
#define INT_MIN     ( -INT_MAX - 1 )

/**
 * Maximum value of type unsigned int
 */
#define UINT_MAX    4294967295U

/**
 * Maximum value of type long
 */
#define LONG_MAX    2147483647L

/**
 * Minimum value of type long
 */
#define LONG_MIN    ( -LONG_MAX - 1 )

/**
 * Maximum value of type unsigned long
 */
#define ULONG_MAX   4294967295UL

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_LIMITS_H__ */
