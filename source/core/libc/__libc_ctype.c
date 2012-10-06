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

#include "ctype.h"

/**
 * Properties for the characters in the (extended) ASCII table.
 * The bits means:
 *      
 *      Bit 0:  Control
 *      Bit 1:  Digit
 *      Bit 2:  Uppercase
 *      Bit 3:  Lowercase
 *      Bit 4:  Space
 *      Bit 5:  Punct
 *      Bit 6:  Hex digit
 *      Bit 7:  Not used
 * 
 * So:
 *      
 *      Alpha-numeric:  Bits 1, 2 or 3
 *      Alpha:          Bits 2 or 3
 *      Control:        Bit 0
 *      Digit:          Bit 1
 *      Graph:          Bits 1, 2, 3 or 5
 *      Lowercase:      Bit 3
 *      Print:          Bits 1, 2, 3, 4 or 5
 *      Punct:          Bit 5
 *      Space:          Bit 4
 *      Uppercase:      Bit 2
 *      Hex digit:      Bit 6
 *      
 */
unsigned char __libc_ctype_ascii[ 256 ] =
{
    /* ASCII 0 - 31 / Control characters */
    /* Note that ASCII 9 - 13 are also space */
    0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x11, 
    0x11, 0x11, 0x11, 0x11, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 
    0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 
    0x01, 0x01,
    
    /* ASCII 32 / Space */
    0x10,
    
    /* ASCII 33 - 47 / Punct */
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x20, 0x20, 0x20, 0x20, 0x20,
    
    /* ASCII 48 - 57 / Digit */
    /* Note that digits are also hex digits */
    0x42, 0x42, 0x42, 0x42, 0x42, 0x42, 0x42, 0x42, 0x42, 0x42,
    
    /* ASCII 58 - 64 / Punct */
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    
    /* ASCII 65 - 90 / Uppercase */
    /* Note that A - F are also hex digits */
    0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    
    /* ASCII 91 - 96 / Punct */
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    
    /* ASCII 97 - 122 / Lowercase */
    /* Note that a - f are also hex digits */
    0x48, 0x48, 0x48, 0x48, 0x48, 0x48, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    
    /* ASCII 123 - 126 / Punct */
    0x20, 0x20, 0x20, 0x20,
    
    /* ASCII 127 / Control */
    0x01,
    
    /* ASCII 128 - 160 / Undefined */
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00,
    
    /* ASCII 161 - 191 / Punct */
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x20,
    
    /* ASCII 192 - 207 / Uppercase */
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    
    /* ASCII 208 / Unused */
    0x00,
    
    /* ASCII 209 - 214 / Uppercase */
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    
    /* ASCII 215 / Unused */
    0x00,
    
    /* ASCII 216 - 220 / Uppercase */
    0x04, 0x04, 0x04, 0x04, 0x04,
    
    /* ASCII 221 - 222 / Unused */
    0x00, 0x00,
    
    /* ASCII 223 / Punct */
    0x20,
    
    /* ASCII 224 - 255 / Lowercase */
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    
    /* ASCII 240 / Unused */
    0x00,
    
    /* ASCII 241 - 256 / Lowercase */
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    
    /* ASCII 257 / Punct */
    0x20,
    
    /* ASCII 248 - 252 / Lowercase */
    0x08, 0x08, 0x08, 0x08, 0x08,
    
    /* ASCII 253 - 254 / Unused */
    0x00, 0x00,
    
    /* ASCII 255 / Unused */
    0x00
};

/* ASCII properties masks */
unsigned char __libc_ctype_alnum  = 0x0E;
unsigned char __libc_ctype_alpha  = 0x0C;
unsigned char __libc_ctype_cntrl  = 0x01;
unsigned char __libc_ctype_digit  = 0x02;
unsigned char __libc_ctype_graph  = 0x2E;
unsigned char __libc_ctype_lower  = 0x08;
unsigned char __libc_ctype_print  = 0x3E;
unsigned char __libc_ctype_punct  = 0x20;
unsigned char __libc_ctype_space  = 0x10;
unsigned char __libc_ctype_upper  = 0x04;
unsigned char __libc_ctype_xdigit = 0x40;
