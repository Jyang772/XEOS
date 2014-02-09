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

ELF64_MachineType ELF64_HeaderGetMachineType( ELF64_HeaderRef header )
{
    if( header == NULL )
    {
        return ELF64_MachineTypeUnknown;
    }
    
    switch( ELF64_HeaderGetMachine( header ) )
    {
        case 0:     return ELF64_MachineTypeUnknown;
        case 1:     return ELF64_MachineTypeM32;
        case 2:     return ELF64_MachineTypeSPARC;
        case 3:     return ELF64_MachineType386;
        case 4:     return ELF64_MachineType68K;
        case 5:     return ELF64_MachineType88K;
        case 7:     return ELF64_MachineType860;
        case 8:     return ELF64_MachineTypeMIPS;
        case 9:     return ELF64_MachineTypeS370;
        case 10:    return ELF64_MachineTypeMIPSRS3LE;
        case 15:    return ELF64_MachineTypePARISC;
        case 17:    return ELF64_MachineTypeVPP500;
        case 18:    return ELF64_MachineTypeSPARC32Plus;
        case 19:    return ELF64_MachineType960;
        case 20:    return ELF64_MachineTypePPC;
        case 21:    return ELF64_MachineTypePPC64;
        case 36:    return ELF64_MachineTypeV800;
        case 37:    return ELF64_MachineTypeFR20;
        case 38:    return ELF64_MachineTypeRH32;
        case 39:    return ELF64_MachineTypeRCE;
        case 40:    return ELF64_MachineTypeARM;
        case 41:    return ELF64_MachineTypeAlpha;
        case 42:    return ELF64_MachineTypeSH;
        case 43:    return ELF64_MachineTypeSPARCV9;
        case 44:    return ELF64_MachineTypeTricore;
        case 45:    return ELF64_MachineTypeARC;
        case 46:    return ELF64_MachineTypeH8300;
        case 47:    return ELF64_MachineTypeH8300H;
        case 48:    return ELF64_MachineTypeH8S;
        case 49:    return ELF64_MachineTypeH8500;
        case 50:    return ELF64_MachineTypeIA64;
        case 51:    return ELF64_MachineTypeMIPSX;
        case 52:    return ELF64_MachineTypeColdFire;
        case 53:    return ELF64_MachineType68HC12;
        case 54:    return ELF64_MachineTypeMMA;
        case 55:    return ELF64_MachineTypePCP;
        case 56:    return ELF64_MachineTypeNCPU;
        case 57:    return ELF64_MachineTypeNDR1;
        case 58:    return ELF64_MachineTypeStarCore;
        case 59:    return ELF64_MachineTypeME16;
        case 60:    return ELF64_MachineTypeST100;
        case 61:    return ELF64_MachineTypeTinyJ;
        case 66:    return ELF64_MachineTypeFX66;
        case 67:    return ELF64_MachineTypeST9Plus;
        case 68:    return ELF64_MachineTypeST7;
        case 69:    return ELF64_MachineType68HC16;
        case 70:    return ELF64_MachineType68HC11;
        case 71:    return ELF64_MachineType68HC08;
        case 72:    return ELF64_MachineType68HC05;
        case 73:    return ELF64_MachineTypeSVX;
        case 74:    return ELF64_MachineTypeST19;
        case 75:    return ELF64_MachineTypeVAX;
        case 76:    return ELF64_MachineTypeCRIS;
        case 77:    return ELF64_MachineTypeJavelin;
        case 78:    return ELF64_MachineTypeFirePath;
        case 79:    return ELF64_MachineTypeZSP;
        case 80:    return ELF64_MachineTypeMMIX;
        case 81:    return ELF64_MachineTypeHUANY;
        case 82:    return ELF64_MachineTypePrism;
        default:    break;
    }
    
    return ELF64_MachineTypeUnknown;
}
