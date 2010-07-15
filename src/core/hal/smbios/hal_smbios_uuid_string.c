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

#include <stdint.h>
#include <string.h>
#include "smbios.h"

static char __hal_smbios_uuid_string_str[ 37 ];

char * hal_smbios_uuid_string( hal_smbios_uuid * uuid )
{
    unsigned int i;
    
    __hal_smbios_uuid_string_str[ 0 ]  = ( char )( ( ( char * )uuid )[ 0 ] );
    __hal_smbios_uuid_string_str[ 1 ]  = ( char )( ( ( char * )uuid )[ 1 ] );
    __hal_smbios_uuid_string_str[ 2 ]  = ( char )( ( ( char * )uuid )[ 2 ] );
    __hal_smbios_uuid_string_str[ 3 ]  = ( char )( ( ( char * )uuid )[ 3 ] );
    __hal_smbios_uuid_string_str[ 4 ]  = ( char )( ( ( char * )uuid )[ 4 ] );
    __hal_smbios_uuid_string_str[ 5 ]  = ( char )( ( ( char * )uuid )[ 5 ] );
    __hal_smbios_uuid_string_str[ 6 ]  = ( char )( ( ( char * )uuid )[ 6 ] );
    __hal_smbios_uuid_string_str[ 7 ]  = ( char )( ( ( char * )uuid )[ 7 ] );
    __hal_smbios_uuid_string_str[ 8 ]  = '-';
    __hal_smbios_uuid_string_str[ 9 ]  = ( char )( ( ( char * )uuid )[ 8 ] );
    __hal_smbios_uuid_string_str[ 10 ] = ( char )( ( ( char * )uuid )[ 9 ] );
    __hal_smbios_uuid_string_str[ 11 ] = ( char )( ( ( char * )uuid )[ 10 ] );
    __hal_smbios_uuid_string_str[ 12 ] = ( char )( ( ( char * )uuid )[ 11 ] );
    __hal_smbios_uuid_string_str[ 13 ]  = '-';
    __hal_smbios_uuid_string_str[ 14 ] = ( char )( ( ( char * )uuid )[ 12 ] );
    __hal_smbios_uuid_string_str[ 15 ] = ( char )( ( ( char * )uuid )[ 13 ] );
    __hal_smbios_uuid_string_str[ 16 ] = ( char )( ( ( char * )uuid )[ 14 ] );
    __hal_smbios_uuid_string_str[ 17 ] = ( char )( ( ( char * )uuid )[ 15 ] );
    __hal_smbios_uuid_string_str[ 18 ]  = '-';
    __hal_smbios_uuid_string_str[ 19 ] = ( char )( ( ( char * )uuid )[ 16 ] );
    __hal_smbios_uuid_string_str[ 20 ] = ( char )( ( ( char * )uuid )[ 17 ] );
    __hal_smbios_uuid_string_str[ 21 ] = ( char )( ( ( char * )uuid )[ 18 ] );
    __hal_smbios_uuid_string_str[ 22 ] = ( char )( ( ( char * )uuid )[ 19 ] );
    __hal_smbios_uuid_string_str[ 23 ]  = '-';
    __hal_smbios_uuid_string_str[ 24 ] = ( char )( ( ( char * )uuid )[ 20 ] );
    __hal_smbios_uuid_string_str[ 25 ] = ( char )( ( ( char * )uuid )[ 21 ] );
    __hal_smbios_uuid_string_str[ 26 ] = ( char )( ( ( char * )uuid )[ 22 ] );
    __hal_smbios_uuid_string_str[ 27 ] = ( char )( ( ( char * )uuid )[ 23 ] );
    __hal_smbios_uuid_string_str[ 28 ] = ( char )( ( ( char * )uuid )[ 24 ] );
    __hal_smbios_uuid_string_str[ 29 ] = ( char )( ( ( char * )uuid )[ 25 ] );
    __hal_smbios_uuid_string_str[ 30 ] = ( char )( ( ( char * )uuid )[ 26 ] );
    __hal_smbios_uuid_string_str[ 31 ] = ( char )( ( ( char * )uuid )[ 27 ] );
    __hal_smbios_uuid_string_str[ 32 ] = ( char )( ( ( char * )uuid )[ 28 ] );
    __hal_smbios_uuid_string_str[ 33 ] = ( char )( ( ( char * )uuid )[ 29 ] );
    __hal_smbios_uuid_string_str[ 34 ] = ( char )( ( ( char * )uuid )[ 30 ] );
    __hal_smbios_uuid_string_str[ 35 ] = ( char )( ( ( char * )uuid )[ 31 ] );
    __hal_smbios_uuid_string_str[ 36 ] = '\0';
    
    for( i = 0; i < 37; i++ ) {
        
        if( __hal_smbios_uuid_string_str[ i ] == '-' ) {
            
            continue;
        }
        
        if( __hal_smbios_uuid_string_str[ i ] < 9 ) {
            
            __hal_smbios_uuid_string_str[ i ] = __hal_smbios_uuid_string_str[ i ] + 48;
            
        } else if( __hal_smbios_uuid_string_str[ i ] < 16 ) {
            
            __hal_smbios_uuid_string_str[ i ] = __hal_smbios_uuid_string_str[ i ] + 55;
            
        } else {
            
            __hal_smbios_uuid_string_str[ i ] = '.';
        }
    }
    
    return ( char * )__hal_smbios_uuid_string_str;
}


/*

    uint32_t time_low;
    uint16_t time_mid;
    uint16_t time_hi_and_version;
    uint8_t clock_seq_hi_and_reserved;
    uint8_t clock_seq_low;
    uint8_t node[ 6 ];

*/
