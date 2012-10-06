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

CC                  = /usr/local/xeos-build/gcc/bin/i386-elf-gcc
LD                  = /usr/local/xeos-build/binutils/bin/i386-elf-ld
RM                  = rm

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_CC             = -iquote $(DIR_SRC_INC) -I $(DIR_INC) -nostdlib -nostartfiles -nodefaultlibs -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_LD             = 
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ../../../build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/core/
DIR_BUILD_OBJ       = $(DIR_BUILD)obj/core/hal/
DIR_SRC             = ./
DIR_SRC_CPU         = $(DIR_SRC)cpu/
DIR_SRC_IDT         = $(DIR_SRC)idt/
DIR_SRC_IO          = $(DIR_SRC)io/
DIR_SRC_SMBIOS      = $(DIR_SRC)smbios/
DIR_SRC_INC         = $(DIR_SRC)include/
DIR_INC             = $(DIR_SRC)../include/
PATH               := /usr/local/xeos-build/binutils/i386-elf/bin:$(PATH)
PATH               := /usr/local/xeos-build/gcc/i386-elf/bin:$(PATH)

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

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
vpath %$(EXT_C) $(DIR_SRC)
vpath %$(EXT_C) $(DIR_SRC_CPU)
vpath %$(EXT_C) $(DIR_SRC_IDT)
vpath %$(EXT_C) $(DIR_SRC_IO)
vpath %$(EXT_C) $(DIR_SRC_SMBIOS)
vpath %$(EXT_H) $(DIR_SRC_INC)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_C) $(EXT_H) $(EXT_OBJ) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every code file in the source directory
_FILES_C                  = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_C)))
_FILES_C_CPU              = $(foreach dir,$(DIR_SRC_CPU),$(wildcard $(DIR_SRC_CPU)*$(EXT_C)))
_FILES_C_IDT              = $(foreach dir,$(DIR_SRC_IDT),$(wildcard $(DIR_SRC_IDT)*$(EXT_C)))
_FILES_C_IO               = $(foreach dir,$(DIR_SRC_IO),$(wildcard $(DIR_SRC_IO)*$(EXT_C)))
_FILES_C_SMBIOS           = $(foreach dir,$(DIR_SRC_SMBIOS),$(wildcard $(DIR_SRC_SMBIOS)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_C_REL              = $(notdir $(_FILES_C))
_FILES_C_REL_CPU          = $(notdir $(_FILES_C_CPU))
_FILES_C_REL_IDT          = $(notdir $(_FILES_C_IDT))
_FILES_C_REL_IO           = $(notdir $(_FILES_C_IO))
_FILES_C_REL_SMBIOS       = $(notdir $(_FILES_C_SMBIOS))

# Replace the code extension by the object one
_FILES_C_OBJ              = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL))
_FILES_C_OBJ_CPU          = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_CPU))
_FILES_C_OBJ_IDT          = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_IDT))
_FILES_C_OBJ_IO           = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_IO))
_FILES_C_OBJ_SMBIOS       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_SMBIOS))

# Prefix all binary files with the build directory
_FILES_C_OBJ_BUILD        = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_CPU    = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_CPU))
_FILES_C_OBJ_BUILD_IDT    = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_IDT))
_FILES_C_OBJ_BUILD_IO     = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_IO))
_FILES_C_OBJ_BUILD_SMBIOS = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_SMBIOS))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_CPU) $(_FILES_C_OBJ_BUILD_IDT) $(_FILES_C_OBJ_BUILD_IO) $(_FILES_C_OBJ_BUILD_SMBIOS)
	
# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ)*
	
# Compiles an C file
$(DIR_BUILD_OBJ)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	@echo "    *** Compiling C file $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CC) $(ARGS_CC) -o $(DIR_BUILD_OBJ)$(@F) -c $<)
	@$(CC) $(ARGS_CC) -o $(DIR_BUILD_OBJ)$(@F) -c $<
