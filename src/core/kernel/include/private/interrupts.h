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

#ifndef __KERNEL_INTERRUPTS_H__
#define __KERNEL_INTERRUPTS_H__
#pragma once

void kernel_interrupt_default_handler( void );
void kernel_interrupt_divide_error( void );
void kernel_interrupt_debug_exception( void );
void kernel_interrupt_nmi_interrupt( void );
void kernel_interrupt_breakpoint_exception( void );
void kernel_interrupt_overflow_exception( void );
void kernel_interrupt_bound_range_exceeded_exception( void );
void kernel_interrupt_invalid_opcode_exception( void );
void kernel_interrupt_device_not_available_exception( void );
void kernel_interrupt_double_fault_exception( void );
void kernel_interrupt_coprocessor_segment_overrun( void );
void kernel_interrupt_invalid_tss_exception( void );
void kernel_interrupt_segment_not_present( void );
void kernel_interrupt_stack_fault_exception( void );
void kernel_interrupt_general_protection_exception( void );
void kernel_interrupt_page_fault_exception( void );
void kernel_interrupt_floating_point_error_exception( void );
void kernel_interrupt_alignment_check_exception( void );
void kernel_interrupt_machine_check_exception( void );
void kernel_interrupt_simd_floating_point_exception( void );

#endif /* __KERNEL_INTERRUPTS_H__ */
