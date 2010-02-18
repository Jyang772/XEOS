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

#ifndef __LIBXEOS_GEOMETRY_H__
#define __LIBXEOS_GEOMETRY_H__
#pragma once

#include <xeos/types.h>

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
 * Types
 ******************************************************************************/
 
typedef struct
{
    
    XSFloat x;
    XSFloat y;
    
} XSPoint;

typedef XSPoint * XSPointArray;
typedef XSPoint * XSPointPointer;

typedef struct
{
    
    XSFloat width;
    XSFloat height;
    
} XSSize;

typedef XSSize * XSSizeArray;
typedef XSSize * XSSizePointer;

typedef struct
{
    
    XSPoint origin;
    XSSize  size;
    
} XSRect;

typedef XSRect * XSRectArray;
typedef XSRect * XSRectPointer;

typedef struct
{
    
    XSLongInteger location;
    XSLongInteger length;
    
} XSRange;

typedef XSRange * XSRangeArray;
typedef XSRange * XSRangePointer;

typedef struct
{
    
    XSFloat left;
    XSFloat top;
    XSFloat right;
    XSFloat bottom;
    
} XSEdgeInset;

typedef XSEdgeInset * XSEdgeInsetArray;
typedef XSEdgeInset * XSEdgeInsetPointer;

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

XSPoint     XSMakePoint( XSFloat x, XSFloat y );
XSSize      XSMakeSize( XSFloat width, XSFloat height );
XSRect      XSMakeRect( XSFloat x, XSFloat y, XSFloat width, XSFloat height );
XSRange     XSMakeRange( XSLongInteger location, XSLongInteger length );
XSEdgeInset XSMakeEdgeInset( XSFloat left, XSFloat top, XSFloat right, XSFloat bottom );
XSFloat     XSRadiansToDegrees( XSFloat x );
XSFloat     XSDegreesToRadians( XSFloat x );
XSFloat     XSDistanceBetweenPoints( XSPoint a, XSPoint b );
XSFloat     XSAngleBetweenPoints( XSPoint a, XSPoint b );

#ifdef __cplusplus
}
#endif

#endif /* __LIBXEOS_GEOMETRY_H__ */
