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

#ifndef __LIBC_STRING_H__
#define __LIBC_STRING_H__
#pragma once

#include <private/__null.h>
#include <private/__size_t.h>

/**
 * Copies ct to s including terminating NUL and returns s.
 */
char * strcpy( char * s, const char * ct );

/**
 * Copies at most n characters of ct to s. Pads with NUL characters if ct is of
 * length less than n. Note that this may leave s without NUL-termination.
 * Return s.
 */
char * strncpy( char * s, const char * ct, size_t n );

/**
 * Concatenate ct to s and return s.
 */
char * strcat( char * s, const char * ct );

/**
 * Concatenate at most n characters of ct to s. NUL-terminates s and return it.
 */
char * strncat( char * s, const char * ct, size_t n );

/**
 * Compares cs with ct, returning negative value if cs < ct, zero if cs == ct,
 * positive value if cs > ct.
 */
int strcmp( const char * cs, const char * ct );

/**
 * Compares at most (the first) n characters of cs and ct, returning negative
 * value if cs < ct, zero if cs == ct, positive value if cs > ct.
 */
int strncmp( const char * cs, const char * ct, size_t n );

/**
 * Compares cs with ct according to locale, returning negative value if c s< ct,
 * zero if cs == ct, positive value if cs > ct.
 */
int strcoll( const char * cs, const char * ct );

/**
 * Returns pointer to first occurrence of c in cs, or NULL if not found.
 */
char * strchr( const char * cs, int c );

/**
 * Returns pointer to last occurrence of c in cs, or NULL if not found.
 */
char * strrchr( const char * cs, int c );

/**
 * Returns length of prefix of cs which consists of characters which are in ct.
 */
size_t strspn( const char * cs, const char * ct );

/**
 * Returns length of prefix of cs which consists of characters which are not
 * in ct.
 */
size_t strcspn( const char * cs, const char * ct );

/**
 * Returns pointer to first occurrence in cs of any character of ct, or NULL
 * if none is found.
 */
char * strpbrk( const char * cs, const char * ct );

/**
 * Returns pointer to first occurrence of ct within cs, or NULL if none is
 * found.
 */
char * strstr( const char * cs, const char * ct );

/**
 * Returns length of cs.
 */
size_t strlen( const char * cs );

/**
 * Returns pointer to implementation-defined message string corresponding
 * with error n.
 */
char * strerror( int n );

/**
 * Searches s for next token delimited by any character from ct. Non-NULL s
 * indicates the first call of a sequence. If a token is found, it is
 * NUL-terminated and returned, otherwise NULL is returned. ct need not be
 * identical for each call in a sequence.
 */
char * strtok( char * s, const char * t );

/**
 * Stores in s no more than n characters (including terminating NUL) of a
 * string produced from ct according to a locale-specific transformation.
 * Returns length of entire transformed string.
 */
size_t strxfrm( char * s, const char * ct, size_t n );

/**
 * Copies n characters from ct to s and returns s. s may be corrupted
 * if objects overlap.
 */
void * memcpy( void * s, const void * ct, size_t n );

/**
 * Copies n characters from ct to s and returns s. s will not be corrupted if
 * objects overlap.
 */
void * memmove( void * s, const void * ct, size_t n );

/**
 * Compares at most (the first) n characters of cs and ct, returning negative
 * value if cs < ct, zero if cs == ct, positive value if cs > ct.
 */
int memcmp( const void * cs, const void * ct, size_t n );

/**
 * Returns pointer to first occurrence of c in first n characters of cs, or
 * NULL if not found.
 */
void * memchr( const void * cs, int c, size_t n );

/**
 * Replaces each of the first n characters of s by c and returns s.
 */
void * memset( void * s, int c, size_t n );

#endif /* __LIBC_STRING_H__ */
