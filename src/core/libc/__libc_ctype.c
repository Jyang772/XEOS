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
unsigned char __libc_ctype_ascii[ 256 ] = {
    
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
