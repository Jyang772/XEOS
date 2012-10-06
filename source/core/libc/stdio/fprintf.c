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
