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

ARGS_CC             = -iquote $(DIR_SRC_INC) -I $(DIR_INC) -nostdlib -nostartfiles -nodefaultlibs -pedantic -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_LD             = 
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ../../../build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/core/
DIR_BUILD_OBJ       = $(DIR_BUILD)obj/core/libc/
DIR_SRC             = ./
DIR_SRC_LOCALE      = $(DIR_SRC)locale/
DIR_SRC_MATH        = $(DIR_SRC)math/
DIR_SRC_STDIO       = $(DIR_SRC)stdio/
DIR_SRC_STDLIB      = $(DIR_SRC)stdlib/
DIR_SRC_STRING      = $(DIR_SRC)string/
DIR_SRC_TIME        = $(DIR_SRC)time/
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
vpath %$(EXT_C) $(DIR_SRC_LOCALE)
vpath %$(EXT_C) $(DIR_SRC_MATH)
vpath %$(EXT_C) $(DIR_SRC_STDIO)
vpath %$(EXT_C) $(DIR_SRC_STDLIB)
vpath %$(EXT_C) $(DIR_SRC_STRING)
vpath %$(EXT_C) $(DIR_SRC_TIME)
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
_FILES_C_LOCALE           = $(foreach dir,$(DIR_SRC_LOCALE),$(wildcard $(DIR_SRC_LOCALE)*$(EXT_C)))
_FILES_C_MATH             = $(foreach dir,$(DIR_SRC_MATH),$(wildcard $(DIR_SRC_MATH)*$(EXT_C)))
_FILES_C_STDIO            = $(foreach dir,$(DIR_SRC_STDIO),$(wildcard $(DIR_SRC_STDIO)*$(EXT_C)))
_FILES_C_STDLIB           = $(foreach dir,$(DIR_SRC_STDLIB),$(wildcard $(DIR_SRC_STDLIB)*$(EXT_C)))
_FILES_C_STRING           = $(foreach dir,$(DIR_SRC_STRING),$(wildcard $(DIR_SRC_STRING)*$(EXT_C)))
_FILES_C_TIME             = $(foreach dir,$(DIR_SRC_TIME),$(wildcard $(DIR_SRC_TIME)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_C_REL              = $(notdir $(_FILES_C))
_FILES_C_REL_LOCALE       = $(notdir $(_FILES_C_LOCALE))
_FILES_C_REL_MATH         = $(notdir $(_FILES_C_MATH))
_FILES_C_REL_STDIO        = $(notdir $(_FILES_C_STDIO))
_FILES_C_REL_STDLIB       = $(notdir $(_FILES_C_STDLIB))
_FILES_C_REL_STRING       = $(notdir $(_FILES_C_STRING))
_FILES_C_REL_TIME         = $(notdir $(_FILES_C_TIME))

# Replace the code extension by the object one
_FILES_C_OBJ              = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL))
_FILES_C_OBJ_LOCALE       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_LOCALE))
_FILES_C_OBJ_MATH         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_MATH))
_FILES_C_OBJ_STDIO        = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STDIO))
_FILES_C_OBJ_STDLIB       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STDLIB))
_FILES_C_OBJ_STRING       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STRING))
_FILES_C_OBJ_TIME         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_TIME))

# Prefix all binary files with the build directory
_FILES_C_OBJ_BUILD        = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_LOCALE = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_LOCALE))
_FILES_C_OBJ_BUILD_MATH   = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_MATH))
_FILES_C_OBJ_BUILD_STDIO  = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_STDIO))
_FILES_C_OBJ_BUILD_STDLIB = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_STDLIB))
_FILES_C_OBJ_BUILD_STRING = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_STRING))
_FILES_C_OBJ_BUILD_TIME   = $(addprefix $(DIR_BUILD_OBJ),$(_FILES_C_OBJ_TIME))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_LOCALE) $(_FILES_C_OBJ_BUILD_MATH) $(_FILES_C_OBJ_BUILD_STDIO) $(_FILES_C_OBJ_BUILD_STDLIB) $(_FILES_C_OBJ_BUILD_STRING) $(_FILES_C_OBJ_BUILD_TIME)
	
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
