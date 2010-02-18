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

#include <hal/hal.h>
#include <hal/crtc.h>

#include "private/kvideo.h"

/* Video attribute byte */
static unsigned char __kvideo_attr = 0x00;

/* Cursor position */
static unsigned int __kvideo_x     = 0x00;
static unsigned int __kvideo_y     = 0x00;

void kvideo_cursor_move( unsigned int x, unsigned int y )
{
    unsigned int cursor_pos;
    
    x          = KMIN( x, KVIDEO_COLS - 1 );
    y          = KMIN( y, KVIDEO_ROWS - 1 );
    cursor_pos = x + ( y * KVIDEO_COLS );
    
    hal_port_out( CRTC_DATA_REGISTER, CRTC_CURSOR_LOCATION_HIGH );
    hal_port_out( CRTC_INDEX_REGISTER, cursor_pos >> 8 );
    hal_port_out( CRTC_DATA_REGISTER, CRTC_CURSOR_LOCATION_LOW );
    hal_port_out( CRTC_INDEX_REGISTER, cursor_pos & 0x00FF );
}

unsigned int kvideo_cursor_x( void )
{
    return __kvideo_x;
}

unsigned int kvideo_cursor_y( void )
{
    return __kvideo_y;
}

void kvideo_clear( void )
{
    unsigned char * mem;
    unsigned int    memSize;
    unsigned int    i;
    
    mem     = ( unsigned char * )KVIDEO_MEM;
    memSize = KVIDEO_COLS * KVIDEO_ROWS;
    i       = 0;
    
    for( i = 0; i < memSize; i++ ) {
        
        mem[ 0 ] = 0x20;
        mem[ 1 ] = __kvideo_attr;
        mem     += 2;
    }
    
    kvideo_cursor_move( 0, 0 );
}

void kvideo_set_bg( kvideo_color color )
{
    __kvideo_attr &= ( 0x0F );
    __kvideo_attr |= ( color << 4 );
}

void kvideo_set_fg( kvideo_color color )
{
    __kvideo_attr &= ( 0xF0 );
    __kvideo_attr |= color;
}
