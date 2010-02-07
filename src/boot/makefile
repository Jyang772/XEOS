# -----------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------

# $Id$

#-------------------------------------------------------------------------------
# Debug options
#-------------------------------------------------------------------------------
DEBUG               = 1

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

AS                  = nasm
RM                  = rm

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_AS             = -f bin -I $(DIR_SRC_INC)
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ../../build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/boot/
DIR_BUILD_MNT       = $(DIR_BUILD)mount/
DIR_BUILD_REL       = $(DIR_BUILD)release/
DIR_RES             = ../../res/
DIR_SRC             = ../../src/boot/
DIR_SRC_INC         = $(DIR_SRC)include/

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM             = .asm
EXT_BIN             = .bin

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

# Define the search paths for source files
vpath %$(EXT_ASM) $(DIR_SRC_BOOT)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_ASM) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every assembly file in the source directory
_FILES_ASM        = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_ASM)))

# Gets only the file name of the assembly files
_FILES_ASM_REL    = $(notdir $(_FILES_ASM))

# Replace the code extension by the binary one
_FILES_ASM_BIN    = $(subst $(EXT_ASM),$(EXT_BIN),$(_FILES_ASM_REL))

# Prefix all binary files with the build directory
_FILES_BIN_BUILD  = $(addprefix $(DIR_BUILD_BIN),$(_FILES_ASM_BIN))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_BIN_BUILD)

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_BIN)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BIN)*
	
# Compiles an assembly file
$(DIR_BUILD_BIN)%$(EXT_BIN): %$(EXT_ASM)
	@echo "    *** Compiling assembly file $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $(DIR_BUILD_BIN)`echo "$(@F)" | tr '[:lower:]' '[:upper:]'` $<)
	@$(AS) $(ARGS_AS) -o $(DIR_BUILD_BIN)`echo "$(@F)" | tr '[:lower:]' '[:upper:]'` $<
