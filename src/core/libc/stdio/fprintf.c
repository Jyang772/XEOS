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

#include "stdio.h"
#include "stdarg.h"

/**
 * Converts (according to format format) and writes output to stream stream.
 * Number of characters written, or negative value on error, is returned.
 * Conversion specifications consist of:
 *      
 *      -   %
 *      -   (optional) flag:
 *          
 *          -       left adjust
 *          +       always sign
 *          space   space if no sign
 *          0       zero pad
 *          #       Alternate form: for conversion character o, first digit will
 *                  be zero, for [xX], prefix 0x or 0X to non-zero value, for
 *                  [eEfgG], always decimal point, for [gG] trailing zeros not
 *                  removed.
 *          
 *      -   (optional) minimum width: if specified as *, value taken from next
 *          argument (which must be int).
 *      -   (optional) . (separating width from precision):
 *      -   (optional) precision: for conversion character s, maximum characters
 *          to be printed from the string, for [eEf], digits after decimal
 *          point, for [gG], significant digits, for an integer, minimum number
 *          of digits to be printed. If specified as *, value taken from next
 *          argument (which must be int).
 *      -   (optional) length modifier:
 *              
 *          h       short or unsigned short
 *          l       long or unsigned long
 *          L       long double
 *          
 *      conversion character:
 *          
 *          d,i     int argument, printed in signed decimal notation
 *          o       int argument, printed in unsigned octal notation
 *          x,X     int argument, printed in unsigned hexadecimal notation
 *          u       int argument, printed in unsigned decimal notation
 *          c       int argument, printed as single character
 *          s       char* argument
 *          f       double argument, printed with format [-]mmm.ddd
 *          e,E     double argument, printed with format [-]m.dddddd(e|E)(+|-)xx
 *          g,G     double argument
 *          p       void * argument, printed as pointer
 *          n       int * argument : the number of characters written to this
 *                  point is written into argument
 *          %       no argument; prints %
 */
int fprintf( FILE * stream, const char * format, ... )
{
    int ret;
    va_list arg;
    
    va_start( arg, format );
    
    ret = vfprintf( stream, format, arg );
    
    va_end( arg );
    
    return ret;
}
