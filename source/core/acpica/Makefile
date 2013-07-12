#-------------------------------------------------------------------------------
# Copyright (c) 2010-2012, Jean-David Gadina - www.xs-labs.com
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

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" SRC  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" CORE "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" ACPICA "$(COLOR_NONE)"]> *** "

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_SRC_COMPONENTS              = $(PATH_SRC_CORE_ACPICA)source/source/components/
DIR_SRC_COMPONENTS_DISPATCHER   = $(DIR_SRC_COMPONENTS)dispatcher/
DIR_SRC_COMPONENTS_EVENTS       = $(DIR_SRC_COMPONENTS)events/
DIR_SRC_COMPONENTS_EXECUTER     = $(DIR_SRC_COMPONENTS)executer/
DIR_SRC_COMPONENTS_HARDWARE     = $(DIR_SRC_COMPONENTS)hardware/
DIR_SRC_COMPONENTS_NAMESPACE    = $(DIR_SRC_COMPONENTS)namespace/
DIR_SRC_COMPONENTS_PARSER       = $(DIR_SRC_COMPONENTS)parser/
DIR_SRC_COMPONENTS_RESOURCES    = $(DIR_SRC_COMPONENTS)resources/
DIR_SRC_COMPONENTS_TABLES       = $(DIR_SRC_COMPONENTS)tables/
DIR_SRC_COMPONENTS_UTILITIES    = $(DIR_SRC_COMPONENTS)utilities/

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_CC_32          := -iquote $(PATH_SRC_CORE_ACPICA)source/source/include $(ARGS_CC_32)
ARGS_CC_64          := -iquote $(PATH_SRC_CORE_ACPICA)source/source/include $(ARGS_CC_64)

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Define the search paths for source files
vpath %$(EXT_C) $(DIR_SRC_COMPONENTS_DISPATCHER)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_C) $(EXT_H) $(EXT_OBJ) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every code file in the source directory
_FILES_C_COMPONENTS_DISPATCHER              = $(foreach dir,$(DIR_SRC_COMPONENTS_DISPATCHER),$(wildcard $(DIR_SRC_COMPONENTS_DISPATCHER)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_C_REL_COMPONENTS_DISPATCHER          = $(notdir $(_FILES_C_COMPONENTS_DISPATCHER))

# Replace the code extension by the object one
_FILES_C_OBJ_COMPONENTS_DISPATCHER          = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_COMPONENTS_DISPATCHER))

# Prefix all binary files with the build directory
_FILES_C_OBJ_BUILD_COMPONENTS_DISPATCHER    = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPICA),$(_FILES_C_OBJ_COMPONENTS_DISPATCHER))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS: $(PATH_BUILD_64_CORE_OBJ_ACPICA)%$(EXT_C)$(EXT_OBJ)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: 
		
	@:

# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_OBJ_ACPICA)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_OBJ_ACPICA)*
	
# Compiles a C file (64 bits)
$(PATH_BUILD_64_CORE_OBJ_ACPICA)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64) -o $(PATH_BUILD_64_CORE_OBJ_ACPICA)$(@F) -c $(abspath $<)

# Targets with second expansion
.SECONDEXPANSION:

# Compiles a C file (32 bits)
$(PATH_BUILD_32_CORE_OBJ_ACPICA)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_OBJ_ACPICA),$(PATH_BUILD_64_CORE_OBJ_ACPICA),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32) -o $(PATH_BUILD_32_CORE_OBJ_ACPICA)$(@F) -c $(abspath $<)
