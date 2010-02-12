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
 * Compares cs with ct, returning negative value if cs < ct, zero if cs == ct,
 * positive value if cs > ct.
 */
int strcmp( const char * cs, const char * ct )
{
    const unsigned char * p1;
    const unsigned char * p2;
    
    p1 = ( const unsigned char * )cs;
    p2 = ( const unsigned char * )ct;
    
    while( *( p1 ) != '\0' ) {
        
        if( *( p1 ) < *( p2 ) ) {
            
            return -1;
            
        } else if( *( p1 ) > *( p2 ) ) {
            
            return 1;
        }
        
        p1++;
        p2++;
    }
    
    if( *( p2 ) == '\0' ) {
        
        return 0;
    }
    
    return -1;
}
