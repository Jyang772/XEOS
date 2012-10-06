/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
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
    
    while( 1 )
    {
        if( *( format ) == '\0' )
        {
            break;
        }
        
        if( *( format ) == '%' )
        {
            format++;
            
            if( *( format ) == 'd' )
            {
                va_int = va_arg( arg, int );
                
                if( va_int < 0 )
                {
                    va_uint = -va_int;
                }
                else
                {
                    va_uint = va_int;
                }
                
                num_ptr = num_buf;
                
                do
                {
                    *( num_ptr++ ) = ( char )( '0' + va_uint % 10 );
                    va_uint       /= 10;
                }
                while( va_uint > 0 );
                
                if( va_int < 0 )
                {
                    *( num_ptr++ ) = '-';
                }
                
                do
                {
                    num_ptr--;
                    __libc_stdio_printf_putc( *( num_ptr ) );
                    count++;
                    
                }
                while( num_ptr != num_buf );
            }
            else if( strchr( "eEgGfF", *( format ) ) != NULL && *( format ) != 0 )
            {
                va_dbl = va_arg( arg, double );
                
                __libc_stdio_printf_double_convert( va_dbl, *( format ), 0, 6, num_buf );
                
                length = strlen( num_buf );
                
                if( stream == NULL )
                {
                    memcpy( s, num_buf, length );
                    
                    s += length;
                }
                else
                {
                    fputs( num_buf, stream );
                }
                
                count += length;
            }
            else if( *( format ) == 's' )
            {
                va_char_ptr = va_arg( arg, const char * );
                
                if( va_char_ptr == NULL )
                {
                    va_char_ptr = "(NULL)";
                }
                
                if( stream == NULL )
                {
                    length = strlen( va_char_ptr );
                    
                    memcpy( s, va_char_ptr, length );
                    
                    s     += length;
                    count += length;
                }
                else
                {
                    fputs( va_char_ptr, stream );
                    
                    count += strlen( va_char_ptr );
                }
                
            }
            else if( *( format ) == 'c' )
            {
                va_int = va_arg( arg, int );
                
                __libc_stdio_printf_putc( va_int );
                
                count++;
            }
            else if( *( format ) == 'n' )
            {
                va_int_ptr      = va_arg( arg, int * );
                *( va_int_ptr ) = count;
            }
            else if( *( format ) == '%' )
            {
                __libc_stdio_printf_putc( '%' );
                count++;
            }
            else
            {
                extra = __libc_stdio_printf_examine( &format, stream, s, &arg, count );
                count += extra;
                
                if( s != NULL )
                {
                    s += extra;
                }
            }
        }
        else
        {
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
