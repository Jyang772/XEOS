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

/* $Id: XSColorHSLFromRGB.c 427 2010-07-15 21:11:44Z macmade $ */

#include "color.h"
#include "types.h"
#include "math.h"

XSHSLColor XSColorHSLFromRGB( XSRGBColor rgb )
{
    XSFloat r;
    XSFloat g;
    XSFloat b;
    XSFloat max;
    XSFloat min;
    XSFloat delta;
    XSHSLColor hsl;
    
    r = MIN( rgb.red,   255 );
    g = MIN( rgb.green, 255 );
    b = MIN( rgb.blue,  255 );
    
    r = r / 255;
    g = g / 255;
    b = b / 255;
    
    max = MAX( MAX( r, g ), b );
    min = MIN( MIN( r, g ), b );
    
    delta = max - min;
    
    hsl.luminance = max + min / 2;
    
    if( delta == 0 )
    {
        hsl.hue        = 0;
        hsl.saturation = 0;
    }
    else
    {
        if( hsl.luminance < 0.5 )
        {
            hsl.saturation = delta / ( max + min );
        }
        else
        {
            hsl.saturation = delta / ( 2 - max - min );
        }
        
        r = ( ( ( max - r ) / 6 ) + ( delta / 2 ) ) / delta;
        g = ( ( ( max - g ) / 6 ) + ( delta / 2 ) ) / delta;
        b = ( ( ( max - b ) / 6 ) + ( delta / 2 ) ) / delta;
        
        if( r == max )
        {
            hsl.hue = b - g;
        }
        else if( g == max )
        {
            hsl.hue = ( 1 / 3 ) + r - b;
        }
        else if( b == max )
        {
            hsl.hue = ( 2 / 3 ) + g - r;
        }
        
        if( hsl.hue < 0 )
        {
            hsl.hue += 1;
        }
        else if( hsl.hue > 1 )
        {
            hsl.hue -= 1;
        }
    }
    
    hsl.hue        = hsl.hue        * 360;
    hsl.saturation = hsl.saturation * 100;
    hsl.luminance  = hsl.luminance  * 100;
    hsl.alpha      = rgb.alpha;
    
    return hsl;
}
