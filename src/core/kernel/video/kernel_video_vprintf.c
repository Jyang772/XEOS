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

#include <xeos/xeos.h>
#include "private/video.h"

void kernel_video_vprintf( char * format, va_list arg )
{
    unsigned int x;
    unsigned int y;
    int          va_int;
    unsigned int va_uint;
    char         va_char;
    char       * va_char_ptr;
    uintptr_t    va_uint_ptr;
    char         nbuf[ 32 ] = { 0 };
    
    if( !format || *( format ) == '\0' ) {
        
        return;
    }
    
    while( *( format ) != '\0' ) {
        
        switch( *( format ) ) {
            
            case '%':
                
                format++;
                
                if( *( format ) == '\0' ) {
                    
                    kernel_video_putc( '%', false );
                    break;
                }
                
                switch( *( format ) ) {
                    
                    case 'd':
                    case 'i':
                        
                        va_int = va_arg( arg, int );
                        
                        itoa( va_int, nbuf, 10 );
                        kernel_video_print( nbuf );
                        break;
                        
                    case 'x':
                    case 'X':
                        
                        va_uint = va_arg( arg, unsigned int );
                        
                        utoa( va_uint, nbuf, 16 );
                        kernel_video_print( "0x" );
                        kernel_video_print( nbuf );
                        break;
                        
                    case 'o':
                        
                        va_uint = va_arg( arg, unsigned int );
                        
                        utoa( va_uint, nbuf, 8 );
                        kernel_video_print( "0" );
                        kernel_video_print( nbuf );
                        break;
                        
                    case 'u':
                        
                        va_uint = va_arg( arg, unsigned int );
                        
                        utoa( va_uint, nbuf, 10 );
                        kernel_video_print( nbuf );
                        break;
                        
                    case 'c':
                        
                        va_char = ( char )va_arg( arg, int );
                        
                        kernel_video_putc( va_char, false );
                        break;
                        
                    case 's':
                        
                        va_char_ptr = va_arg( arg, char * );
                        
                        kernel_video_print( va_char_ptr );
                        break;
                        
                    case 'p':
                        
                        va_uint_ptr = va_arg( arg, uintptr_t );
                        
                        utoa( va_uint_ptr, nbuf, 16 );
                        kernel_video_print( "0x" );
                        kernel_video_print( nbuf );
                        break;
                        
                    case '%':
                        
                        kernel_video_putc( '%', false );
                        break;
                    
                    default:
                        
                        kernel_video_putc( '%', false );
                        kernel_video_putc( *( format ), false );
                        break;
                }
                
                break;
            
            default:
                
                kernel_video_putc( *( format ), false );
                break;
        }
        
        format++;
    }
    
    x = kernel_video_cursor_x();
    y = kernel_video_cursor_y();
    
    kernel_video_cursor_move( x, y );
}
