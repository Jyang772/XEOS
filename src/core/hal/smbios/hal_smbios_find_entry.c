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

#include <string.h>
#include <stdbool.h>
#include "smbios.h"

hal_smbios_table_entry * hal_smbios_find_entry( void )
{
    uintptr_t                mem;
    hal_smbios_table_entry * entry;
    
    for( mem = HAL_SMBIOS_MEM_START; mem < HAL_SMBIOS_MEM_END; mem += 16 ) {
        
        if( memcmp(
                ( const void * )mem,
                HAL_SMBIOS_SIGNATURE,
                strlen( HAL_SMBIOS_SIGNATURE )
            ) == 0
        ) {
            
            entry = ( hal_smbios_table_entry * )mem;
            
            if( memcmp(
                    ( const void * )entry->intermediate_anchor,
                    HAL_SMBIOS_DMI_SIGNATURE,
                    strlen( HAL_SMBIOS_DMI_SIGNATURE )
                ) != 0
            ) {
                
                continue;
            }
            
            if(    hal_smbios_verifiy_checksum( entry )              == false
                || hal_smbios_verifiy_intermediate_checksum( entry ) == false
            ) {
                
                continue;
            }
            
            return entry;
        }
    }
    
    return NULL;
}
