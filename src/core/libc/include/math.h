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

#ifndef __LIBC_MATH_H__
#define __LIBC_MATH_H__
#pragma once

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
 * and assigns to * exp integer
such that product of return value and 2 raised
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

#endif /* __LIBC_MATH_H__ */
