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

#ifndef __LIBC_MATH_H__
#define __LIBC_MATH_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Magnitude returned (with correct sign) on overflow error
 */
#define HUGE_VAL 3.4028234663853E+38f

/**
 * Exponential of x
 */
double exp( double x );

/**
 * Natural logarithm of x
 */
double log( double x );

/**
 * Base-10 logarithm of x
 */
double log10( double x );

/**
 * x raised to power y
 */
double pow( double x, double y );

/**
 * Square root of x
 */
double sqrt( double x );

/**
 * Smallest integer not less than x
 */
double ceil( double x );

/**
 * Largest integer not greater than x
 */
double floor( double x );

/**
 * Absolute value of x
 */
double fabs( double x );

/**
 * x times 2 to the power n
 */
double ldexp( double x, int n );

/**
 * If x non-zero, returns value, with absolute value in interval [1/2, 1],
 * and assigns to * exp integer such that product of return value and 2 raised
 * to the power * exp equals x; if x zero, both return value and * exp are zero
 */
double frexp( double x, int * exp );

/**
 * Returns fractional part and assigns to * ip integral part of x, both with
 * same sign as x
 */
double modf( double x, double * ip );

/**
 * If y non-zero, floating-point remainder of x / y, with same sign as x;
 * if y zero, result is implementation-defined
 */
double fmod( double x, double y );

/**
 * Sine of x
 */
double sin( double x );

/**
 * Cosine of x
 */
double cos( double x );

/**
 * Tangent of x
 */
double tan( double x );

/**
 * Arc-sine of x
 */
double asin( double x );

/**
 * Arc-cosine of x
 */
double acos( double x );

/**
 * Arc-tangent of x
 */
double atan( double x );

/**
 * Arc-tangent of y / x
 */
double atan2( double y, double x );

/**
 * Hyperbolic sine of x
 */
double sinh( double x );

/**
 * Hyperbolic cosine of x
 */
double cosh( double x );

/**
 * Hyperbolic tangent of x
 */
double tanh( double x );

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_MATH_H__ */
