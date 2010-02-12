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
 * Copies n characters from ct to s and returns s. s may be corrupted
 * if objects overlap.
 */
void * memcpy( void * s, const void * ct, size_t n )
{
    register unsigned int * p;
    register unsigned int * ct2;
    register unsigned int * end;
    
    p   = ( unsigned int * )s;
    ct2 = ( unsigned int * )ct;
    end = ( unsigned int * )( ( char * )p + ( n & ~0x03 ) );
    
    while( p != end ) {
        
        *( p )++ = *( ct2 )++;
    }
    
    switch( n & 0x03 ) {
        
        case 0:
            
            break;
            
        case 1:
            
            *( ( char * )p ) = *( ( char * )ct2 );
            
            break;
            
        case 2:
            
            *( ( char * )p ) = *( ( char * )ct2 );
            p                = ( unsigned int * )( ( char * )p + 1 );
            ct2              = ( unsigned int * )( ( char * )ct2 + 1 );
            *( ( char * )p ) = *( ( char * )ct2 );
            
            break;
            
        case 3:
            
            *( ( char * )p ) = *( ( char * )ct2 );
            p                = ( unsigned int * )( ( char * )p + 1 );
            ct2              = ( unsigned int * )( ( char * )ct2 + 1 );
            *( ( char * )p ) = *( ( char * )ct2 );
            p                = ( unsigned int * )( ( char * )p + 1 );
            ct2              = ( unsigned int * )( ( char * )ct2 + 1 );
            *( ( char * )p ) = *( ( char * )ct2 );
            
            break;
    }
    
    return s;
}
