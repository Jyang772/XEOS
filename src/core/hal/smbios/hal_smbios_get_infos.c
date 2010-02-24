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

extern bool             __hal_smbios_infos_processed;
extern hal_smbios_infos __hal_smbios_infos;

void __hal_smbios_process_struct_bios_infos( uint8_t * mem );
void __hal_smbios_process_struct_system_infos( uint8_t * mem );
void __hal_smbios_process_struct_system_enclosure( uint8_t * mem );
void __hal_smbios_process_struct_processor_infos( uint8_t * mem );
void __hal_smbios_process_struct_cache_infos( uint8_t * mem );
void __hal_smbios_process_struct_system_slots( uint8_t * mem );
void __hal_smbios_process_struct_physical_memory_array( uint8_t * mem );
void __hal_smbios_process_struct_memory_device( uint8_t * mem );
void __hal_smbios_process_struct_memory_mapped_address( uint8_t * mem );
void __hal_smbios_process_struct_system_boot_infos( uint8_t * mem );

hal_smbios_infos * hal_smbios_get_infos( hal_smbios_table_entry * entry )
{
    uint8_t      type;
    uint8_t      length;
    uint16_t     handle;
    uint8_t    * mem;
    unsigned int i;
    
    if( __hal_smbios_infos_processed == true ) {
        
        return &__hal_smbios_infos;
    }
    
    __hal_smbios_infos_processed = true;
    
    mem = ( uint8_t * )entry->structure_table_address;
    
    for( i = 0; i < entry->structures_count; i++ ) {
        
        type   = ( uint8_t )*( mem );
        length = ( uint8_t )*( mem + 1 );
        handle = ( uint16_t )*( mem + 2 );
        
        switch( type ) {
            
            case HAL_SMBIOS_STRUCT_BIOS_INFORMATION:
                
                __hal_smbios_process_struct_bios_infos( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_SYSTEM_INFORMATION:
                
                __hal_smbios_process_struct_system_infos( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_SYSTEM_ENCLOSURE:
                
                __hal_smbios_process_struct_system_enclosure( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_PROCESSOR_INFORMATION:
                
                __hal_smbios_process_struct_processor_infos( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_CACHE_INFORMATION:
                
                __hal_smbios_process_struct_cache_infos( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_SYSTEM_SLOTS:
                
                __hal_smbios_process_struct_system_slots( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_PHYSICAL_MEMORY_ARRAY:
                
                __hal_smbios_process_struct_physical_memory_array( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_MEMORY_DEVICE:
                
                __hal_smbios_process_struct_memory_device( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_MEMORY_ARRAY_MAPPED_ADDRESS:
                
                __hal_smbios_process_struct_memory_mapped_address( mem );
                break;
                
            case HAL_SMBIOS_STRUCT_SYSTEM_BOOT_INFORMATION:
                
                __hal_smbios_process_struct_system_boot_infos( mem );
                break;
                
            default:
                
                break;
        }
        
        mem += length;
        
        while( 1 ) {
            
            if( *( mem ) == '\0' && *( mem + 1 ) == '\0' ) {
                
                mem += 2;
                break;
            }
            
            mem++;
        }
    }
    
    return &__hal_smbios_infos;
}
