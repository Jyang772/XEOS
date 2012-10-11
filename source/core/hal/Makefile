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

# $Id$

include ../../../Makefile-Config.mk

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" SRC  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" CORE "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" HAL  "$(COLOR_NONE)"]> *** "

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_SRC_CPU         := $(PATH_SRC_CORE_HAL)cpu/
DIR_SRC_IDT         := $(PATH_SRC_CORE_HAL)idt/
DIR_SRC_IO          := $(PATH_SRC_CORE_HAL)io/
DIR_SRC_SMBIOS      := $(PATH_SRC_CORE_HAL)smbios/
DIR_SRC_INC         := $(PATH_SRC_CORE_HAL)include/

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_CC_32          := -iquote $(DIR_SRC_INC) $(ARGS_CC_32)
ARGS_CC_64          := -iquote $(DIR_SRC_INC) $(ARGS_CC_64)

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Define the search paths for source files
vpath %$(EXT_C) $(PATH_SRC_CORE_HAL)
vpath %$(EXT_C) $(DIR_SRC_CPU)
vpath %$(EXT_C) $(DIR_SRC_IDT)
vpath %$(EXT_C) $(DIR_SRC_IO)
vpath %$(EXT_C) $(DIR_SRC_SMBIOS)
vpath %$(EXT_H) $(DIR_SRC_INC)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_C) $(EXT_H) $(EXT_OBJ) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every code file in the source directory
_FILES_C                  = $(foreach dir,$(PATH_SRC_CORE_HAL),$(wildcard $(PATH_SRC_CORE_HAL)*$(EXT_C)))
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
_FILES_C_OBJ_BUILD        = $(addprefix $(PATH_BUILD_32_CORE_OBJ_HAL),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_CPU    = $(addprefix $(PATH_BUILD_32_CORE_OBJ_HAL),$(_FILES_C_OBJ_CPU))
_FILES_C_OBJ_BUILD_IDT    = $(addprefix $(PATH_BUILD_32_CORE_OBJ_HAL),$(_FILES_C_OBJ_IDT))
_FILES_C_OBJ_BUILD_IO     = $(addprefix $(PATH_BUILD_32_CORE_OBJ_HAL),$(_FILES_C_OBJ_IO))
_FILES_C_OBJ_BUILD_SMBIOS = $(addprefix $(PATH_BUILD_32_CORE_OBJ_HAL),$(_FILES_C_OBJ_SMBIOS))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS: $(PATH_BUILD_64_CORE_OBJ_HAL)%$(EXT_C)$(EXT_OBJ)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_CPU) $(_FILES_C_OBJ_BUILD_IDT) $(_FILES_C_OBJ_BUILD_IO) $(_FILES_C_OBJ_BUILD_SMBIOS)
	
# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_OBJ_HAL)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_OBJ_HAL)*
    
# Compiles a C file (64 bits)
$(PATH_BUILD_64_CORE_OBJ_HAL)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)

	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64) -o $(PATH_BUILD_64_CORE_OBJ_HAL)$(@F) -c $(abspath $<)

# Targets with second expansion
.SECONDEXPANSION:

# Compiles a C file (32 bits)
$(PATH_BUILD_32_CORE_OBJ_HAL)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_OBJ_HAL),$(PATH_BUILD_64_CORE_OBJ_HAL),$$@)

	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32) -o $(PATH_BUILD_32_CORE_OBJ_HAL)$(@F) -c $(abspath $<)
