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

#ifndef __LIBC_FLOAT_H__
#define __LIBC_FLOAT_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Radix of floating-point representations
 */
#define FLT_RADIX       2

/**
 * Floating-point rounding mode
 */
#define FLT_ROUNDS      1

/*******************************************************************************
 * Where the prefix "FLT" pertains to type float, "DBL" to type double, and
 * "LDBL" to type long double:
 ******************************************************************************/

/**
 * Precision (in decimal digits)
 */
#define FLT_DIG         6
#define DBL_DIG         15
#define LDBL_DIG        15

/**
 * Smallest number x such that 1.0 + x != 1.0
 */
#define FLT_EPSILON     1.19209290e-07F
#define DBL_EPSILON     2.2204460492503131e-16
#define LDBL_EPSILON    2.2204460492503131e-16L

/**
 * Number of digits, base FLT_RADIX, in mantissa
 */
#define FLT_MANT_DIG    24
#define DBL_MANT_DIG    53
#define LDBL_MANT_DIG   53

/**
 * Maximum number
 */
#define FLT_MAX         3.40282347e+38F
#define DBL_MAX         1.7976931348623157e+308
#define LDBL_MAX        1.7976931348623157e+308L

/**
 * Largest positive integer exponent to which FLT_RADIX can be raised and
 * remain representable
 */
#define FLT_MAX_EXP     128
#define DBL_MAX_EXP     1024
#define LDBL_MAX_EXP    1024

/**
 * Minimum normalised number
 */
#define FLT_MIN         1.17549435e-38F
#define DBL_MIN         2.2250738585072014e-308
#define LDBL_MIN        2.2250738585072014e-308L

/**
 * Smallest negative integer exponent to which FLT_RADIX can be raised and
 * remain representable
 */
#define FLT_MIN_EXP     ( -125 )
#define DBL_MIN_EXP     ( -1021 )
#define LDBL_MIN_EXP    ( -1021 )

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_FLOAT_H__ */
