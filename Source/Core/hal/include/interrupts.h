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

#ifndef __HAL_INTERRUPTS_H__
#define __HAL_INTERRUPTS_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Interrupt 0 — Divide Error Exception (#DE)
 * 
 * Exception class: Fault
 * 
 * Indicates the divisor operand for a DIV or IDIV instruction is 0 or that the
 * result cannot be repre- sented in the number of bits specified for the
 * destination operand.
 */
#define HAL_INT_DIVIDE_ERROR                        0
 
/**
 * Interrupt 1 — Debug Exception (#DB)
 * 
 * Exception class: Trap or Fault
 * 
 * Indicates that one or more of several debug-exception conditions has been
 * detected.
 */
#define HAL_INT_DEBUG_EXCEPTION                     1
 
/**
 * Interrupt 2 — NMI Interrupt
 * 
 * Exception class: Not applicable
 * 
 * The nonmaskable interrupt (NMI) is generated externally by asserting the
 * processor’s NMI pin or through an NMI request set by the I/O APIC to the
 * local APIC on the APIC serial bus. This interrupt causes the NMI interrupt
 * handler to be called.
 */
#define HAL_INT_NMI_INTERRUPT                       2
 
/**
 * Interrupt 3 — Breakpoint Exception (#BP)
 * 
 * Exception class: Trap
 */
#define HAL_INT_BREAKPOINT_EXCEPTION                3
 
/**
 * Interrupt 4 — Overflow Exception (#OF)
 * 
 * Exception class: Trap
 * 
 * Indicates that an overflow trap occurred when an INTO instruction was
 * executed. The INTO instruction checks the state of the OF flag in the EFLAGS
 * register. If the OF flag is set, an over- flow trap is generated.
 */
#define HAL_INT_OVERFLOW_EXCEPTION                  4
 
/**
 * Interrupt 5 — BOUND Range Exceeded Exception (#BR)
 * 
 * Exception class: Fault
 * 
 * Indicates that a BOUND-range-exceeded fault occurred when a BOUND instruction
 * was executed. The BOUND instruction checks that a signed array index is
 * within the upper and lower bounds of an array located in memory.
 * If the array index is not within the bounds of the array,
 * a BOUND-range-exceeded fault is generated.
 */
#define HAL_INT_BOUND_RANGE_EXCEEDED_EXCEPTION      5
 
/**
 * Interrupt 6 — Invalid Opcode Exception (#UD)
 * 
 * Exception class: Fault
 */
#define HAL_INT_INVALID_OPCODE_EXCEPTION            6
 
/**
 * Interrupt 7 — Device Not Available Exception (#NM)
 * 
 * Exception class: Fault
 */
#define HAL_INT_DEVICE_NOT_AVAILABLE_EXCEPTION      7
 
/**
 * Interrupt 8 — Double Fault Exception (#DF)
 * 
 * Exception class: Abort
 * 
 * Indicates that the processor detected a second exception while calling an
 * exception handler for a prior exception. Normally, when the processor detects
 * another exception while trying to call an exception handler, the two
 * exceptions can be handled serially. If, however, the processor cannot handle
 * them serially, it signals the double-fault exception.
 */
#define HAL_INT_DOUBLE_FAULT_EXCEPTION              8
 
/**
 * Interrupt 9 — Coprocessor Segment Overrun
 * 
 * Exception class: Abort
 * 
 * Indicates that an Intel386TM CPU-based systems with an Intel 387 math
 * coprocessor detected a page or segment violation while transferring the
 * middle portion of an Intel 387 math copro- cessor operand. The P6 family,
 * Pentium(R), and Intel486TM processors do not generate this exception;
 * instead, this condition is detected with a general protection exception
 * (#GP), interrupt 13.
 */
#define HAL_INT_COPROCESSOR_SEGMENT_OVERRUN         9
 
/**
 * Interrupt 10 — Invalid TSS Exception (#TS)
 * 
 * Exception class: Fault
 * 
 * Indicates that a task switch was attempted and that invalid information was
 * detected in the TSS for the target task. Table 5-6 shows the conditions
 * that will cause an invalid-TSS exception to be generated. In general,
 * these invalid conditions result from protection violations for the TSS
 * descriptor; the LDT pointed to by the TSS; or the stack, code, or data
 * segments referenced by the TSS.
 */
#define HAL_INT_INVALID_TSS_EXCEPTION               10
 
/**
 * Interrupt 11 — Segment Not Present (#NP)
 * 
 * Exception class: Fault
 * 
 * Indicates that the present flag of a segment or gate descriptor is clear.
 */
#define HAL_INT_SEGMENT_NOT_PRESENT                 11
 
/**
 * Interrupt 12 — Stack Fault Exception (#SS)
 * 
 * Exception class: Fault
 */
#define HAL_INT_STACK_FAULT_EXCEPTION               12
 
/**
 * Interrupt 13 — General Protection Exception (#GP)
 * 
 * Exception class: Fault
 * 
 * Indicates that the processor detected one of a class of protection violations
 * called "general- protection violations." The conditions that cause this
 * exception to be generated comprise all the protection violations that do not
 * cause other exceptions to be generated (such as, invalid-TSS,
 * segment-not-present, stack-fault, or page-fault exceptions). 
 */
#define HAL_INT_GENERAL_PROTECTION_EXCEPTION        13
 
/**
 * Interrupt 14 — Page-Fault Exception (#PF)
 * 
 * Exception class: Fault
 */
#define HAL_INT_PAGE_FAULT_EXCEPTION                14
 
/**
 * Interrupt 16 — Floating-Point Error Exception (#MF)
 * 
 * Exception class: Fault
 * 
 * Indicates that the FPU has detected a floating-point-error exception. The NE
 * flag in the register CR0 must be set and the appropriate exception must be
 * unmasked (clear mask bit in the control register) for an interrupt 16,
 * floating-point-error exception to be generated.
 */
#define HAL_INT_FLOATING_POINT_ERROR_EXCEPTION      16
 
/**
 * Interrupt 17 — Alignment Check Exception (#AC)
 * 
 * Exception class: Fault
 * 
 * Indicates that the processor detected an unaligned memory operand when
 * alignment checking was enabled. Alignment checks are only carried out in data
 * (or stack) segments (not in code or system segments). An example of an
 * alignment-check violation is a word stored at an odd byte address, or a
 * doubleword stored at an address that is not an integer multiple of 4.
 */
#define HAL_INT_ALIGNMENT_CHECK_EXCEPTION           17
 
/**
 * Interrupt 18 — Machine-Check Exception (#MC)
 * 
 * Exception class: Abort
 * 
 * Indicates that the processor detected an internal machine error or a bus
 * error, or that an external agent detected a bus error. The machine-check
 * exception is model-specific, available only on the P6 family and Pentium(R)
 * processors. The implementation of the machine-check exception is different
 * between the P6 family and Pentium(R) processors, and these implementations
 * may not be compatible with future Intel Architecture processors.
 * (Use the CPUID instruction to deter- mine whether this feature is present.)
 * Bus errors detected by external agents are signaled to the processor on
 * dedicated pins: the BINIT# pin on the P6 family processors and the BUSCHK#
 * pin on the Pentium(R) processor. When one of these pins is enabled, asserting
 * the pin causes error information to be loaded into machine-check registers
 * and a machine-check exception is generated.
 */
#define HAL_INT_MACHINE_CHECK_EXCEPTION             18
 
/**
 * Interrupt 19 — SIMD Floating-Point Exception (#XF)
 * 
 * Exception class: Fault
 * 
 * Indicates the processor has detected a SIMD floating-point execution unit
 * exception. The appro- priate status flag in the MXCSR register must be set
 * and the particular exception unmasked for this interrupt to be generated.
 */
#define HAL_INT_SIMD_FLOATING_POINT_EXCEPTION       19

#ifdef __cplusplus
}
#endif

#endif /* __HAL_INTERRUPTS_H__ */
