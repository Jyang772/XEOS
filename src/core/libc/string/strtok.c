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

/**
 * Copyright notice:
 * 
 * Most of this code is borrowed from the Public Domain C runtime library
 * (PDPCLib) by Paul Edwards (fight.subjugation@gmail.com), with some
 * modifications to suit the needs of the XEOS project.
 * 
 * PDPCLib can be found at the following address: http://pdos.sourceforge.net/
 * 
 * If you need some parts of this code, please use PDPCLib instead.
 * As it's realeased to the public domain, no license restriction will apply.
 */

#include "string.h"

/**
 * Searches s for next token delimited by any character from ct. Non-NULL s
 * indicates the first call of a sequence. If a token is found, it is
 * NUL-terminated and returned, otherwise NULL is returned. ct need not be
 * identical for each call in a sequence.
 */
char * strtok( char * s, const char * t )
{
    static char * old;
    char * p;
    size_t length;
    size_t remain;
    
    old = NULL;
    
    if( s != NULL ) {
        
        old = s;
    }
    
    if( old == NULL ) {
        
        return NULL;
    }
    
    p      = old;
    length = strspn( p, t );
    remain = strlen( p );
    
    if( remain <= length ) {
        
        old = NULL;
        
        return NULL;
    }
    
    p     += length;
    length = strcspn( p, t );
    remain = strlen( p );
    
    if( remain <= length ) {
        
        old = NULL;
        
        return p;
    }
    
    *( p + length ) = '\0';
    old             = p + length + 1;
    
    return p;
}
