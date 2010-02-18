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

#ifndef __LIBXEOS_LOG_H__
#define __LIBXEOS_LOG_H__
#pragma once

#include <xeos/types.h>
#include <xeos/string.h>

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
 * Macros
 ******************************************************************************/

#define XSLogPoint( p )     XSLog(                                          \
                                    "X: %f\n"                               \
                                    "Y: %f",                                \
                                    p.x,                                    \
                                    p.y                                     \
                            )
#define XSLogSize( s )      XSLog(                                          \
                                    "Width:  %f\n"                          \
                                    "Height: %f",                           \
                                    s.width,                                \
                                    s.height                                \
                            )
#define XSLogRect( r )      XSLog(                                          \
                                    "X:      %f\n"                          \
                                    "Y:      %f\n",                         \
                                    "Width:  %f\n",                         \
                                    "Height: %f",                           \
                                    r.origin.x,                             \
                                    r.origin.y,                             \
                                    r.size.width,                           \
                                    r.size.height                           \
                            )
#define XSLogRange( r )     XSLog(                                          \
                                    "Location: %f\n"                        \
                                    "Length  : %f",                         \
                                    r.location,                             \
                                    r.length                                \
                            )
#define XSLogRGBColor( c )  XSLog(                                          \
                                    "Red:   %f\n"                           \
                                    "Green: %f\n",                          \
                                    "Blue:  %f\n",                          \
                                    "Alpha: %f",                            \
                                    c.red,                                  \
                                    c.green,                                \
                                    c.blue,                                 \
                                    c.alpha                                 \
                            )
#define XSLogHSVColor( c )  XSLog(                                          \
                                    "Hue:        %f\n"                      \
                                    "Saturation: %f\n",                     \
                                    "Value:      %f\n",                     \
                                    "Alpha:      %f",                       \
                                    c.hue,                                  \
                                    c.saturation,                           \
                                    c.value,                                \
                                    c.alpha                                 \
                            )
#define XSLogHSLColor( c )  XSLog(                                          \
                                    "Hue:        %f\n"                      \
                                    "Saturation: %f\n",                     \
                                    "Luminance:  %f\n",                     \
                                    "Alpha:      %f",                       \
                                    c.hue,                                  \
                                    c.saturation,                           \
                                    c.luminance,                            \
                                    c.alpha                                 \
                            )

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

void XSLog( XSCString fmt, ... );

#ifdef __cplusplus
}
#endif

#endif /* __LIBXEOS_LOG_H__ */
