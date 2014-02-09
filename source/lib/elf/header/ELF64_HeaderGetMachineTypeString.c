/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
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

#include <elf.h>
#include <elf/__private/elf.h>
#include <stdlib.h>

const char * ELF64_HeaderGetMachineTypeString( ELF64_HeaderRef header )
{
    switch( ELF64_HeaderGetMachineType( header ) )
    {
        case ELF64_MachineTypeUnknown:      return "Unknown";
        case ELF64_MachineTypeM32:          return "AT&T WE 32100";
        case ELF64_MachineTypeSPARC:        return "SPARC";
        case ELF64_MachineType386:          return "Intel 80386";
        case ELF64_MachineType68K:          return "Motorola 68000";
        case ELF64_MachineType88K:          return "Motorola 88000";
        case ELF64_MachineType860:          return "Intel 80860";
        case ELF64_MachineTypeMIPS:         return "MIPS I Architecture";
        case ELF64_MachineTypeS370:         return "IBM System/370 Processor";
        case ELF64_MachineTypeMIPSRS3LE:    return "MIPS RS3000 Little-endian";
        case ELF64_MachineTypePARISC:       return "Hewlett-Packard PA-RISC";
        case ELF64_MachineTypeVPP500:       return "Fujitsu VPP500";
        case ELF64_MachineTypeSPARC32Plus:  return "Enhanced instruction set SPARC";
        case ELF64_MachineType960:          return "Intel 80960";
        case ELF64_MachineTypePPC:          return "PowerPC";
        case ELF64_MachineTypePPC64:        return "64-bit PowerPC";
        case ELF64_MachineTypeV800:         return "NEC V800";
        case ELF64_MachineTypeFR20:         return "Fujitsu FR20";
        case ELF64_MachineTypeRH32:         return "TRW RH-32";
        case ELF64_MachineTypeRCE:          return "Motorola RCE";
        case ELF64_MachineTypeARM:          return "Advanced RISC Machines ARM";
        case ELF64_MachineTypeAlpha:        return "Digital Alpha";
        case ELF64_MachineTypeSH:           return "Hitachi SH";
        case ELF64_MachineTypeSPARCV9:      return "SPARC Version 9";
        case ELF64_MachineTypeTricore:      return "Siemens Tricore embedded processor";
        case ELF64_MachineTypeARC:          return "Argonaut RISC Core, Argonaut Technologies Inc.";
        case ELF64_MachineTypeH8300:        return "Hitachi H8/300";
        case ELF64_MachineTypeH8300H:       return "Hitachi H8/300H";
        case ELF64_MachineTypeH8S:          return "Hitachi H8S";
        case ELF64_MachineTypeH8500:        return "Hitachi H8/500";
        case ELF64_MachineTypeIA64:         return "Intel IA-64 processor architecture";
        case ELF64_MachineTypeMIPSX:        return "Stanford MIPS-X";
        case ELF64_MachineTypeColdFire:     return "Motorola ColdFire";
        case ELF64_MachineType68HC12:       return "Motorola M68HC12";
        case ELF64_MachineTypeMMA:          return "Fujitsu MMA Multimedia Accelerator";
        case ELF64_MachineTypePCP:          return "Siemens PCP";
        case ELF64_MachineTypeNCPU:         return "Sony nCPU embedded RISC processor";
        case ELF64_MachineTypeNDR1:         return "Denso NDR1 microprocessor";
        case ELF64_MachineTypeStarCore:     return "Motorola Star*Core processor";
        case ELF64_MachineTypeME16:         return "Toyota ME16 processor";
        case ELF64_MachineTypeST100:        return "STMicroelectronics ST100 processor";
        case ELF64_MachineTypeTinyJ:        return "Advanced Logic Corp. TinyJ embedded processor family";
        case ELF64_MachineTypeFX66:         return "Siemens FX66 microcontroller";
        case ELF64_MachineTypeST9Plus:      return "STMicroelectronics ST9+ 8/16 bit microcontroller";
        case ELF64_MachineTypeST7:          return "STMicroelectronics ST7 8-bit microcontroller";
        case ELF64_MachineType68HC16:       return "Motorola MC68HC16 Microcontroller";
        case ELF64_MachineType68HC11:       return "Motorola MC68HC11 Microcontroller";
        case ELF64_MachineType68HC08:       return "Motorola MC68HC08 Microcontroller";
        case ELF64_MachineType68HC05:       return "Motorola MC68HC05 Microcontroller";
        case ELF64_MachineTypeSVX:          return "Silicon Graphics SVx";
        case ELF64_MachineTypeST19:         return "STMicroelectronics ST19 8-bit microcontroller";
        case ELF64_MachineTypeVAX:          return "Digital VAX";
        case ELF64_MachineTypeCRIS:         return "Axis Communications 32-bit embedded processor";
        case ELF64_MachineTypeJavelin:      return "Infineon Technologies 32-bit embedded processor";
        case ELF64_MachineTypeFirePath:     return "Element 14 64-bit DSP Processor";
        case ELF64_MachineTypeZSP:          return "LSI Logic 16-bit DSP Processor";
        case ELF64_MachineTypeMMIX:         return "Donald Knuth's educational 64-bit processor";
        case ELF64_MachineTypeHUANY:        return "Harvard University machine-independent object files";
        case ELF64_MachineTypePrism:        return "SiTera Prism";
    }
}
