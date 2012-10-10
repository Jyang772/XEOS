#-------------------------------------------------------------------------------
# Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
# All rights reserved.
# 
# XEOS Software License - Version 1.0 - December 21, 2012
# 
# Permission is hereby granted, free of charge, to any person or organisation
# obtaining a copy of the software and accompanying documentation covered by
# this license (the "Software") to deal in the Software, with or without
# modification, without restriction, including without limitation the rights
# to use, execute, display, copy, reproduce, transmit, publish, distribute,
# modify, merge, prepare derivative works of the Software, and to permit
# third-parties to whom the Software is furnished to do so, all subject to the
# following conditions:
# 
#       1.  Redistributions of source code, in whole or in part, must retain the
#           above copyright notice and this entire statement, including the
#           above license grant, this restriction and the following disclaimer.
# 
#       2.  Redistributions in binary form must reproduce the above copyright
#           notice and this entire statement, including the above license grant,
#           this restriction and the following disclaimer in the documentation
#           and/or other materials provided with the distribution, unless the
#           Software is distributed by the copyright owner as a library.
#           A "library" means a collection of software functions and/or data
#           prepared so as to be conveniently linked with application programs
#           (which use some of those functions and data) to form executables.
# 
#       3.  The Software, or any substancial portion of the Software shall not
#           be combined, included, derived, or linked (statically or
#           dynamically) with software or libraries licensed under the terms
#           of any GNU software license, including, but not limited to, the GNU
#           General Public License (GNU/GPL) or the GNU Lesser General Public
#           License (GNU/LGPL).
# 
#       4.  All advertising materials mentioning features or use of this
#           software must display an acknowledgement stating that the product
#           includes software developed by the copyright owner.
# 
#       5.  Neither the name of the copyright owner nor the names of its
#           contributors may be used to endorse or promote products derived from
#           this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
# 
# IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
# THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
# THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
#-------------------------------------------------------------------------------

# $Id: makefile 433 2011-02-23 17:59:49Z macmade@eosgarden.com $

#-------------------------------------------------------------------------------
# Debug options
#-------------------------------------------------------------------------------
DEBUG               = 0

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

MAKE                = make
LD_32               = /usr/local/xeos-build/binutils/bin/i386-elf-ld
LD_64               = /usr/local/xeos-build/binutils/bin/x86_64-elf-ld

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_MAKE           = 
ARGS_LD_32          = -T linker.ld
ARGS_LD_64          = -T linker.ld

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD_32            = ../../build/core/i386/
DIR_BUILD_64            = ../../build/core/x86_64/
DIR_BUILD_BIN_32        = $(DIR_BUILD_32)bin/
DIR_BUILD_BIN_64        = $(DIR_BUILD_64)bin/
DIR_BUILD_OBJ_32        = $(DIR_BUILD_32)obj/
DIR_BUILD_OBJ_64        = $(DIR_BUILD_64)obj/
DIR_BUILD_OBJ_LIBC_32   = $(DIR_BUILD_OBJ_32)libc/
DIR_BUILD_OBJ_LIBC_64   = $(DIR_BUILD_OBJ_64)libc/
DIR_BUILD_OBJ_HAL_32    = $(DIR_BUILD_OBJ_32)hal/
DIR_BUILD_OBJ_HAL_64    = $(DIR_BUILD_OBJ_64)hal/
DIR_BUILD_OBJ_KERNEL_32 = $(DIR_BUILD_OBJ_32)kernel/
DIR_BUILD_OBJ_KERNEL_64 = $(DIR_BUILD_OBJ_64)kernel/
DIR_SRC                 = ./
DIR_SRC_INC             = $(DIR_SRC)include/
DIR_SRC_LIBC            = $(DIR_SRC)libc/
DIR_SRC_HAL             = $(DIR_SRC)hal/
DIR_SRC_KERNEL          = $(DIR_SRC)kernel/

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES:

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all:
	@echo "    *** Building the C standard library"
	@cd $(DIR_SRC_LIBC) && $(MAKE)
	@echo "    *** Building the harware abstraction layer"
	@cd $(DIR_SRC_HAL) && $(MAKE)
	@echo "    *** Building the kernel"
	@cd $(DIR_SRC_KERNEL) && $(MAKE)
	@echo "    *** Linking the 32 bits kernel"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(LD_32) $(ARGS_LD_32) -o $(DIR_BUILD_BIN_32)KERNEL32.ELF $(DIR_BUILD_OBJ_KERNEL_32)* $(DIR_BUILD_OBJ_LIBC_32)* $(DIR_BUILD_OBJ_HAL_32)*)
	@$(LD_32) $(ARGS_LD_32) -o $(DIR_BUILD_BIN_32)KERNEL32.ELF $(DIR_BUILD_OBJ_KERNEL_32)* $(DIR_BUILD_OBJ_LIBC_32)* $(DIR_BUILD_OBJ_HAL_32)*
	@echo "    *** Linking the 64 bits kernel"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(LD_64) $(ARGS_LD_64) -o $(DIR_BUILD_BIN_64)KERNEL64.ELF $(DIR_BUILD_OBJ_KERNEL_64)* $(DIR_BUILD_OBJ_LIBC_64)* $(DIR_BUILD_OBJ_HAL_64)*)
	@$(LD_64) $(ARGS_LD_64) -o $(DIR_BUILD_BIN_64)KERNEL64.ELF $(DIR_BUILD_OBJ_KERNEL_64)* $(DIR_BUILD_OBJ_LIBC_64)* $(DIR_BUILD_OBJ_HAL_64)*
	
# Cleans the build files
clean:
	@cd $(DIR_SRC_LIBC) && $(MAKE) clean
	@cd $(DIR_SRC_HAL) && $(MAKE) clean
	@cd $(DIR_SRC_KERNEL) && $(MAKE) clean
	@if [ -f $(DIR_BUILD_BIN_32)KERNEL32.ELF ]; then $(RM) $(DIR_BUILD_BIN_32)KERNEL_32.ELF; fi;
	@if [ -f $(DIR_BUILD_BIN_64)KERNEL64.ELF ]; then $(RM) $(DIR_BUILD_BIN_64)KERNEL_64.ELF; fi;
