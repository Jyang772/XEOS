#-------------------------------------------------------------------------------
# XEOS - x86 Experimental Operating System
# 
# Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)
# All rights reserved
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
#  -   Redistributions of source code must retain the above copyright notice,
#      this list of conditions and the following disclaimer.
#  -   Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#  -   Neither the name of 'Jean-David Gadina' nor the names of its
#      contributors may be used to endorse or promote products derived from
#      this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
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

DIR_BUILD             = ../../build/
DIR_BUILD_BIN         = $(DIR_BUILD)bin/core/
DIR_BUILD_OBJ         = $(DIR_BUILD)obj/core/
DIR_BUILD_OBJ_LIBC    = $(DIR_BUILD_OBJ)libc/
DIR_BUILD_OBJ_LIBXEOS = $(DIR_BUILD_OBJ)libxeos/
DIR_BUILD_OBJ_HAL     = $(DIR_BUILD_OBJ)hal/
DIR_BUILD_OBJ_KERNEL  = $(DIR_BUILD_OBJ)kernel/
DIR_SRC               = ./
DIR_SRC_INC           = $(DIR_SRC)include/
DIR_SRC_LIBC          = $(DIR_SRC)libc/
DIR_SRC_LIBXEOS		  = $(DIR_SRC)libxeos/
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
.PHONY: all clean kernel

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all:
	@echo "    *** Building the C standard library"
	@cd $(DIR_SRC_LIBC) && $(MAKE)
	@echo "    *** Building the XEOS standard library"
	@cd $(DIR_SRC_LIBXEOS) && $(MAKE)
	@echo "    *** Building the harware abstraction layer"
	@cd $(DIR_SRC_HAL) && $(MAKE)
	@echo "    *** Building the kernel"
	@cd $(DIR_SRC_KERNEL) && $(MAKE)
	@echo "    *** Linking the kernel"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.BIN $(DIR_BUILD_OBJ_KERNEL)* $(DIR_BUILD_OBJ_LIBC)* $(DIR_BUILD_OBJ_LIBXEOS)* $(DIR_BUILD_OBJ_HAL)*)
	@$(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.ELF $(DIR_BUILD_OBJ_KERNEL)* $(DIR_BUILD_OBJ_LIBC)* $(DIR_BUILD_OBJ_LIBXEOS)* $(DIR_BUILD_OBJ_HAL)*
	
# Cleans the build files
clean:
	@cd $(DIR_SRC_LIBC) && $(MAKE) clean
	@cd $(DIR_SRC_LIBXEOS) && $(MAKE) clean
	@cd $(DIR_SRC_HAL) && $(MAKE) clean
	@cd $(DIR_SRC_KERNEL) && $(MAKE) clean
	@if [ -f $(DIR_BUILD_BIN)KERNEL.ELF ]; then $(RM) $(DIR_BUILD_BIN)KERNEL.ELF; fi;
