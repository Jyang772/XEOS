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

#ifndef __LIBC_STDARG_H__
#define __LIBC_STDARG_H__
#pragma once

#ifndef __GNUC__
    
    /**
     * Type of object holding context information
     */
    typedef char * va_list;
    
    /**
     * Initialisation macro which must be called once before any unnamed
     * argument is accessed. Stores context information in ap. lastarg is the
     * last named parameter of the function.
     */
    #define va_start( ap, lastarg ) ap = ( char * ) & lastarg + sizeof( int )
    
    /**
     *  Yields value of the type (type) and value of the next unnamed argument.
     */
    #define va_arg( ap, type ) *( type * )( ap += sizeof( type ), ap - sizeof( type ) )
    
    /**
     * Termination macro which must be called once after argument processing
     * and before exit from function.
     */
    #define va_end( ap ) ap = 0
    
#else
    
    /**
     * Use of GCC builtin
     */
    typedef __builtin_va_list va_list;
    #define va_start( ap, param ) __builtin_va_start( ap, param )
    #define va_end( ap ) __builtin_va_end( ap )
    #define va_arg( ap, type ) __builtin_va_arg( ap, type )
    
#endif

#endif /* __LIBC_STDARG_H__ */
