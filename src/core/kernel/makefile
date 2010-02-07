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

# $Id$

#-------------------------------------------------------------------------------
# Debug options
#-------------------------------------------------------------------------------
DEBUG               = 1

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

AS                  = nasm
CC                  = /usr/local/xeos-build/gcc/bin/i386-elf-gcc
LD                  = /usr/local/xeos-build/binutils/bin/i386-elf-ld
RM                  = rm

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_AS             = -f elf -I $(DIR_SRC_INC)
ARGS_CC             = -nostdlib -nostartfiles -nodefaultlibs -pedantic -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_LD             = -T linker.ld
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ../../../build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/core/
DIR_BUILD_OBJ       = $(DIR_BUILD)obj/core/
DIR_SRC             = ./
DIR_SRC_INC         = $(DIR_SRC)../include/
PATH               := /usr/local/xeos-build/binutils/i386-elf/bin:$(PATH)
PATH               := /usr/local/xeos-build/gcc/i386-elf/bin:$(PATH)

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM             = .asm
EXT_C               = .c
EXT_H               = .h
EXT_BIN             = .bin

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

# Define the search paths for source files
vpath %$(EXT_ASM) $(DIR_SRC)
vpath %$(EXT_C) $(DIR_SRC)
vpath %$(EXT_H) $(DIR_SRC_INC)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_ASM) $(EXT_C) $(EXT_H) $(EXT_BIN)

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
	@echo "    *** Compiling the kernel initialisation file"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $(DIR_BUILD_BIN)kernel-init.o kernel-init.asm)
	@$(AS) $(ARGS_AS) -o $(DIR_BUILD_OBJ)kernel-init.o kernel-init.asm
	@echo "    *** Compiling the kernel file"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CC) $(ARGS_CC) -o $(DIR_BUILD_BIN)kernel.o -c kernel.c)
	@$(CC) $(ARGS_CC) -o $(DIR_BUILD_OBJ)kernel.o -c kernel.c
	@echo "    *** Linking the kernel parts"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.BIN $(DIR_BUILD_BIN)kernel-init.o $(DIR_BUILD_BIN)kernel.o)
	@$(LD) $(ARGS_LD) -o $(DIR_BUILD_BIN)KERNEL.BIN $(DIR_BUILD_OBJ)kernel-init.o $(DIR_BUILD_OBJ)kernel.o

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_BIN)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BIN)*
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*
