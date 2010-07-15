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

#ifndef __HAL_GDT_H__
#define __HAL_GDT_H__
#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define HAL_GDT_MAX_DESCRIPTORS 5

/**
 * A descriptor for the GDT takes the following format:
 *      
 *      Bits  0 - 15:   Segment limit (0-15)
 * 
 *      Bits 16 - 30:   Base address (0-23)
 * 
 *      Bit  40:        Access bit (only for virtual memory)
 * 
 *      Bits 41 - 43:   Descriptor type
 * 
 *                          Bit 41: Readable and writeable
 *                                      0:  Read only (data segment)
 *                                          Execute only (code segment)
 *                                      1:  Read and write (data segment)
 *                                      1:  Read and execute (code segment)
 *                          Bit 42: Expansion direction (for data segment)
 *                                  or conforming (code segment)
 *                          Bit 43: Executable segment
 *                                      0:  Data segment
 *                                      1:  Code segment
 * 
 *      Bit  44:        Descriptor bit
 * 
 *                          0:      System descriptor
 *                          1:      Code or data descriptor
 * 
 *      Bits 45 - 46:   Descriptor privilege level (rings 0 to 3)
 * 
 *      Bit  47:        Segment is in memory (only for virtual memory)
 * 
 *      Bits 48 - 51:   Segment limit (16-19)
 * 
 *      Bit  52:        Reserved (for OS)
 * 
 *      Bit  53:        Reserved
 * 
 *      Bit  54:        Segment type
 * 
 *                          0:      16 bits
 *                          1:      32 bits
 * 
 *      Bit  55:        Granularity
 * 
 *                          0:      None
 *                          1:      Limit is multiplied by 4K
 * 
 *      Bits 56 - 63:   Base address (24-31)
 */
struct hal_gdt_entry
{
    
    uint16_t    limit;
    uint16_t    address_low;
    uint8_t     address_mid;
    uint16_t    flags;
    uint8_t     address_high;
    
} __attribute__( ( packed ) );

struct hal_gdt_ptr
{
    
    uint16_t    limit;
    uint32_t    base;
    
} __attribute__( ( packed ) );

void hal_gdt_init( void );
struct hal_gdt_entry * hal_gdt_get_descriptor( unsigned int i );
void hal_gdt_set_descriptor( unsigned int i );


#ifdef __cplusplus
}
#endif

#endif /* __HAL_GDT_H__ */
