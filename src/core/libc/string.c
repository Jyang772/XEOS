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
 * Copies ct to s including terminating NUL and returns s.
 */
char * strcpy( char * s, const char * ct )
{
    char * p;
    
    p = s;
    
    while( ( *( p )++ = *( ct )++ ) != '\0' );
    
    return s;
}

/**
 * Copies at most n characters of ct to s. Pads with NUL characters if ct is of
 * length less than n. Note that this may leave s without NUL-termination.
 * Return s.
 */
char * strncpy( char * s, const char * ct, size_t n )
{
    char * p;
    size_t x;
    
    p = s;
    x = 0;
    
    for( x = 0; x < n; x++ ) {
        
        *( p ) = *( ct );
        
        if( *( ct ) == '\0' ) {
            
            break;
        }
        
        p++;
        ct++;
    }
    
    for( ; x < n; x++ ) {
        
        *( p )++ = '\0';
    }
    
    return s;
}

/**
 * Concatenate ct to s and return s.
 */
char * strcat( char * s, const char * ct )
{
    char * p;
    
    p = s;
    
    while( *( p ) != '\0' ) {
        
        p++;
    }
    
    while( ( *( p ) = *( ct ) ) != '\0' ) {
        
        p++;
        ct++;
    }
    
    return s;
}

/**
 * Concatenate at most n characters of ct to s. NUL-terminates s and return it.
 */
char * strncat( char * s, const char * ct, size_t n )
{
    char * p;
    size_t x;
    
    p = s;
    x = 0;
    
    while( *( p ) != '\0' ) {
        
        p++;
    }
    
    while( ( *( ct ) != '\0' ) && ( x < n ) ) {
        
        *( p ) = *( ct );
        
        p++;
        ct++;
        x++;
    }
    
    *( p ) = '\0';
    
    return s;
}

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

/**
 * Compares at most (the first) n characters of cs and ct, returning negative
 * value if cs < ct, zero if cs == ct, positive value if cs > ct.
 */
int strncmp( const char * cs, const char * ct, size_t n )
{
    const unsigned char * p1;
    const unsigned char * p2;
    size_t x;
    
    p1 = ( const unsigned char * )cs;
    p2 = ( const unsigned char * )ct;
    x  = 0;
    
    while( x < n ) {
        
        if( p1[ x ] < p2[ x ] ) {
            
            return -1;
            
        } else if( p1[ x ] > p2[ x ] ) {
            
            return 1;
            
        } else if( p1[ x ] == '\0' ) {
            
            return 0;
        }
        
        x++;
    }
    
    return 0;
}

/**
 * Compares cs with ct according to locale, returning negative value if c s< ct,
 * zero if cs == ct, positive value if cs > ct.
 */
int strcoll( const char * cs, const char * ct )
{
    return strcmp( cs, ct );
}

/**
 * Returns pointer to first occurrence of c in cs, or NULL if not found.
 */
char * strchr( const char * cs, int c )
{
    while( *( cs ) != '\0' ) {
        
        if( *( cs ) == ( char )c ) {
            
            return ( char * )cs;
        }
        
        cs++;
    }
    
    if( c == '\0' ) {
        
        return ( char * )cs;
    }
    
    return NULL;
}

/**
 * Returns pointer to last occurrence of c in cs, or NULL if not found.
 */
char * strrchr( const char * cs, int c )
{
    const char * p;
    
    p = cs + strlen( cs );
    
    while( p >= cs ) {
        
        if( *( p ) == ( char )c ) {
            
            return ( char * )p;
        }
        
        p--;
    }
    
    return NULL;
}

/**
 * Returns length of prefix of cs which consists of characters which are in ct.
 */
size_t strspn( const char * cs, const char * ct )
{
    const char * p1;
    const char * p2;
    
    p1 = cs;
    
    while( *( p1 ) != '\0' ) {
        
        p2 = ct;
        
        while( *( p2 ) != '\0' ) {
            
            if( *( p1 ) == *( p2 ) ) {
                
                break;
            }
            
            p2++;
        }
        
        if( *( p2 ) == '\0' ) {
            
            return ( size_t )( p1 - cs );
        }
        
        p1++;
    }
    
    return ( size_t )( p1 - cs );
}

/**
 * Returns length of prefix of cs which consists of characters which are not
 * in ct.
 */
size_t strcspn( const char * cs, const char * ct )
{
    const char * p1;
    const char * p2;
    
    p1 = cs;
    
    while( *( p1 ) != '\0' ) {
        
        p2 = ct;
        
        while( *( p2 ) != '\0' ) {
            
            if( *( p1 ) == *( p2 ) ) {
                
                return ( size_t )( p1 - cs );
            }
            
            p2++;
        }
        
        p1++;
    }
    
    return ( size_t )( p1 - cs );
}

/**
 * Returns pointer to first occurrence in cs of any character of ct, or NULL
 * if none is found.
 */
char * strpbrk( const char * cs, const char * ct )
{
    const char * p1;
    const char * p2;
    
    p1 = cs;
    
    while( *( p1 ) != '\0') {
        
        p2 = ct;
        
        while( *( p2 ) != '\0' ) {
            
            if( *( p1 ) == *( p2 ) ) {
                
                return ( char * )p1;
            }
            
            p2++;
        }
        
        p1++;
    }
    
    return NULL;
}

/**
 * Returns pointer to first occurrence of ct within cs, or NULL if none is
 * found.
 */
char * strstr( const char * cs, const char * ct )
{
    const char * p1;
    const char * p2;
    const char * p3;
    
    p1 = cs;
    p3 = ct;
    
    while( *( p1 ) ) {
        
        if( *( p1 ) == *( ct ) ) {
            
            p2 = p1;
            p3 = ct;
            
            while( ( *( p3 ) != '\0' ) && ( *( p2 ) == *( p3 ) ) ) {
                
                p2++;
                p3++;
            }
            
            if( *( p3 ) == '\0' ) {
                
                return ( char * )p1;
            }
        }
        
        p1++;
    }
    
    return NULL;
}

/**
 * Returns length of cs.
 */
size_t strlen( const char * cs )
{
    const char * p;
    
    p = cs;
    
    while( *( p ) != '\0' ) {
        
        p++;
    }
    
    return ( size_t )( p - cs );
}

/**
 * Returns pointer to implementation-defined message string corresponding
 * with error n.
 */
char * strerror( int n )
{
    if( n == 0 ) {
        
        return "No error occured.\n";
        
    } else {
        
        /* Needs implementation */
        
        return "An unknown error occured. No further information can be provided.\n";
    }
}

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

/**
 * Stores in s no more than n characters (including terminating NUL) of a
 * string produced from ct according to a locale-specific transformation.
 * Returns length of entire transformed string.
 */
size_t strxfrm( char * s, const char * ct, size_t n )
{
    size_t length;
    
    length = strlen( ct );
    
    if( length < n ) {
        
        memcpy( s, ct, length );
        
        s[ length ] = '\0';
    }
    
    return length;
}

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

/**
 * Copies n characters from ct to s and returns s. s will not be corrupted if
 * objects overlap.
 */
void * memmove( void * s, const void * ct, size_t n )
{
    char * p;
    const char * ct2;
    size_t x;
    
    p   = s;
    ct2 = ct;
    
    if( p <= ct2 ) {
        
        for( x = 0; x < n; x++ ) {
            
            *( p ) = *( ct2 );
            
            p++;
            ct2++;
        }
        
    } else {
        
        if( n != 0 ) {
            
            for( x = n - 1; x > 0; x-- ) {
                
                *( p + x ) = *( ct2 + x );
            }
            
            *( p + x ) = *( ct2 + x );
        }
    }
    
    return s;
}

/**
 * Compares at most (the first) n characters of cs and ct, returning negative
 * value if cs < ct, zero if cs == ct, positive value if cs > ct.
 */
int memcmp( const void * cs, const void * ct, size_t n )
{
    const unsigned char * p1;
    const unsigned char * p2;
    size_t x;
    
    p1 = ( const unsigned char * )cs;
    p2 = ( const unsigned char * )ct;
    x  = 0;
    
    while( x < n ) {
        
        if( p1[ x ] < p2[ x ]) {
            
            return -1;
            
        } else if( p1[ x ] > p2[ x ] ) {
            
            return 1;
        }
        
        x++;
    }
    
    return 0;
}

/**
 * Returns pointer to first occurrence of c in first n characters of cs, or
 * NULL if not found.
 */
void * memchr( const void * cs, int c, size_t n )
{
    const unsigned char * p;
    size_t x;
    
    p = ( const unsigned char * )cs;
    x = 0;
    
    while( x < n ) {
        
        if( *( p ) == ( unsigned char )c ) {
            
            return ( void * )p;
        }
        
        p++;
        x++;
    }
    
    return NULL;
}

/**
 * Replaces each of the first n characters of s by c and returns s.
 */
void * memset( void * s, int c, size_t n )
{
    size_t x;
    
    x = 0;
    
    for( x = 0; x < n; x++ ) {
        
        *( ( char * )s + x ) = ( unsigned char )c;
    }
    
    return s;
}
