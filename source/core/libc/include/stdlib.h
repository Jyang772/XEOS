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

#ifndef __LIBC_STDLIB_H__
#define __LIBC_STDLIB_H__
#pragma once

#include <private/__null.h>
#include <private/__size_t.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Value for status argument to exit indicating failure.
 */
#define EXIT_FAILURE    1

/**
 * Value for status argument to exit indicating success.
 */
#define EXIT_SUCCESS    0

/**
 * Maximum value returned by rand().
 */
#define RAND_MAX        32767

/**
 * Return type of div(). Structure having members:
 * 
 *      - int quot      quotient
 *      - int rem       remainder
 */
typedef struct
{
    int quot;
    int rem;
}
div_t;

/**
 * Return type of ldiv(). Structure having members:
 * 
 *      - long quot     quotient
 *      - long rem      remainder
 */
typedef struct
{
    long quot;
    long rem;
}
ldiv_t;

/**
 * Returns absolute value of n.
 */
int abs( int n );

/**
 * Returns absolute value of n.
 */
long labs( long n );

/**
 * Returns quotient and remainder of num/denom.
 */
div_t div( int num, int denom );

/**
 * Returns quotient and remainder of num/denom.
 */
ldiv_t ldiv( long num, long denom );

/**
 * Equivalent to strtod( s, ( char ** ) NULL) except that errno is not
 * necessarily set on conversion error.
 */
double atof( const char * s );


/**
 * Equivalent to ( int )strtol( s, ( char ** ) NULL, 10 ) except that errno
 * is not necessarily set on conversion error.
 */
int atoi( const char * s );

/**
 * Equivalent to strtol( s, ( char ** )NULL, 10 ) except that errno is not
 * necessarily set on conversion error.
 */
long atol( const char * s );

/**
 * Converts initial characters (ignoring leading white space) of s to type
 * double. If endp non-null, stores pointer to unconverted suffix in * endp.
 * On overflow, sets errno to ERANGE and returns HUGE_VAL with the appropriate
 * sign; on underflow, sets errno to ERANGE and returns zero; otherwise returns
 * converted value.
 */
double strtod( const char * s, char ** endp );

/**
 * Converts initial characters (ignoring leading white space) of s to type long.
 * If endp non-null,
stores pointer to unconverted suffix in * endp.
 * If base between 2 and 36, that base used for conversion; if zero, leading
 * (after any sign) 0X or 0x implies hexadecimal, leading 0 (after any sign)
 * implies octal, otherwise decimal assumed. Leading 0X or 0x permitted for
 * base hexadecimal. On overflow, sets errno to ERANGE and returns LONG_MAX
 * or LONG_MIN (as appropriate for sign); otherwise returns converted value.
 */
long strtol( const char * s, char ** endp, int base );

/**
 * As for strtol except result is unsigned long and value on overflow is
 * ULONG_MAX.
 */
unsigned long strtoul( const char * s, char ** endp, int base );

/**
 * Returns pointer to zero-initialised newly-allocated space for an array of
 * nobj objects each of size size, or NULL on error.
 */
void * calloc( size_t nobj, size_t size );

/**
 * Returns pointer to uninitialised newly-allocated space for an object of size
 * size, or NULL on error.
 */
void * malloc( size_t size );

/**
 * Returns pointer to newly-allocated space for an object of size size,
 * initialised, to minimum of old and new sizes, to existing contents of p
 * (if non-null), or NULL on error. On success, old object deallocated,
 * otherwise unchanged.
 */
void * realloc( void * p, size_t size );

/**
 * If p non-null, deallocates space to which it points.
 */
void free( void * p );

/**
 * Terminates program abnormally, by calling raise( SIGABRT ).
 */
void abort( void );

/**
 * Terminates program normally. Functions installed using atexit are called
 * (in reverse order to that in which installed), open files are flushed, open
 * streams are closed and control is returned to environment. status is
 * returned to environment in implementation-dependent manner.
 * Zero or EXIT_SUCCESS indicates successful termination and EXIT_FAILURE
 * indicates unsuccessful termination. Implementations may define other values.
 */
void exit( int status );

/**
 * Registers fcn to be called when program terminates normally (or when main
 * returns). Returns non-zero on failure.
 */
int atexit( void ( * fcm )( void ) );

/**
 * If s is not NULL, passes s to environment for execution, and returns status
 * reported by command processor; if s is NULL, non-zero returned if environment
 * has a command processor.
 */
int system( const char * s );

/**
 * Returns string associated with name name from implementation's environment,
 * or NULL if no such string exists.
 */
char * getenv( const char * name );

/**
 * Searches ordered array base (of n objects each of size size) for item
 * matching key according to comparison function cmp. cmp must return negative
 * value if first argument is less than second, zero if equal and positive if
 * greater. Items of base are assumed to be in ascending order (according to
 * cmp). Returns a pointer to an item matching key, or NULL if none found.
 */
void * bsearch( const void * key, const void * base, size_t n, size_t size, int ( * cmp )( const void * keyval, const void * datum ) );

/**
 * Arranges into ascending order array base (of n objects each of size size)
 * according to comparison function cmp. cmp must return negative value if first
 * argument is less than second, zero if equal and positive if greater.
 */
void qsort( void * base, size_t n, size_t size, int ( * cmp )( const void *, const void * ) );

/**
 * Returns pseudo-random number in range 0 to RAND_MAX.
 */
int rand( void );

/**
 * Uses seed as seed for new sequence of pseudo-random numbers.
 * Initial seed is 1.
 */
void srand( unsigned int seed );

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_STDLIB_H__ */
