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
#include <string.h>
#include "smbios.h"

char * hal_smbios_processor_family_string( uint8_t number )
{
    switch( ( unsigned int )number )
    {
        case 0x01:
            
            return "Other";
            
        case 0x02:
            
            return "Unknown";
            
        case 0x03:
            
            return "8086";
            
        case 0x04:
            
            return "80286";
            
        case 0x05:
            
            return "Intel386(TM) processor";
            
        case 0x06:
            
            return "Intel486(TM) processor";
            
        case 0x07:
            
            return "8087";
            
        case 0x08:
            
            return "80287";
            
        case 0x09:
            
            return "80387";
            
        case 0x0A:
            
            return "80487";
            
        case 0x0B:
            
            return "Pentium(R) processor Family";
            
        case 0x0C:
            
            return "Pentium(R) Pro processor";
            
        case 0x0D:
            
            return "Pentium(R) II processor";
            
        case 0x0E:
            
            return "Pentium(R) processor with MMX(TM) technology";
            
        case 0x0F:
            
            return "Celeron(TM) processor";
            
        case 0x10:
            
            return "Pentium(R) II Xeon(TM) processor";
            
        case 0x11:
            
            return "Pentium(R) III processor";
            
        case 0x12:
            
            return "M1 Family";
            
        case 0x13:
            
            return "M2 Family";
            
        case 0x14:
            
            return "Intel(R) Celeron(R) M processor";
            
        case 0x15:
            
            return "Intel(R) Pentium(R) 4 HT processor";
            
        case 0x18:
            
            return "AMD Duron(TM) Processor Family";
            
        case 0x19:
            
            return "K5 Family";
            
        case 0x1A:
            
            return "K6 Family";
            
        case 0x1B:
            
            return "K6-2";
            
        case 0x1C:
            
            return "K6-3";
            
        case 0x1D:
            
            return "AMD Athlon(TM) Processor Family";
            
        case 0x1E:
            
            return "AMD29000 Family";
            
        case 0x1F:
            
            return "K6-2+";
            
        case 0x20:
            
            return "Power PC Family";
            
        case 0x21:
            
            return "Power PC 601";
            
        case 0x22:
            
            return "Power PC 603";
            
        case 0x23:
            
            return "Power PC 603+";
            
        case 0x24:
            
            return "Power PC 604";
            
        case 0x25:
            
            return "Power PC 620";
            
        case 0x26:
            
            return "Power PC x704";
            
        case 0x27:
            
            return "Power PC 750";
            
        case 0x28:
            
            return "Intel(R) Core(TM) Duo processor";
            
        case 0x29:
            
            return "Intel(R) Core(TM) Duo mobile processor";
            
        case 0x2A:
            
            return "Intel(R) Core(TM) Solo mobile processor";
            
        case 0x30:
            
            return "Alpha Family3";
            
        case 0x31:
            
            return "Alpha 21064";
            
        case 0x32:
            
            return "Alpha 21066";
            
        case 0x33:
            
            return "Alpha 21164";
            
        case 0x34:
            
            return "Alpha 21164PC";
            
        case 0x35:
            
            return "Alpha 21164a";
            
        case 0x36:
            
            return "Alpha 21264";
            
        case 0x37:
            
            return "Alpha 21364";
            
        case 0x40:
            
            return "MIPS Family";
            
        case 0x41:
            
            return "MIPS R4000";
            
        case 0x42:
            
            return "MIPS R4200";
            
        case 0x43:
            
            return "MIPS R4400";
            
        case 0x44:
            
            return "MIPS R4600";
            
        case 0x45:
            
            return "MIPS R10000";
            
        case 0x50:
            
            return "SPARC Family";
            
        case 0x51:
            
            return "SuperSPARC";
            
        case 0x52:
            
            return "microSPARC II";
            
        case 0x53:
            
            return "microSPARC IIep";
            
        case 0x54:
            
            return "UltraSPARC";
            
        case 0x55:
            
            return "UltraSPARC II";
            
        case 0x56:
            
            return "UltraSPARC IIi";
            
        case 0x57:
            
            return "UltraSPARC III";
            
        case 0x58:
            
            return "UltraSPARC IIIi";
            
        case 0x60:
            
            return "68040 Family";
            
        case 0x61:
            
            return "68xxx";
            
        case 0x62:
            
            return "68000";
            
        case 0x63:
            
            return "68010";
            
        case 0x64:
            
            return "68020";
            
        case 0x65:
            
            return "68030";
            
        case 0x70:
            
            return "Hobbit Family";
            
        case 0x78:
            
            return "Crusoe(TM) TM5000 Family";
            
        case 0x79:
            
            return "Crusoe(TM) TM3000 Family";
            
        case 0x7A:
            
            return "Efficeon(TM) TM8000 Family";
            
        case 0x80:
            
            return "Weitek";
            
        case 0x82:
            
            return "Itanium(TM) processor";
            
        case 0x83:
            
            return "AMD Athlon(TM) 64 Processor Family";
            
        case 0x84:
            
            return "AMD Opteron(TM) Processor Family";
            
        case 0x85:
            
            return "AMD Sempron(TM) Processor Family";
            
        case 0x86:
            
            return "AMD Turion(TM) 64 Mobile Technology";
            
        case 0x87:
            
            return "Dual-Core AMD Opteron(TM) Processor Family";
            
        case 0x88:
            
            return "AMD Athlon(TM) 64 X2 Dual-Core Processor Family";
            
        case 0x89:
            
            return "AMD Turion(TM) 64 X2 Mobile Technology";
            
        case 0x8A:
            
            return "Quad-Core AMD Opteron(TM) Processor Family";
            
        case 0x8B:
            
            return "Third-Generation AMD Opteron(TM) Processor Family";
            
        case 0x8C:
            
            return "AMD Phenom(TM) FX Quad-Core Processor Family";
            
        case 0x8D:
            
            return "AMD Phenom(TM) X4 Quad-Core Processor Family";
            
        case 0x8E:
            
            return "AMD Phenom(TM) X2 Dual-Core Processor Family";
            
        case 0x8F:
            
            return "AMD Athlon(TM) X2 Dual-Core Processor Family";
            
        case 0x90:
            
            return "PA-RISC Family";
            
        case 0x91:
            
            return "PA-RISC 8500";
            
        case 0x92:
            
            return "PA-RISC 8000";
            
        case 0x93:
            
            return "PA-RISC 7300LC";
            
        case 0x94:
            
            return "PA-RISC 7200";
            
        case 0x95:
            
            return "PA-RISC 7100LC";
            
        case 0x96:
            
            return "PA-RISC 7100";
            
        case 0xA0:
            
            return "V30 Family";
            
        case 0xA1:
            
            return "Quad-Core Intel(R) Xeon(R) processor 3200 Series";
            
        case 0xA2:
            
            return "Dual-Core Intel(R) Xeon(R) processor 3000 Series";
            
        case 0xA3:
            
            return "Quad-Core Intel(R) Xeon(R) processor 5300 Series";
            
        case 0xA4:
            
            return "Dual-Core Intel(R) Xeon(R) processor 5100 Series";
            
        case 0xA5:
            
            return "Dual-Core Intel(R) Xeon(R) processor 5000 Series";
            
        case 0xA6:
            
            return "Dual-Core Intel(R) Xeon(R) processor LV";
            
        case 0xA7:
            
            return "Dual-Core Intel(R) Xeon(R) processor ULV";
            
        case 0xA8:
            
            return "Dual-Core Intel(R) Xeon(R) processor 7100 Series";
            
        case 0xA9:
            
            return "Quad-Core Intel(R) Xeon(R) processor 5400 Series";
            
        case 0xAA:
            
            return "Quad-Core Intel(R) Xeon(R) processor";
            
        case 0xAB:
            
            return "Dual-Core Intel(R) Xeon(R) processor 5200 Series";
            
        case 0xAC:
            
            return "Dual-Core Intel(R) Xeon(R) processor 7200 Series";
            
        case 0xAD:
            
            return "Quad-Core Intel(R) Xeon(R) processor 7300 Series";
            
        case 0xAE:
            
            return "Quad-Core Intel(R) Xeon(R) processor 7400 Series";
            
        case 0xAF:
            
            return "Multi-Core Intel(R) Xeon(R) processor 7400 Series";
            
        case 0xB0:
            
            return "Pentium(R) III Xeon(TM) processor";
            
        case 0xB1:
            
            return "Pentium(R) III Processor with Intel (R) SpeedStep(TM) Technology";
            
        case 0xB2:
            
            return "Pentium(R) 4 Processor";
            
        case 0xB3:
            
            return "Intel(R) Xeon(TM)";
            
        case 0xB4:
            
            return "AS400 Family";
            
        case 0xB5:
            
            return "Intel(R) Xeon(TM) processor MP";
            
        case 0xB6:
            
            return "AMD Athlon(TM) XP Processor Family";
            
        case 0xB7:
            
            return "AMD Athlon(TM) MP Processor Family";
            
        case 0xB8:
            
            return "Intel(R) Itanium(R) 2 processor";
            
        case 0xB9:
            
            return "Intel(R) Pentium(R) M processor";
            
        case 0xBA:
            
            return "Intel(R) Celeron(R) D processor";
            
        case 0xBB:
            
            return "Intel(R) Pentium(R) D processor";
            
        case 0xBC:
            
            return "Intel(R) Pentium(R) Processor Extreme Edition";
            
        case 0xBD:
            
            return "Intel(R) Core(TM) Solo Processor";
            
        case 0xBF:
            
            return "Intel(R) Core(TM)2 Duo Processor";
            
        case 0xC0:
            
            return "Intel(R) Core(TM)2 Solo processor";
            
        case 0xC1:
            
            return "Intel(R) Core(TM)2 Extreme processor";
            
        case 0xC2:
            
            return "Intel(R) Core(TM)2 Quad processor";
            
        case 0xC3:
            
            return "Intel(R) Core(TM)2 Extreme mobile processor";
            
        case 0xC4:
            
            return "Intel(R) Core(TM)2 Duo mobile processor";
            
        case 0xC5:
            
            return "Intel(R) Core(TM)2 Solo mobile processor";
            
        case 0xC6:
            
            return "Intel(R) Core(TM) i7 processor";
            
        case 0xC7:
            
            return "Dual-Core Intel(R) Celeron(R) processor";
            
        case 0xC8:
            
            return "IBM390 Family";
            
        case 0xC9:
            
            return "G4";
            
        case 0xCA:
            
            return "G5";
            
        case 0xCB:
            
            return "ESA/390 G6";
            
        case 0xCC:
            
            return "z/Architectur base";
            
        case 0xD2:
            
            return "VIA C7(TM)-M Processor Family";
            
        case 0xD3:
            
            return "VIA C7(TM)-D Processor Family";
            
        case 0xD4:
            
            return "VIA C7(TM) Processor Family";
            
        case 0xD5:
            
            return "VIA Eden(TM) Processor Family";
            
        case 0xD6:
            
            return "Multi-Core Intel(R) Xeon(R) processor";
            
        case 0xD7:
            
            return "Dual-Core Intel(R) Xeon(R) processor 3xxx Series";
            
        case 0xD8:
            
            return "Quad-Core Intel(R) Xeon(R) processor 3xxx Series";
            
        case 0xDA:
            
            return "Dual-Core Intel(R) Xeon(R) processor 5xxx Series";
            
        case 0xDB:
            
            return "Quad-Core Intel(R) Xeon(R) processor 5xxx Series";
            
        case 0xDD:
            
            return "Dual-Core Intel(R) Xeon(R) processor 7xxx Series";
            
        case 0xDE:
            
            return "Quad-Core Intel(R) Xeon(R) processor 7xxx Series";
            
        case 0xDF:
            
            return "Multi-Core Intel(R) Xeon(R) processor 7xxx Series";
            
        case 0xE6:
            
            return "Embedded AMD Opteron(TM) Quad-Core Processor Family";
            
        case 0xE7:
            
            return "AMD Phenom(TM) Triple-Core Processor Family";
            
        case 0xE8:
            
            return "AMD Turion(TM) Ultra Dual-Core Mobile Processor Family";
            
        case 0xE9:
            
            return "AMD Turion(TM) Dual-Core Mobile Processor Family";
            
        case 0xEA:
            
            return "AMD Athlon(TM) Dual-Core Processor Family";
            
        case 0xEB:
            
            return "AMD Sempron(TM) SI Processor Family";
            
        case 0xFA:
            
            return "i860";
            
        case 0xFB:
            
            return "i960";
            
        case 0x104:
            
            return "SH-3";
            
        case 0x105:
            
            return "SH-4";
            
        case 0x118:
            
            return "ARM";
            
        case 0x119:
            
            return "StrongARM";
            
        case 0x12C:
            
            return "6x86";
            
        case 0x12D:
            
            return "MediaGX";
            
        case 0x12E:
            
            return "MII";
            
        case 0x140:
            
            return "WinChip";
            
        case 0x15E:
            
            return "DSP";
            
        case 0x1F4:
            
            return "Video Processor";
        
        default:
            
            break;
    }
    
    return "Unknown";
}
