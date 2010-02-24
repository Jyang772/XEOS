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

#ifndef __HAL_SMBIOS_H__
#define __HAL_SMBIOS_H__
#pragma once

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#define HAL_SMBIOS_MEM_START        0x000F0000
#define HAL_SMBIOS_MEM_END          0x000FFFFF
#define HAL_SMBIOS_SIGNATURE        "_SM_"
#define HAL_SMBIOS_DMI_SIGNATURE    "_DMI_"

#define HAL_SMBIOS_STRUCT_BIOS_INFORMATION                          0   /* Required */
#define HAL_SMBIOS_STRUCT_SYSTEM_INFORMATION                        1   /* Required */
#define HAL_SMBIOS_STRUCT_BASE_BOARD_INFORMATION                    2
#define HAL_SMBIOS_STRUCT_SYSTEM_ENCLOSURE                          3   /* Required */
#define HAL_SMBIOS_STRUCT_PROCESSOR_INFORMATION                     4   /* Required */
#define HAL_SMBIOS_STRUCT_MEMORY_CONTROLLER_INFORMATION             5   /* Obsolete */
#define HAL_SMBIOS_STRUCT_MEMORY_MODULE_INFORMATION                 6   /* Obsolete */
#define HAL_SMBIOS_STRUCT_CACHE_INFORMATION                         7   /* Required */
#define HAL_SMBIOS_STRUCT_PORT_CONNECTOR_INFORMATION                8
#define HAL_SMBIOS_STRUCT_SYSTEM_SLOTS                              9   /* Required */
#define HAL_SMBIOS_STRUCT_ON_BOARD_DEVICES_INFORMATION              10  /* Obsolete */
#define HAL_SMBIOS_STRUCT_OEM_STRINGS                               11
#define HAL_SMBIOS_STRUCT_SYSTEM_CONFIGURATION_OPTIONS              12
#define HAL_SMBIOS_STRUCT_BIOS_LANGUAGE_INFORMATION                 13
#define HAL_SMBIOS_STRUCT_GROUP_ASSOCIATIONS                        14
#define HAL_SMBIOS_STRUCT_SYSTEM_EVENT_LOG                          15
#define HAL_SMBIOS_STRUCT_PHYSICAL_MEMORY_ARRAY                     16   /* Required */
#define HAL_SMBIOS_STRUCT_MEMORY_DEVICE                             17   /* Required */
#define HAL_SMBIOS_STRUCT_32_BIT_MEMORY_ERROR_INFORMATION           18
#define HAL_SMBIOS_STRUCT_MEMORY_ARRAY_MAPPED_ADDRESS               19   /* Required */
#define HAL_SMBIOS_STRUCT_MEMORY_DEVICE_MAPPED_ADDRESS              20
#define HAL_SMBIOS_STRUCT_BUILT_IN_POINTING_DEVICE                  21
#define HAL_SMBIOS_STRUCT_PORTABLE_BATTERY                          22
#define HAL_SMBIOS_STRUCT_SYSTEM_RESET                              23
#define HAL_SMBIOS_STRUCT_HARDWARE_SECURITY                         24
#define HAL_SMBIOS_STRUCT_SYSTEM_POWER_CONTROLS                     25
#define HAL_SMBIOS_STRUCT_VOLTAGE_PROBE                             26
#define HAL_SMBIOS_STRUCT_COOLING_DEVICE                            27
#define HAL_SMBIOS_STRUCT_TEMPERATURE_PROBE                         28
#define HAL_SMBIOS_STRUCT_ELECTRICAL_CURRENT_PROBE                  29
#define HAL_SMBIOS_STRUCT_OUT_OF_BAND_REMOTE_ACCESS                 30
#define HAL_SMBIOS_STRUCT_BOOT_INTEGRITY_SERVICES_ENTRY_POINT       31
#define HAL_SMBIOS_STRUCT_SYSTEM_BOOT_INFORMATION                   32   /* Required */
#define HAL_SMBIOS_STRUCT_64_BIT_MEMORY_ERROR_INFORMATION           33
#define HAL_SMBIOS_STRUCT_MANAGEMENT_DEVICE                         34
#define HAL_SMBIOS_STRUCT_MANAGEMENT_DEVICE_COMPONENT               35
#define HAL_SMBIOS_STRUCT_MANAGEMENT_DEVICE_THRESHOLD_DATA          36
#define HAL_SMBIOS_STRUCT_MEMORY_CHANNEL                            37
#define HAL_SMBIOS_STRUCT_IPMI_DEVICE_INFORMATION                   38
#define HAL_SMBIOS_STRUCT_SYSTEM_POWER_SUPPLY                       39
#define HAL_SMBIOS_STRUCT_ADDITIONAL_INFORMATION                    40
#define HAL_SMBIOS_STRUCT_ONBOARD_DEVICES_EXTENDED_INFORMATION      41
#define HAL_SMBIOS_STRUCT_INACTIVE                                  126
#define HAL_SMBIOS_STRUCT_END_OF_TABLE                              127

/**
 * SMBIOS Structure Table Entry Point
 * 
 * On non-EFI systems, the SMBIOS Entry Point structure, described below, can be
 * located by application software by searching for the anchor-string on
 * paragraph (16-byte) boundaries within the physical memory address range
 * 000F0000h to 000FFFFFh. This entry point encapsulates an intermediate anchor
 * string that is used by some existing DMI browsers.
 * 
 * The structure is the following:
 *      
 *      00h:        Anchor String (4 BYTEs)
 *                  _SM_, specified as four ASCII characters (5F 53 4D 5F).
 *      
 *      04h:        Entry Point Structure Checksum (BYTE)
 *                  Checksum of the Entry Point Structure (EPS). This value,
 *                  when added to all other bytes in the EPS, will result in the
 *                  value 00h (using 8-bit addition calculations). Values in the
 *                  EPS are summed starting at offset 00h, for Entry Point
 *                  Length bytes.
 *      
 *      05h:        Entry Point Length (BYTE)
 *                  Length of the Entry Point Structure, starting with the
 *                  Anchor String field, in bytes, currently 1Fh.
 *      
 *      06h:        SMBIOS Major Version (BYTE)
 *                  Identifies the major version of this specification
 *                  implemented in the table structures, e.g. the value will be
 *                  0Ah for revision 10.22 and 02h for revision 2.1.
 *      
 *      07h:        SMBIOS Minor Version (BYTE)
 *                  Identifies the minor version of this specification
 *                  implemented in the table structures, e.g. the value will be
 *                  16h for revision 10.22 and 01h for revision 2.1.
 *      
 *      08h:        Maximum Structure Size (WORD)
 *                  Size of the largest SMBIOS structure, in bytes, and
 *                  encompasses the structure’s formatted area and text strings.
 *                  This is the value returned as StructureSize from the
 *                  Plug-and-Play Get SMBIOS Information function.
 *      
 *      0Ah:        Entry Point Revision (BYTE)
 *                  Identifies the EPS revision implemented in this structure
 *                  and identifies the formatting of offsets 0Bh to 0Fh, one of:
 *                  00h	Entry Point is based on SMBIOS 2.1 definition; formatted
 *                  area is reserved and set to all 00h. 01h-FFh Reserved for
 *                  assignment via this specification
 *      
 *      0Bh - 0Fh:  Formatted Area (5 BYTEs)
 *                  The value present in the Entry Point Revision field defines
 *                  the interpretation to be placed upon these 5 bytes.
 *      
 *      10h:        Intermediate anchor string (5 BYTEs)
 *                  _DMI_, specified as five ASCII characters (5F 44 4D 49 5F).
 *                  Note: This field is paragraph-aligned, to allow legacy DMI
 *                  browsers to find this entry point within the SMBIOS Entry
 *                  Point Structure.
 *      
 *      15h:        Intermediate Checksum (BYTE)
 *                  Checksum of Intermediate Entry Point Structure (IEPS). This
 *                  value, when added to all other bytes in the IEPS, will
 *                  result in the value 00h (using 8-bit addition calculations).
 *                  Values in the IEPS are summed starting at offset 10h,
 *                  for 0Fh bytes.
 *      
 *      16h:        Structure Table Length (WORD)
 *                  Total length of SMBIOS Structure Table, pointed to by the
 *                  Structure Table Address, in bytes.
 *      
 *      18h:        Structure Table Address (DWORD)
 *                  The 32-bit physical starting address of the read-only SMBIOS
 *                  Structure Table, that can start at any 32-bit address.
 *                  This area contains all of the SMBIOS structures fully packed
 *                  together. These structures can then be parsed to produce
 *                  exactly the same format as that returned from a Get SMBIOS
 *                  Structure function call.
 *      
 *      1Ch:        Number of SMBIOS Structures (WORD)
 *                  Total number of structures present in the SMBIOS Structure
 *                  Table. This is the value returned as NumStructures from the
 *                  Get SMBIOS Information function.
 *      
 *      1Eh:        SMBIOS BCD Revision (BYTE)
 *                  Indicates compliance with a revision of this specification.
 *                  It is a BCD value where the upper nibble indicates the major
 *                  version and the lower nibble the minor version. For revision
 *                  2.1, the returned value is 21h. If the value is 00h, only
 *                  the Major and Minor Versions in offsets 6 and 7 of the
 *                  Entry Point Structure provide the version information.
 */
typedef struct
{
    
    uint8_t  anchor[ 4 ];
    uint8_t  checksum;
    uint8_t  length;
    uint8_t  version_major;
    uint8_t  version_minor;
    uint16_t max_structure_size;
    uint8_t  revision;
    uint8_t  formatted_area[ 5 ];
    uint8_t  intermediate_anchor[ 5 ];
    uint8_t  intermediate_checksum;
    uint16_t structure_table_length;
    uint32_t structure_table_address;
    uint16_t structures_count;
    uint8_t  bcd_revision;
    
} __attribute__( ( packed ) ) hal_smbios_table_entry;

typedef struct
{
    uint8_t      type;
    uint8_t      length;
    uint16_t     handle;
    uintptr_t    address;
    
} __attribute__( ( packed ) ) hal_smbios_structure_header;

typedef struct
{
    
    bool characteristics;
    bool isa;
    bool mca;
    bool eisa;
    bool pci;
    bool pcmcia;
    bool plug_and_play;
    bool apm;
    bool upgradeable;
    bool shadowing;
    bool vl_vesa;
    bool escd;
    bool boot_cd;
    bool boot_select;
    bool rom_socketed;
    bool boot_pcmcia;
    bool edd;
    bool service_floppy_nec9800_japan;
    bool service_floppy_toshiba_japan;
    bool service_floppy_525_360kb;
    bool service_floppy_525_1200kb;
    bool service_floppy_35_720kb;
    bool service_floppy_35_2880kb;
    bool service_print_screen;
    bool service_keyboard;
    bool service_serial;
    bool service_printer;
    bool service_video_cga_mono;
    bool nec_pc98;
    
} __attribute__( ( packed ) ) hal_smbios_bios_characteristics;

typedef struct
{
    
    hal_smbios_structure_header header;
    char * vendor;
    char * version;
    char * date;
    uintptr_t address;
    unsigned int rom_size;
    unsigned int release_major;
    unsigned int release_minor;
    hal_smbios_bios_characteristics * characteristics;
    unsigned int embedded_controller_firmware_major;
    unsigned int embedded_controller_firmware_minor;
    
    
} __attribute__( ( packed ) ) hal_smbios_bios_infos;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_system_infos;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_system_enclosure;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_processor_infos;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} hal_smbios_cache_infos;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_system_slots;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_physical_memory_array;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_memory_device;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_memory_mapped_address;

typedef struct
{
    
    hal_smbios_structure_header header;
    
} __attribute__( ( packed ) ) hal_smbios_system_boot_infos;

typedef struct
{
    
    hal_smbios_bios_infos            * bios_infos;
    hal_smbios_system_infos          * system_infos;
    hal_smbios_system_enclosure      * system_enclosure;
    hal_smbios_processor_infos       * processor_infos;
    hal_smbios_cache_infos           * cache_infos;
    hal_smbios_system_slots          * system_slots;
    hal_smbios_physical_memory_array * physical_memory_array;
    hal_smbios_memory_device         * memory_device ;
    hal_smbios_memory_mapped_address * memory_mapped_address;
    hal_smbios_system_boot_infos     * system_boot_infos;
    
} __attribute__( ( packed ) ) hal_smbios_infos;

hal_smbios_table_entry * hal_smbios_find_entry( void );
bool hal_smbios_verifiy_checksum( hal_smbios_table_entry * entry );
bool hal_smbios_verifiy_intermediate_checksum( hal_smbios_table_entry * entry );
hal_smbios_infos * hal_smbios_get_infos( hal_smbios_table_entry * entry );

#ifdef __cplusplus
}
#endif

#endif /* __HAL_SMBIOS_H__ */
