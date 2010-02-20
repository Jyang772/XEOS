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

#include "private/video.h"

extern unsigned char __kernel_video_attr;

void kernel_video_write_str( char * s )
{
    unsigned char * mem;
    unsigned char c;
    unsigned int x;
    unsigned int y;
    
    x = kernel_video_cursor_x();
    y = kernel_video_cursor_y();
    c = s[ 0 ];
    
    while( c != '\0' ) {
        
        if( c == '\n' ) {
            
            y++;
            
            x = 0;
            c = *( ++s );
            
            continue;
        }
        
        if( x == KERNEL_VIDEO_COLS ) {
            
            x = 0;
            
            y++;
        }
        
        mem      = ( unsigned char * )KERNEL_VIDEO_MEM;
        mem     += 2 * ( x + ( y * KERNEL_VIDEO_COLS ) );
        mem[ 0 ] = c;
        mem[ 1 ] = __kernel_video_attr;
        c        = *( ++s );
        
        x++;
    }
    
    kernel_video_cursor_move( x, y );
}
