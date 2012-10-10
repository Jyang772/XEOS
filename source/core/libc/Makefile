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

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" SRC  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" CORE "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" LIBC "$(COLOR_NONE)"]> *** "

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_SRC_CTYPE       = $(PATH_SRC_CORE_LIBC)ctype/
DIR_SRC_LOCALE      = $(DIR_SRC)locale/
DIR_SRC_MATH        = $(DIR_SRC)math/
DIR_SRC_SIGNAL      = $(DIR_SRC)signal/
DIR_SRC_STDIO       = $(DIR_SRC)stdio/
DIR_SRC_STDLIB      = $(DIR_SRC)stdlib/
DIR_SRC_STRING      = $(DIR_SRC)string/
DIR_SRC_TIME        = $(DIR_SRC)time/
DIR_SRC_INC         = $(DIR_SRC)include/

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_CC_32          := -iquote $(DIR_SRC_INC) $(ARGS_CC_32)
ARGS_CC_64          := -iquote $(DIR_SRC_INC) $(ARGS_CC_64)

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Define the search paths for source files
vpath %$(EXT_C) $(PATH_SRC_CORE_LIBC)
vpath %$(EXT_C) $(DIR_SRC_CTYPE)
vpath %$(EXT_C) $(DIR_SRC_LOCALE)
vpath %$(EXT_C) $(DIR_SRC_MATH)
vpath %$(EXT_C) $(DIR_SRC_SIGNAL)
vpath %$(EXT_C) $(DIR_SRC_STDIO)
vpath %$(EXT_C) $(DIR_SRC_STDLIB)
vpath %$(EXT_C) $(DIR_SRC_STRING)
vpath %$(EXT_C) $(DIR_SRC_TIME)
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
_FILES_C                  = $(foreach dir,$(PATH_SRC_CORE_LIBC),$(wildcard $(PATH_SRC_CORE_LIBC)*$(EXT_C)))
_FILES_C_CTYPE            = $(foreach dir,$(DIR_SRC_CTYPE),$(wildcard $(DIR_SRC_CTYPE)*$(EXT_C)))
_FILES_C_LOCALE           = $(foreach dir,$(DIR_SRC_LOCALE),$(wildcard $(DIR_SRC_LOCALE)*$(EXT_C)))
_FILES_C_MATH             = $(foreach dir,$(DIR_SRC_MATH),$(wildcard $(DIR_SRC_MATH)*$(EXT_C)))
_FILES_C_SIGNAL           = $(foreach dir,$(DIR_SRC_SIGNAL),$(wildcard $(DIR_SRC_SIGNAL)*$(EXT_C)))
_FILES_C_STDIO            = $(foreach dir,$(DIR_SRC_STDIO),$(wildcard $(DIR_SRC_STDIO)*$(EXT_C)))
_FILES_C_STDLIB           = $(foreach dir,$(DIR_SRC_STDLIB),$(wildcard $(DIR_SRC_STDLIB)*$(EXT_C)))
_FILES_C_STRING           = $(foreach dir,$(DIR_SRC_STRING),$(wildcard $(DIR_SRC_STRING)*$(EXT_C)))
_FILES_C_TIME             = $(foreach dir,$(DIR_SRC_TIME),$(wildcard $(DIR_SRC_TIME)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_C_REL              = $(notdir $(_FILES_C))
_FILES_C_REL_CTYPE        = $(notdir $(_FILES_C_CTYPE))
_FILES_C_REL_LOCALE       = $(notdir $(_FILES_C_LOCALE))
_FILES_C_REL_MATH         = $(notdir $(_FILES_C_MATH))
_FILES_C_REL_SIGNAL       = $(notdir $(_FILES_C_SIGNAL))
_FILES_C_REL_STDIO        = $(notdir $(_FILES_C_STDIO))
_FILES_C_REL_STDLIB       = $(notdir $(_FILES_C_STDLIB))
_FILES_C_REL_STRING       = $(notdir $(_FILES_C_STRING))
_FILES_C_REL_TIME         = $(notdir $(_FILES_C_TIME))

# Replace the code extension by the object one
_FILES_C_OBJ              = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL))
_FILES_C_OBJ_CTYPE        = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_CTYPE))
_FILES_C_OBJ_LOCALE       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_LOCALE))
_FILES_C_OBJ_MATH         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_MATH))
_FILES_C_OBJ_SIGNAL       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_SIGNAL))
_FILES_C_OBJ_STDIO        = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STDIO))
_FILES_C_OBJ_STDLIB       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STDLIB))
_FILES_C_OBJ_STRING       = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_STRING))
_FILES_C_OBJ_TIME         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_TIME))

# Prefix all binary files with the build directory
_FILES_C_OBJ_BUILD        = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_CTYPE  = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_CTYPE))
_FILES_C_OBJ_BUILD_LOCALE = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_LOCALE))
_FILES_C_OBJ_BUILD_MATH   = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_MATH))
_FILES_C_OBJ_BUILD_SIGNAL = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_SIGNAL))
_FILES_C_OBJ_BUILD_STDIO  = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_STDIO))
_FILES_C_OBJ_BUILD_STDLIB = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_STDLIB))
_FILES_C_OBJ_BUILD_STRING = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_STRING))
_FILES_C_OBJ_BUILD_TIME   = $(addprefix $(PATH_BUILD_32_CORE_LIBC),$(_FILES_C_OBJ_TIME))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS: $(PATH_BUILD_64_CORE_LIBC)%$(EXT_C)$(EXT_OBJ)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_CTYPE) $(_FILES_C_OBJ_BUILD_LOCALE) $(_FILES_C_OBJ_BUILD_MATH) $(_FILES_C_OBJ_BUILD_SIGNAL) $(_FILES_C_OBJ_BUILD_STDIO) $(_FILES_C_OBJ_BUILD_STDLIB) $(_FILES_C_OBJ_BUILD_STRING) $(_FILES_C_OBJ_BUILD_TIME)
	
# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_LIBC)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_LIBC)*
	
# Compiles a C file (64 bits)
$(PATH_BUILD_64_CORE_LIBC)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64) -o $(PATH_BUILD_64_CORE_LIBC)$(@F) -c $(abspath $<)

# Targets with second expansion
.SECONDEXPANSION:

# Compiles a C file (32 bits)
$(PATH_BUILD_32_CORE_LIBC)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_LIBC),$(PATH_BUILD_64_CORE_LIBC),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32) -o $(PATH_BUILD_32_CORE_LIBC)$(@F) -c $(abspath $<)
