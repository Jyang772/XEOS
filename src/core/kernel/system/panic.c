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
#include "system.h"

void panic( char * s )
{
    kernel_video_set_fg( KERNEL_VIDEO_COLOR_WHITE );
    kernel_video_set_bg( KERNEL_VIDEO_COLOR_BLACK );
    kernel_video_clear();
    
    kernel_video_print_str(
        "\n"
        "    ************************************************************************\n"
        "    *                                                                      *\n"
        "    *                         XEOS - KERNEL PANIC                          *\n"
        "    *                                                                      *\n"
        "    ************************************************************************\n"
        "\n"
    );
    
    kernel_video_prompt( "A fatal error occured:" );
    kernel_video_print_str( "\n" );
    kernel_video_set_fg( KERNEL_VIDEO_COLOR_RED );
    kernel_video_print_str( s );
    kernel_video_set_fg( KERNEL_VIDEO_COLOR_WHITE );
    kernel_video_print_str( "\n\n" );
    kernel_video_prompt( "Please reboot the system..." );
    
    for( ; ; );
}
