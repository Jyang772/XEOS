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

#ifndef __LIBC_CTYPE_H__
#define __LIBC_CTYPE_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * isalpha( c ) or isdigit( c )
 */
int isalnum( int c );

/**
 * isupper( c ) or islower( c )
 */
int isalpha( int c );

/**
 * Is control character. In ASCII, control characters are 0x00 (NUL) to
 * 0x1F (US), and 0x7F (DEL)
 */
int iscntrl( int c );

/**
 * Is decimal digit
 */
int isdigit( int c );

/**
 * Is printing character other than space
 */
int isgraph( int c );

/**
 * Is lower-case letter
 */
int islower( int c );

/**
 * Is printing character (including space). In ASCII, printing characters are
 * 0x20 (' ') to 0x7E ('~')
 */
int isprint( int c );

/**
 * Is printing character other than space, letter, digit
 */
int ispunct( int c );

/**
 * Is space, formfeed, newline, carriage return, tab, vertical tab
 */
int isspace( int c );

/**
 * Is upper-case letter
 */
int isupper( int c );

/**
 * Is hexadecimal digit
 */
int isxdigit( int c );

/**
 * Return lower-case equivalent
 */
int tolower( int c );

/**
 * Return upper-case equivalent
 */
int toupper( int c );

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_CTYPE_H__ */
