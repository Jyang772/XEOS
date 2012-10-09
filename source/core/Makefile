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
DEBUG               = 1

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

MAKE                = make
LD                  = /usr/local/xeos-build/binutils/bin/i386-elf-ld

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_MAKE           = 
ARGS_LD             = -T linker.ld

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD             = ../../build/core/i386/
DIR_BUILD_BIN         = $(DIR_BUILD)bin/
DIR_BUILD_OBJ         = $(DIR_BUILD)obj/
DIR_BUILD_OBJ_LIBC    = $(DIR_BUILD_OBJ)libc/
DIR_BUILD_OBJ_HAL     = $(DIR_BUILD_OBJ)hal/
DIR_BUILD_OBJ_KERNEL  = $(DIR_BUILD_OBJ)kernel/
DIR_SRC               = ./
DIR_SRC_INC           = $(DIR_SRC)include/
DIR_SRC_LIBC          = $(DIR_SRC)libc/
DIR_SRC_HAL           = $(DIR_SRC)hal/
DIR_SRC_KERNEL        = $(DIR_SRC)kernel/

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
	@echo "    *** Linking the kernel"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.ELF $(DIR_BUILD_OBJ_KERNEL)* $(DIR_BUILD_OBJ_LIBC)* $(DIR_BUILD_OBJ_HAL)*)
	@$(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.ELF $(DIR_BUILD_OBJ_KERNEL)* $(DIR_BUILD_OBJ_LIBC)* $(DIR_BUILD_OBJ_HAL)*
	
# Cleans the build files
clean:
	@cd $(DIR_SRC_LIBC) && $(MAKE) clean
	@cd $(DIR_SRC_HAL) && $(MAKE) clean
	@cd $(DIR_SRC_KERNEL) && $(MAKE) clean
	@if [ -f $(DIR_BUILD_BIN)KERNEL.ELF ]; then $(RM) $(DIR_BUILD_BIN)KERNEL.ELF; fi;
