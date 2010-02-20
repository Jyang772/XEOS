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

#ifndef __HAL_IDT_H__
#define __HAL_IDT_H__
#pragma once

#include <stdint.h>

#define HAL_IDT_MAX_DESCRIPTORS 256

#define HAL_IDT_FLAG_16BITS     0x06    /* 00000110 */
#define HAL_IDT_FLAG_32BITS     0x0E    /* 00001110 */
#define HAL_IDT_FLAG_RING1      0x40    /* 01000000 */
#define HAL_IDT_FLAG_RING2      0x20    /* 00100000 */
#define HAL_IDT_FLAG_RING3      0x60    /* 01100000 */
#define HAL_IDT_FLAG_PRESENT    0x80    /* 10000000 */

struct hal_idt_entry
{
    
    uint16_t    address_low;
    uint16_t    selector;
    uint8_t     reserved;
    uint8_t     flags;
    uint16_t    address_high;
    
} __attribute__( ( packed ) );

struct hal_idt_ptr
{
    
    uint16_t    limit;
    uint32_t    base;
    
} __attribute__( ( packed ) );

typedef void ( * hal_irq_handler )( void );

void hal_idt_init( uint16_t sel, hal_irq_handler default_handler );
struct hal_idt_entry * hal_idt_get_descriptor( unsigned int i );
void hal_idt_set_descriptor( unsigned int i, hal_irq_handler handler, uint16_t sel, uint8_t flags );

#endif /* __HAL_IDT_H__ */
