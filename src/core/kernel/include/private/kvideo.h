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

#ifndef __KERNEL_VIDEO_H__
#define __KERNEL_VIDEO_H__
#pragma once

/* Location of the video memory */
#define KVIDEO_MEM 0xB8000

/* BIOS screen dimensions */
#define KVIDEO_COLS 80
#define KVIDEO_ROWS 25

/* BIOS colors */
typedef enum
{
    
    KVIDEO_COLOR_BLACK        = 0x00,
    KVIDEO_COLOR_BLUE         = 0x01,
    KVIDEO_COLOR_GREEN        = 0x02,
    KVIDEO_COLOR_CYAN         = 0x03,
    KVIDEO_COLOR_RED          = 0x04,
    KVIDEO_COLOR_MAGENTA      = 0x05,
    KVIDEO_COLOR_BROWN        = 0x06,
    KVIDEO_COLOR_LIGHTGRAY    = 0x07,
    KVIDEO_COLOR_DARKGRAY     = 0x08,
    KVIDEO_COLOR_LIGHTBLUE    = 0x09,
    KVIDEO_COLOR_LIGHTGREEN   = 0x0A,
    KVIDEO_COLOR_LIGHTCYAN    = 0x0B,
    KVIDEO_COLOR_LIGHTRED     = 0x0C,
    KVIDEO_COLOR_LIGHTMAGENTA = 0x0D,
    KVIDEO_COLOR_LIGHTBROWN   = 0x0E,
    KVIDEO_COLOR_WHITE        = 0x0F
    
} kvideo_color;

void kvideo_clear( void );
void kvideo_set_bg( kvideo_color color );
void kvideo_set_fg( kvideo_color color );
void kvideo_cursor_move( unsigned int x, unsigned int y );
unsigned int kvideo_cursor_x( void );
unsigned int kvideo_cursor_y( void );

#endif /* __KERNEL_VIDEO_H__ */
