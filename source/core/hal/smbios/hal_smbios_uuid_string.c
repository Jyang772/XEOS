/*******************************************************************************
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
    
    for( i = 0; i < 37; i++ )
    {
        if( __hal_smbios_uuid_string_str[ i ] == '-' )
        {
            continue;
        }
        
        if( __hal_smbios_uuid_string_str[ i ] < 9 )
        {
            __hal_smbios_uuid_string_str[ i ] = __hal_smbios_uuid_string_str[ i ] + 48;
        }
        else if( __hal_smbios_uuid_string_str[ i ] < 16 )
        {
            __hal_smbios_uuid_string_str[ i ] = __hal_smbios_uuid_string_str[ i ] + 55;
        }
        else
        {
            __hal_smbios_uuid_string_str[ i ] = '.';
        }
    }
    
    return ( char * )__hal_smbios_uuid_string_str;
}
