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
#include <stdbool.h>
#include <string.h>
#include "smbios.h"

hal_smbios_bios_infos            __hal_smbios_bios_infos;
hal_smbios_system_infos          __hal_smbios_system_infos;
hal_smbios_system_enclosure      __hal_smbios_system_enclosure;
hal_smbios_processor_infos       __hal_smbios_processor_infos;
hal_smbios_cache_infos           __hal_smbios_cache_infos;
hal_smbios_system_slots          __hal_smbios_system_slots;
hal_smbios_physical_memory_array __hal_smbios_physical_memory_array;
hal_smbios_memory_device         __hal_smbios_memory_device;
hal_smbios_memory_mapped_address __hal_smbios_memory_mapped_address;
hal_smbios_system_boot_infos     __hal_smbios_system_boot_infos;
bool                             __hal_smbios_infos_processed       = false;
hal_smbios_infos                 __hal_smbios_infos = {
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
};

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

void __hal_smbios_process_struct_bios_infos( uint8_t * mem )
{
    __hal_smbios_bios_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_bios_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_bios_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_bios_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.bios_infos = &__hal_smbios_bios_infos;
}

void __hal_smbios_process_struct_system_infos( uint8_t * mem )
{
    __hal_smbios_system_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_infos = &__hal_smbios_system_infos;
}

void __hal_smbios_process_struct_system_enclosure( uint8_t * mem )
{
    __hal_smbios_system_enclosure.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_enclosure.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_enclosure.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_enclosure.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_enclosure = &__hal_smbios_system_enclosure;
}

void __hal_smbios_process_struct_processor_infos( uint8_t * mem )
{
    __hal_smbios_processor_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_processor_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_processor_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_processor_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.processor_infos = &__hal_smbios_processor_infos;
}

void __hal_smbios_process_struct_cache_infos( uint8_t * mem )
{
    __hal_smbios_cache_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_cache_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_cache_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_cache_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.cache_infos = &__hal_smbios_cache_infos;
}

void __hal_smbios_process_struct_system_slots( uint8_t * mem )
{
    __hal_smbios_system_slots.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_slots.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_slots.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_slots.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_slots = &__hal_smbios_system_slots;
}

void __hal_smbios_process_struct_physical_memory_array( uint8_t * mem )
{
    __hal_smbios_physical_memory_array.header.type    = ( uint8_t )*( mem );
    __hal_smbios_physical_memory_array.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_physical_memory_array.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_physical_memory_array.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.physical_memory_array = &__hal_smbios_physical_memory_array;
}

void __hal_smbios_process_struct_memory_device( uint8_t * mem )
{
    __hal_smbios_memory_device.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_device.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_memory_device.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_memory_device.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_device = &__hal_smbios_memory_device;
}

void __hal_smbios_process_struct_memory_mapped_address( uint8_t * mem )
{
    __hal_smbios_memory_mapped_address.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_mapped_address.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_memory_mapped_address.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_memory_mapped_address.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_mapped_address = &__hal_smbios_memory_mapped_address;
}

void __hal_smbios_process_struct_system_boot_infos( uint8_t * mem )
{
    __hal_smbios_system_boot_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_boot_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_boot_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_boot_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_boot_infos = &__hal_smbios_system_boot_infos;
}

