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

#ifndef __XEOS_LIB_ELF___PRIVATE_ELF_H__
#define __XEOS_LIB_ELF___PRIVATE_ELF_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <elf.h>

struct __ELF64_SymbolTableEntry
{
    ELF64_Word  st_name;    /* Symbol name */
    ELF64_UChar st_info;    /* Type and binding attributes */
    ELF64_UChar st_other;   /* Reserved */
    ELF64_Half  st_shndx;   /* Section table index */
    ELF64_Addr  st_value;   /* Symbol value */
    ELF64_XWord st_size;    /* Size of object */
};

struct __ELF64_ProgramHeaderEntry
{
    ELF64_Word  p_type;     /* Type of segment */
    ELF64_Word  p_flags;    /* Segment attributes */
    ELF64_Off   p_offset;   /* Offset in file */
    ELF64_Addr  p_vaddr;    /* Virtual address in memory */
    ELF64_Addr  p_paddr;    /* Reserved */
    ELF64_XWord p_filesz;   /* Size of segment in file */
    ELF64_XWord p_memsz;    /* Size of segment in memory */
    ELF64_XWord p_align;    /* Alignment of segment */
};

struct __ELF64_SectionHeaderEntry
{
    ELF64_Word  sh_name;        /* Section name */
    ELF64_Word  sh_type;        /* Section type */
    ELF64_XWord sh_flags;       /* Section attributes */
    ELF64_Addr  sh_addr;        /* Virtual address in memory */
    ELF64_Off   sh_offset;      /* Offset in file */
    ELF64_XWord sh_size;        /* Size of section */
    ELF64_Word  sh_link;        /* Link to other section */
    ELF64_Word  sh_info;        /* Miscellaneous information */
    ELF64_XWord sh_addralign;   /* Address alignment boundary */
    ELF64_XWord sh_entsize;     /* Size of entries, if section has table */
};

struct __ELF64_Header
{
    ELF64_UChar   e_ident[ 16 ];  /* ELF identification */
    ELF64_Half    e_type;         /* Object file type */
    ELF64_Half    e_machine;      /* Machine type */
    ELF64_Word    e_version;      /* Object file version */
    ELF64_Addr    e_entry;        /* Entry point address */
    ELF64_Off     e_phoff;        /* Program header offset */
    ELF64_Off     e_shoff;        /* Section header offset */
    ELF64_Word    e_flags;        /* Processor-specific flags */
    ELF64_Half    e_ehsize;       /* ELF header size */
    ELF64_Half    e_phentsize;    /* Size of program header entry */
    ELF64_Half    e_phnum;        /* Number of program header entries */
    ELF64_Half    e_shentsize;    /* Size of section header entry */
    ELF64_Half    e_shnum;        /* Number of section header entries */
    ELF64_Half    e_shstrndx;     /* Section name string table index */
};

struct __ELF64_File
{
    struct __ELF64_Header header;
};

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_ELF___PRIVATE_ELF_H__ */
