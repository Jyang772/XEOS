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

/**
 * Copyright notice:
 * 
 * Some parts of this code are borrowed from the Public Domain C runtime library
 * (PDPCLib) by Paul Edwards (fight.subjugation@gmail.com), with some
 * modifications to suit the needs of the XEOS project.
 * 
 * PDPCLib can be found at the following address: http://pdos.sourceforge.net/
 * 
 * If you need some parts of this code, please use PDPCLib instead.
 * As it's realeased to the public domain, no license restriction will apply.
 */

#include "stdio.h"
#include "string.h"
#include "float.h"
#include "ctype.h"

FILE __libc_stdio_stdin;
FILE __libc_stdio_stdout;
FILE __libc_stdio_stderr;

FILE * stdin  = &__libc_stdio_stdin;
FILE * stdout = &__libc_stdio_stdout;
FILE * stderr = &__libc_stdio_stderr;

#define __libc_stdio_printf_putc( c ) ( ( stream == NULL ) ? *( s++ ) = ( char )c : putc( c, stream ) )
#define __libc_stdio_printf_void( x ) ( ( void )( x ) )

static void __libc_stdio_printf_double_convert( double num, char type, size_t width, int precision, char * result );
static int __libc_stdio_printf_examine( const char ** format, FILE * stream, char * s, va_list * arg, int count );

int __libc_stdio_printf( const char * format, va_list arg, FILE * stream, char * s );
int __libc_stdio_printf( const char * format, va_list arg, FILE * stream, char * s )
{
    unsigned int count;
    size_t       length;
    int          va_int;
    double       va_dbl;
    unsigned int va_uint;
    int        * va_int_ptr;
    const char * va_char_ptr;
    char       * num_ptr;
    char         num_buf[ 50 ];
    int          extra;
    
    count = 0;
    
    while( 1 ) {
        
        if( *( format ) == '\0' ) {
            
            break;
            
        }
        
        if( *( format ) == '%' ) {
            
            format++;
            
            if( *( format ) == 'd' ) {
                
                va_int = va_arg( arg, int );
                
                if( va_int < 0 ) {
                    
                    va_uint = -va_int;
                    
                } else {
                    
                    va_uint = va_int;
                }
                
                num_ptr = num_buf;
                
                do {
                    
                    *( num_ptr++ ) = ( char )( '0' + va_uint % 10 );
                    va_uint       /= 10;
                    
                } while( va_uint > 0 );
                
                if( va_int < 0 ) {
                    
                    *( num_ptr++ ) = '-';
                }
                
                do {
                    
                    num_ptr--;
                    __libc_stdio_printf_putc( *( num_ptr ) );
                    count++;
                    
                } while( num_ptr != num_buf );
                
            } else if( strchr( "eEgGfF", *( format ) ) != NULL && *( format ) != 0 ) {
                
                va_dbl = va_arg( arg, double );
                
                __libc_stdio_printf_double_convert( va_dbl, *( format ), 0, 6, num_buf );
                
                length = strlen( num_buf );
                
                if( stream == NULL ) {
                    
                    memcpy( s, num_buf, length );
                    
                    s += length;
                    
                } else {
                    
                    fputs( num_buf, stream );
                }
                
                count += length;
                
            } else if( *( format ) == 's' ) {
                
                va_char_ptr = va_arg( arg, const char * );
                
                if( va_char_ptr == NULL ) {
                    
                    va_char_ptr = "(NULL)";
                }
                
                if( stream == NULL ) {
                    
                    length = strlen( va_char_ptr );
                    
                    memcpy( s, va_char_ptr, length );
                    
                    s     += length;
                    count += length;
                    
                } else {
                    
                    fputs( va_char_ptr, stream );
                    
                    count += strlen( va_char_ptr );
                }
                
            } else if( *( format ) == 'c' ) {
                
                va_int = va_arg( arg, int );
                
                __libc_stdio_printf_putc( va_int );
                
                count++;
                
            } else if( *( format ) == 'n' ) {
                
                va_int_ptr      = va_arg( arg, int * );
                *( va_int_ptr ) = count;
                
            } else if( *( format ) == '%' ) {
                
                __libc_stdio_printf_putc( '%' );
                count++;
                
            } else {
                
                extra = __libc_stdio_printf_examine( &format, stream, s, &arg, count );
                count += extra;
                
                if( s != NULL ) {
                    
                    s += extra;
                }
            }
            
        } else {
            
            __libc_stdio_printf_putc( *( format ) );
            
            count++;
        }
        
        format++;
    }
    
    return count;
}

static void __libc_stdio_printf_double_convert( double num, char type, size_t width, int precision, char * result )
{
    ( void )num;
    ( void )type;
    ( void )width;
    ( void )precision;
    ( void )result;
}

static int __libc_stdio_printf_examine( const char ** format, FILE * stream, char * s, va_list * arg, int count )
{
    ( void )format;
    ( void )stream;
    ( void )s;
    ( void )arg;
    ( void )count;
    
    return 0;
}
