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

#include <kernel/private/video.h>

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
hal_smbios_bios_characteristics  __hal_smbios_bios_characteristics;
hal_smbios_infos                 __hal_smbios_infos = { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };

uint8_t * __hal_smbios_find_struct( hal_smbios_table_entry * entry, uint8_t type );
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

uint8_t * __hal_smbios_find_struct( hal_smbios_table_entry * entry, uint8_t type )
{
    uint8_t    * mem;
    uint8_t      s_type;
    uint8_t      s_length;
    uint16_t     s_handle;
    unsigned int i;
    
    mem = ( uint8_t * )entry->structure_table_address;
    
    for( i = 0; i < entry->structures_count; i++ ) {
        
        s_type   = ( uint8_t )*( mem );
        s_length = ( uint8_t )*( mem + 1 );
        s_handle = ( uint16_t )*( mem + 2 );
        
        if( s_type == type ) {
            
            return mem;
        }
        
        mem += s_length;
        
        while( 1 ) {
            
            if( *( mem ) == '\0' && *( mem + 1 ) == '\0' ) {
                
                mem += 2;
                break;
            }
            
            mem++;
        }
    }
    
    return NULL;
}

void __hal_smbios_process_struct_bios_infos( uint8_t * mem )
{
    uintptr_t start_str1;
    uintptr_t start_str2;
    uintptr_t start_str3;
    uint32_t  characteristics;
    char      characteristics_ext;
    
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_bios_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_bios_infos.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_bios_infos.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_bios_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_bios_infos.address                            = ( uintptr_t )*( mem + 0x06 );
    __hal_smbios_bios_infos.rom_size                           = ( unsigned int )*( mem + 0x09 );
    __hal_smbios_bios_infos.release_major                      = ( unsigned int )*( mem + 0x14 );
    __hal_smbios_bios_infos.release_minor                      = ( unsigned int )*( mem + 0x15 );
    __hal_smbios_bios_infos.embedded_controller_firmware_major = ( unsigned int )*( mem + 0x16 );
    __hal_smbios_bios_infos.embedded_controller_firmware_minor = ( unsigned int )*( mem + 0x17 );
    
    characteristics     = ( uint16_t )*( mem + 0x0A );
    characteristics_ext = ( char )*( mem + 0x12 );
    
    __hal_smbios_bios_characteristics.characteristics              = ( characteristics & 0x00000008 ) ? true : false;
    __hal_smbios_bios_characteristics.isa                          = ( characteristics & 0x00000010 ) ? true : false;
    __hal_smbios_bios_characteristics.mca                          = ( characteristics & 0x00000020 ) ? true : false;
    __hal_smbios_bios_characteristics.eisa                         = ( characteristics & 0x00000040 ) ? true : false;
    __hal_smbios_bios_characteristics.pci                          = ( characteristics & 0x00000080 ) ? true : false;
    __hal_smbios_bios_characteristics.pcmcia                       = ( characteristics & 0x00000100 ) ? true : false;
    __hal_smbios_bios_characteristics.plug_and_play                = ( characteristics & 0x00000200 ) ? true : false;
    __hal_smbios_bios_characteristics.apm                          = ( characteristics & 0x00000400 ) ? true : false;
    __hal_smbios_bios_characteristics.upgradeable                  = ( characteristics & 0x00000800 ) ? true : false;
    __hal_smbios_bios_characteristics.shadowing                    = ( characteristics & 0x00001000 ) ? true : false;
    __hal_smbios_bios_characteristics.vl_vesa                      = ( characteristics & 0x00002000 ) ? true : false;
    __hal_smbios_bios_characteristics.escd                         = ( characteristics & 0x00004000 ) ? true : false;
    __hal_smbios_bios_characteristics.boot_cd                      = ( characteristics & 0x00008000 ) ? true : false;
    __hal_smbios_bios_characteristics.boot_select                  = ( characteristics & 0x00010000 ) ? true : false;
    __hal_smbios_bios_characteristics.rom_socketed                 = ( characteristics & 0x00020000 ) ? true : false;
    __hal_smbios_bios_characteristics.boot_pcmcia                  = ( characteristics & 0x00040000 ) ? true : false;
    __hal_smbios_bios_characteristics.edd                          = ( characteristics & 0x00080000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_nec9800_japan = ( characteristics & 0x00100000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_toshiba_japan = ( characteristics & 0x00200000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_525_360kb     = ( characteristics & 0x00400000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_525_1200kb    = ( characteristics & 0x00800000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_35_720kb      = ( characteristics & 0x01000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_floppy_35_2880kb     = ( characteristics & 0x02000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_print_screen         = ( characteristics & 0x04000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_keyboard             = ( characteristics & 0x08000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_serial               = ( characteristics & 0x10000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_printer              = ( characteristics & 0x20000000 ) ? true : false;
    __hal_smbios_bios_characteristics.service_video_cga_mono       = ( characteristics & 0x40000000 ) ? true : false;
    __hal_smbios_bios_characteristics.nec_pc98                     = ( characteristics & 0x80000000 ) ? true : false;
    
    __hal_smbios_bios_characteristics.acpi                 = ( characteristics_ext & 0x01 ) ? true : false;
    __hal_smbios_bios_characteristics.usb_legacy           = ( characteristics_ext & 0x02 ) ? true : false;
    __hal_smbios_bios_characteristics.agp                  = ( characteristics_ext & 0x04 ) ? true : false;
    __hal_smbios_bios_characteristics.i20                  = ( characteristics_ext & 0x08 ) ? true : false;
    __hal_smbios_bios_characteristics.ls120                = ( characteristics_ext & 0x10 ) ? true : false;
    __hal_smbios_bios_characteristics.boot_atapi_zip_drive = ( characteristics_ext & 0x20 ) ? true : false;
    __hal_smbios_bios_characteristics.boot_1394            = ( characteristics_ext & 0x40 ) ? true : false;
    __hal_smbios_bios_characteristics.smart_battery        = ( characteristics_ext & 0x80 ) ? true : false;
    
    start_str1 = ( uintptr_t )( mem + 0x18 );
    start_str2 = start_str1 + strlen( ( char * )( start_str1 ) ) + 1;
    start_str3 = start_str2 + strlen( ( char * )( start_str2 ) ) + 1;
    
    __hal_smbios_bios_infos.vendor  = ( char * )( ( ( char )*( mem + 0x04 ) == 1 ) ? start_str1 : ( ( ( char )*( mem + 0x04 ) == 2 ) ? start_str2 : start_str3 ) );
    __hal_smbios_bios_infos.version = ( char * )( ( ( char )*( mem + 0x05 ) == 1 ) ? start_str1 : ( ( ( char )*( mem + 0x05 ) == 2 ) ? start_str2 : start_str3 ) );
    __hal_smbios_bios_infos.date    = ( char * )( ( ( char )*( mem + 0x08 ) == 1 ) ? start_str1 : ( ( ( char )*( mem + 0x08 ) == 2 ) ? start_str2 : start_str3 ) );
    
    __hal_smbios_bios_infos.characteristics = &__hal_smbios_bios_characteristics;
    __hal_smbios_infos.bios_infos           = &__hal_smbios_bios_infos;
}

void __hal_smbios_process_struct_system_infos( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_system_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_infos = &__hal_smbios_system_infos;
}

void __hal_smbios_process_struct_system_enclosure( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_system_enclosure.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_enclosure.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_enclosure.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_enclosure.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_enclosure = &__hal_smbios_system_enclosure;
}

void __hal_smbios_process_struct_processor_infos( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_processor_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_processor_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_processor_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_processor_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.processor_infos = &__hal_smbios_processor_infos;
}

void __hal_smbios_process_struct_cache_infos( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_cache_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_cache_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_cache_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_cache_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.cache_infos = &__hal_smbios_cache_infos;
}

void __hal_smbios_process_struct_system_slots( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_system_slots.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_slots.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_slots.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_slots.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_slots = &__hal_smbios_system_slots;
}

void __hal_smbios_process_struct_physical_memory_array( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_physical_memory_array.header.type    = ( uint8_t )*( mem );
    __hal_smbios_physical_memory_array.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_physical_memory_array.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_physical_memory_array.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.physical_memory_array = &__hal_smbios_physical_memory_array;
}

void __hal_smbios_process_struct_memory_device( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_memory_device.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_device.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_memory_device.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_memory_device.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_device = &__hal_smbios_memory_device;
}

void __hal_smbios_process_struct_memory_mapped_address( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_memory_mapped_address.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_mapped_address.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_memory_mapped_address.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_memory_mapped_address.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_mapped_address = &__hal_smbios_memory_mapped_address;
}

void __hal_smbios_process_struct_system_boot_infos( uint8_t * mem )
{
    if( mem == NULL ) {
        
        return;
    }
    
    __hal_smbios_system_boot_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_boot_infos.header.length  = ( uint8_t )*( mem + 1 );
    __hal_smbios_system_boot_infos.header.handle  = ( uint8_t )*( mem + 2 );
    __hal_smbios_system_boot_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_boot_infos = &__hal_smbios_system_boot_infos;
}

