/*******************************************************************************
 * Copyright (c) <YEAR>, <OWNER>
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
char * __hal_smbios_get_string( uint8_t * mem, uint8_t str_num );
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
    
    for( i = 0; i < entry->structures_count; i++ )
    {
        s_type   = ( uint8_t )*( mem );
        s_length = ( uint8_t )*( mem + 1 );
        s_handle = ( uint16_t )*( mem + 2 );
        
        if( s_type == type )
        {
            return mem;
        }
        
        mem += s_length;
        
        while( 1 )
        {
            if( *( mem ) == '\0' && *( mem + 1 ) == '\0' )
            {
                mem += 2;
                break;
            }
            
            mem++;
        }
    }
    
    return NULL;
}

char * __hal_smbios_get_string( uint8_t * mem, uint8_t str_num )
{
    uint8_t i;
    
    if( str_num == 0 )
    {
        return NULL;
    }
    
    for( i = 0; i < str_num - 1; i++ )
    {
        while( *( mem ) != '\0' )
        {
            mem++;
        }
        
        mem++;
    }
    
    if( *( mem ) == '\0' )
    {
        return NULL;
    }
    
    return ( char * )mem;
}

void __hal_smbios_process_struct_bios_infos( uint8_t * mem )
{
    uint32_t characteristics;
    uint8_t  characteristics_ext;
    
    if( mem == NULL )
    {
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
    characteristics_ext = ( uint8_t )*( mem + 0x12 );
    
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
    
    __hal_smbios_bios_infos.vendor  = __hal_smbios_get_string( mem + __hal_smbios_bios_infos.header.length, *( mem + 0x04 ) );
    __hal_smbios_bios_infos.version = __hal_smbios_get_string( mem + __hal_smbios_bios_infos.header.length, *( mem + 0x05 ) );
    __hal_smbios_bios_infos.date    = __hal_smbios_get_string( mem + __hal_smbios_bios_infos.header.length, *( mem + 0x08 ) );
    
    __hal_smbios_bios_infos.characteristics = &__hal_smbios_bios_characteristics;
    __hal_smbios_infos.bios_infos           = &__hal_smbios_bios_infos;
}

void __hal_smbios_process_struct_system_infos( uint8_t * mem )
{
    hal_smbios_uuid * uuid;
    
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_system_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_infos.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_system_infos.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_system_infos.header.address = ( uintptr_t )mem;
    
    uuid = &( __hal_smbios_system_infos.uuid );
    
    uuid->time_low            = ( uint32_t )0;
    uuid->time_mid            = ( uint16_t )0;
    uuid->time_hi_and_version = ( uint16_t )0;
    
    uuid->time_low |= ( ( uint8_t )*( mem + 0x08 ) ) << 24;
    uuid->time_low |= ( ( uint8_t )*( mem + 0x09 ) ) << 16;
    uuid->time_low |= ( ( uint8_t )*( mem + 0x0A ) ) << 8;
    uuid->time_low |= ( ( uint8_t )*( mem + 0x0B ) );
    
    uuid->time_mid |= ( ( uint8_t )*( mem + 0x0D ) ) << 8;
    uuid->time_mid |= ( ( uint8_t )*( mem + 0x0C ) );
    
    uuid->time_hi_and_version |= ( ( uint8_t )*( mem + 0x0F ) ) << 8;
    uuid->time_hi_and_version |= ( ( uint8_t )*( mem + 0x0E ) );
    
    uuid->clock_seq_hi_and_reserved = ( uint8_t )*( mem + 0x10 );
    uuid->clock_seq_low             = ( uint8_t )*( mem + 0x11 );
    uuid->node[ 0 ]                 = ( uint8_t )*( mem + 0x12 );
    uuid->node[ 1 ]                 = ( uint8_t )*( mem + 0x13 );
    uuid->node[ 2 ]                 = ( uint8_t )*( mem + 0x14 );
    uuid->node[ 3 ]                 = ( uint8_t )*( mem + 0x15 );
    uuid->node[ 4 ]                 = ( uint8_t )*( mem + 0x16 );
    uuid->node[ 5 ]                 = ( uint8_t )*( mem + 0x17 );
    
    
    /*
    The UUID
    00 11 22 33 - 44 55 - 66 77
    33 22 11 00 - 55 44 - 77 66
    */
    
    __hal_smbios_system_infos.manufacturer  = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x04 ) );
    __hal_smbios_system_infos.product_name  = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x05 ) );
    __hal_smbios_system_infos.version       = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x06 ) );
    __hal_smbios_system_infos.serial_number = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x07 ) );
    __hal_smbios_system_infos.sku_number    = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x19 ) );
    __hal_smbios_system_infos.family        = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x1A ) );
    
    __hal_smbios_infos.system_infos = &__hal_smbios_system_infos;
}

void __hal_smbios_process_struct_system_enclosure( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_system_enclosure.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_enclosure.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_system_enclosure.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_system_enclosure.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_enclosure = &__hal_smbios_system_enclosure;
}

void __hal_smbios_process_struct_processor_infos( uint8_t * mem )
{
    uint8_t voltage;
    
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_processor_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_processor_infos.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_processor_infos.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_processor_infos.header.address = ( uintptr_t )mem;
    
    voltage = ( uint8_t )*( mem + 0x11 );
    
    if( voltage & 0x80 )
    {
        if( voltage & 0x01 )
        {
            __hal_smbios_processor_infos.voltage = ( float )5;
        }
        else if( voltage & 0x02 )
        {
            __hal_smbios_processor_infos.voltage = ( float )3.3;
        }
        else if( voltage & 0x04 )
        {
            __hal_smbios_processor_infos.voltage = ( float )2.9;
        }
        else
        {
            __hal_smbios_processor_infos.voltage = ( float )0;
        }
        
    }
    else
    {
        __hal_smbios_processor_infos.voltage = ( float )( ( voltage & 0x7F ) / 10 );
    }
    
    __hal_smbios_processor_infos.socket        = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x04 ) );
    __hal_smbios_processor_infos.manufacturer  = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x07 ) );
    __hal_smbios_processor_infos.version       = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x10 ) );
    __hal_smbios_processor_infos.serial_number = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x20 ) );
    __hal_smbios_processor_infos.asset_tag     = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x21 ) );
    __hal_smbios_processor_infos.part_number   = __hal_smbios_get_string( mem + __hal_smbios_processor_infos.header.length, *( mem + 0x22 ) );
    __hal_smbios_processor_infos.family        = ( uint8_t )*( mem + 6 );
    
    __hal_smbios_infos.processor_infos = &__hal_smbios_processor_infos;
}

void __hal_smbios_process_struct_cache_infos( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_cache_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_cache_infos.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_cache_infos.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_cache_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.cache_infos = &__hal_smbios_cache_infos;
}

void __hal_smbios_process_struct_system_slots( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_system_slots.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_slots.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_system_slots.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_system_slots.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_slots = &__hal_smbios_system_slots;
}

void __hal_smbios_process_struct_physical_memory_array( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_physical_memory_array.header.type    = ( uint8_t )*( mem );
    __hal_smbios_physical_memory_array.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_physical_memory_array.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_physical_memory_array.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.physical_memory_array = &__hal_smbios_physical_memory_array;
}

void __hal_smbios_process_struct_memory_device( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_memory_device.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_device.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_memory_device.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_memory_device.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_device = &__hal_smbios_memory_device;
}

void __hal_smbios_process_struct_memory_mapped_address( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_memory_mapped_address.header.type    = ( uint8_t )*( mem );
    __hal_smbios_memory_mapped_address.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_memory_mapped_address.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_memory_mapped_address.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.memory_mapped_address = &__hal_smbios_memory_mapped_address;
}

void __hal_smbios_process_struct_system_boot_infos( uint8_t * mem )
{
    if( mem == NULL )
    {
        return;
    }
    
    __hal_smbios_system_boot_infos.header.type    = ( uint8_t )*( mem );
    __hal_smbios_system_boot_infos.header.length  = ( uint8_t )*( mem + 0x01 );
    __hal_smbios_system_boot_infos.header.handle  = ( uint8_t )*( mem + 0x02 );
    __hal_smbios_system_boot_infos.header.address = ( uintptr_t )mem;
    
    __hal_smbios_infos.system_boot_infos = &__hal_smbios_system_boot_infos;
}

