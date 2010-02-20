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
ARGS_CC             = -iquote $(DIR_SRC_INC) -I $(DIR_INC) -nostdlib -nostartfiles -nodefaultlibs -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_LD             = 
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ../../../build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/core/
DIR_BUILD_OBJ       = $(DIR_BUILD)obj/core/kernel/
DIR_SRC             = ./
DIR_SRC_KINT        = $(DIR_SRC)kint/
DIR_SRC_KVIDEO      = $(DIR_SRC)kvideo/
DIR_SRC_SYSCALLS    = $(DIR_SRC)syscalls/
DIR_SRC_INC         = $(DIR_SRC)include/
DIR_INC             = $(DIR_SRC)../include/
PATH               := /usr/local/xeos-build/binutils/i386-elf/bin:$(PATH)
PATH               := /usr/local/xeos-build/gcc/i386-elf/bin:$(PATH)

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM             = .asm
EXT_C               = .c
EXT_H               = .h
EXT_OBJ             = .o
EXT_BIN             = .bin

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

# Define the search paths for source files
vpath %$(EXT_ASM) $(DIR_SRC)
vpath %$(EXT_C)   $(DIR_SRC)
vpath %$(EXT_C)   $(DIR_SRC_KVIDEO)
vpath %$(EXT_C)   $(DIR_SRC_KINT)
vpath %$(EXT_C)   $(DIR_SRC_SYSCALLS)
vpath %$(EXT_H)   $(DIR_SRC_INC)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_ASM) $(EXT_C) $(EXT_H) $(EXT_OBJ) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every code file in the source directory
_FILES_ASM                  = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_ASM)))
_FILES_C                    = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_C)))
_FILES_C_KINT               = $(foreach dir,$(DIR_SRC_KINT),$(wildcard $(DIR_SRC_KINT)*$(EXT_C)))
_FILES_C_KVIDEO             = $(foreach dir,$(DIR_SRC_KVIDEO),$(wildcard $(DIR_SRC_KVIDEO)*$(EXT_C)))
_FILES_C_SYSCALLS           = $(foreach dir,$(DIR_SRC_SYSCALLS),$(wildcard $(DIR_SRC_SYSCALLS)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_ASM_REL              = $(notdir $(_FILES_ASM))
_FILES_C_REL                = $(notdir $(_FILES_C))
_FILES_C_REL_KINT           = $(notdir $(_FILES_C_KINT))
_FILES_C_REL_KVIDEO         = $(notdir $(_FILES_C_KVIDEO))
_FILES_C_REL_SYSCALLS       = $(notdir $(_FILES_C_SYSCALLS))

# Replace the code extension by the object one
_FILES_ASM_OBJ              = $(subst $(EXT_ASM),$(EXT_ASM)$(EXT_OBJ),$(_FILES_ASM_REL))
_FILES_C_OBJ                = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL))
_FILES_C_OBJ_KINT           = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_KINT))
_FILES_C_OBJ_KVIDEO         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_KVIDEO))
_FILES_C_OBJ_SYSCALLS       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_SYSCALLS))

# Prefix all binary files with the build directory
_FILES_ASM_OBJ_BUILD        = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_ASM_OBJ))
_FILES_C_OBJ_BUILD          = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_KINT     = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_KINT))
_FILES_C_OBJ_BUILD_KVIDEO   = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_KVIDEO))
_FILES_C_OBJ_BUILD_SYSCALLS = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_SYSCALLS))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_ASM_OBJ_BUILD) $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_KINT) $(_FILES_C_OBJ_BUILD_KVIDEO) $(_FILES_C_OBJ_BUILD_SYSCALLS)
	
# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*
	
# Compiles an assembly file
$(DIR_BUILD_OBJ)%$(EXT_ASM)$(EXT_OBJ): %$(EXT_ASM)
	@echo "    *** Compiling assembly file $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $(DIR_BUILD_OBJ)$(@F) $<)
	@$(AS) $(ARGS_AS) -o $(DIR_BUILD_OBJ)$(@F) $<
	
# Compiles an C file
$(DIR_BUILD_OBJ)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	@echo "    *** Compiling C file $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CC) $(ARGS_CC) -o $(DIR_BUILD_OBJ)$(@F) -c $<)
	@$(CC) $(ARGS_CC) -o $(DIR_BUILD_OBJ)$(@F) -c $<
