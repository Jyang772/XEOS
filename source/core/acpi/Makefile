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

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" SRC  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" CORE "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" ACPI "$(COLOR_NONE)"]> *** "

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_SRC_ACPI                            = $(PATH_SRC_CORE_ACPI)acpi/
DIR_SRC_OSL                             = $(PATH_SRC_CORE_ACPI)osl/
DIR_SRC_ACPICA                          = $(PATH_SRC_CORE_ACPI)acpica/source/
DIR_SRC_ACPICA_COMPONENTS               = $(DIR_SRC_ACPICA)components/
DIR_SRC_ACPICA_COMPONENTS_DEBUGGER      = $(DIR_SRC_ACPICA_COMPONENTS)debugger/
DIR_SRC_ACPICA_COMPONENTS_DISASSEMBLER  = $(DIR_SRC_ACPICA_COMPONENTS)disassembler/
DIR_SRC_ACPICA_COMPONENTS_DISPATCHER    = $(DIR_SRC_ACPICA_COMPONENTS)dispatcher/
DIR_SRC_ACPICA_COMPONENTS_EVENTS        = $(DIR_SRC_ACPICA_COMPONENTS)events/
DIR_SRC_ACPICA_COMPONENTS_EXECUTER      = $(DIR_SRC_ACPICA_COMPONENTS)executer/
DIR_SRC_ACPICA_COMPONENTS_HARDWARE      = $(DIR_SRC_ACPICA_COMPONENTS)hardware/
DIR_SRC_ACPICA_COMPONENTS_NAMESPACE     = $(DIR_SRC_ACPICA_COMPONENTS)namespace/
DIR_SRC_ACPICA_COMPONENTS_PARSER        = $(DIR_SRC_ACPICA_COMPONENTS)parser/
DIR_SRC_ACPICA_COMPONENTS_RESOURCES     = $(DIR_SRC_ACPICA_COMPONENTS)resources/
DIR_SRC_ACPICA_COMPONENTS_TABLES        = $(DIR_SRC_ACPICA_COMPONENTS)tables/
DIR_SRC_ACPICA_COMPONENTS_UTILITIES     = $(DIR_SRC_ACPICA_COMPONENTS)utilities/

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_CC_32          := -iquote $(PATH_SRC_CORE_ACPI)include $(ARGS_CC_32)
ARGS_CC_64          := -iquote $(PATH_SRC_CORE_ACPI)include $(ARGS_CC_64)
ARGS_CC_32_OSL      := $(ARGS_CC_32)
ARGS_CC_64_OSL      := $(ARGS_CC_64)
ARGS_CC_32_ACPICA   := -include acpica-clang-warnings.h -iquote $(PATH_SRC_CORE_ACPI)include/acpica $(ARGS_CC_32)
ARGS_CC_64_ACPICA   := -include acpica-clang-warnings.h -iquote $(PATH_SRC_CORE_ACPI)include/acpica $(ARGS_CC_64)

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Define the search paths for source files
vpath %$(EXT_C) $(DIR_SRC_ACPI)
vpath %$(EXT_C) $(DIR_SRC_OSL)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_DEBUGGER)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_DISASSEMBLER)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_DISPATCHER)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_EVENTS)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_EXECUTER)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_HARDWARE)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_NAMESPACE)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_PARSER)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_RESOURCES)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_TABLES)
vpath %$(EXT_C) $(DIR_SRC_ACPICA_COMPONENTS_UTILITIES)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_C) $(EXT_H) $(EXT_OBJ) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every code file in the source directory
_FILES_C_ACPI                                       = $(foreach dir,$(DIR_SRC_ACPI),$(wildcard $(DIR_SRC_ACPI)*$(EXT_C)))
_FILES_C_OSL                                        = $(foreach dir,$(DIR_SRC_OSL),$(wildcard $(DIR_SRC_OSL)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_DEBUGGER                 = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_DEBUGGER),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_DEBUGGER)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_DISASSEMBLER             = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_DISASSEMBLER),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_DISASSEMBLER)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_DISPATCHER               = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_DISPATCHER),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_DISPATCHER)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_EVENTS                   = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_EVENTS),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_EVENTS)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_EXECUTER                 = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_EXECUTER),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_EXECUTER)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_HARDWARE                 = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_HARDWARE),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_HARDWARE)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_NAMESPACE                = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_NAMESPACE),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_NAMESPACE)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_PARSER                   = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_PARSER),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_PARSER)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_RESOURCES                = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_RESOURCES),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_RESOURCES)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_TABLES                   = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_TABLES),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_TABLES)*$(EXT_C)))
_FILES_C_ACPICA_COMPONENTS_UTILITIES                = $(foreach dir,$(DIR_SRC_ACPICA_COMPONENTS_UTILITIES),$(wildcard $(DIR_SRC_ACPICA_COMPONENTS_UTILITIES)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_C_REL_ACPI                                   = $(notdir $(_FILES_C_ACPI))
_FILES_C_REL_OSL                                    = $(notdir $(_FILES_C_OSL))
_FILES_C_REL_ACPICA_COMPONENTS_DEBUGGER             = $(notdir $(_FILES_C_ACPICA_COMPONENTS_DEBUGGER))
_FILES_C_REL_ACPICA_COMPONENTS_DISASSEMBLER         = $(notdir $(_FILES_C_ACPICA_COMPONENTS_DISASSEMBLER))
_FILES_C_REL_ACPICA_COMPONENTS_DISPATCHER           = $(notdir $(_FILES_C_ACPICA_COMPONENTS_DISPATCHER))
_FILES_C_REL_ACPICA_COMPONENTS_EVENTS               = $(notdir $(_FILES_C_ACPICA_COMPONENTS_EVENTS))
_FILES_C_REL_ACPICA_COMPONENTS_EXECUTER             = $(notdir $(_FILES_C_ACPICA_COMPONENTS_EXECUTER))
_FILES_C_REL_ACPICA_COMPONENTS_HARDWARE             = $(notdir $(_FILES_C_ACPICA_COMPONENTS_HARDWARE))
_FILES_C_REL_ACPICA_COMPONENTS_NAMESPACE            = $(notdir $(_FILES_C_ACPICA_COMPONENTS_NAMESPACE))
_FILES_C_REL_ACPICA_COMPONENTS_PARSER               = $(notdir $(_FILES_C_ACPICA_COMPONENTS_PARSER))
_FILES_C_REL_ACPICA_COMPONENTS_RESOURCES            = $(notdir $(_FILES_C_ACPICA_COMPONENTS_RESOURCES))
_FILES_C_REL_ACPICA_COMPONENTS_TABLES               = $(notdir $(_FILES_C_ACPICA_COMPONENTS_TABLES))
_FILES_C_REL_ACPICA_COMPONENTS_UTILITIES            = $(notdir $(_FILES_C_ACPICA_COMPONENTS_UTILITIES))

# Replace the code extension by the object one
_FILES_C_OBJ_ACPI                                   = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPI))
_FILES_C_OBJ_OSL                                    = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_OSL))
_FILES_C_OBJ_ACPICA_COMPONENTS_DEBUGGER             = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_DEBUGGER))
_FILES_C_OBJ_ACPICA_COMPONENTS_DISASSEMBLER         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_DISASSEMBLER))
_FILES_C_OBJ_ACPICA_COMPONENTS_DISPATCHER           = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_DISPATCHER))
_FILES_C_OBJ_ACPICA_COMPONENTS_EVENTS               = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_EVENTS))
_FILES_C_OBJ_ACPICA_COMPONENTS_EXECUTER             = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_EXECUTER))
_FILES_C_OBJ_ACPICA_COMPONENTS_HARDWARE             = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_HARDWARE))
_FILES_C_OBJ_ACPICA_COMPONENTS_NAMESPACE            = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_NAMESPACE))
_FILES_C_OBJ_ACPICA_COMPONENTS_PARSER               = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_PARSER))
_FILES_C_OBJ_ACPICA_COMPONENTS_RESOURCES            = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_RESOURCES))
_FILES_C_OBJ_ACPICA_COMPONENTS_TABLES               = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_TABLES))
_FILES_C_OBJ_ACPICA_COMPONENTS_UTILITIES            = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_ACPICA_COMPONENTS_UTILITIES))

# Prefix all binary files with the build directory
_FILES_C_OBJ_BUILD_ACPI                             = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI),$(_FILES_C_OBJ_ACPI))
_FILES_C_OBJ_BUILD_OSL                              = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_OSL),$(_FILES_C_OBJ_OSL))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DEBUGGER       = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_DEBUGGER))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DISASSEMBLER   = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_DISASSEMBLER))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DISPATCHER     = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_DISPATCHER))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_EVENTS         = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_EVENTS))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_EXECUTER       = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_EXECUTER))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_HARDWARE       = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_HARDWARE))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_NAMESPACE      = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_NAMESPACE))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_PARSER         = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_PARSER))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_RESOURCES      = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_RESOURCES))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_TABLES         = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_TABLES))
_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_UTILITIES      = $(addprefix $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(_FILES_C_OBJ_ACPICA_COMPONENTS_UTILITIES))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean osl acpica

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS: $(PATH_BUILD_64_CORE_OBJ_ACPI)%$(EXT_C)$(EXT_OBJ) $(PATH_BUILD_64_CORE_OBJ_ACPI_OSL)%$(EXT_C)$(EXT_OBJ) $(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA)%$(EXT_C)$(EXT_OBJ)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_C_OBJ_BUILD_ACPI) osl acpica
    
	@:

# Build OSL (OS Services Layer)
osl: $(_FILES_C_OBJ_BUILD_OSL)
    
	@:

# Build the full project
acpica: $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DEBUGGER) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DISASSEMBLER) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_DISPATCHER) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_EVENTS) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_EXECUTER) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_HARDWARE) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_NAMESPACE) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_PARSER) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_RESOURCES) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_TABLES) $(_FILES_C_OBJ_BUILD_ACPICA_COMPONENTS_UTILITIES)
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 32 bits ]: "$(COLOR_GRAY)"libacpi.a"$(COLOR_NONE)
	@$(AR_32) $(ARGS_AR_32) $(PATH_BUILD_32_CORE_LIB)libacpi.a $(PATH_BUILD_32_CORE_OBJ_ACPI)* $(PATH_BUILD_32_CORE_OBJ_ACPI_OSL)* $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA)*
	@$(RANLIB_32) $(PATH_BUILD_32_CORE_LIB)libacpi.a
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 64 bits ]: "$(COLOR_GRAY)"libacpi.a"$(COLOR_NONE)
	@$(AR_64) $(ARGS_AR_64) $(PATH_BUILD_64_CORE_LIB)libacpi.a $(PATH_BUILD_64_CORE_OBJ_ACPI)* $(PATH_BUILD_64_CORE_OBJ_ACPI_OSL)* $(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA)*
	@$(RANLIB_64) $(PATH_BUILD_64_CORE_LIB)libacpi.a

# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_OBJ_ACPI)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_OBJ_ACPI)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_OBJ_ACPI_OSL)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_OBJ_ACPI_OSL)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA)*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA)*
	
# Compiles a C file (64 bits)
$(PATH_BUILD_64_CORE_OBJ_ACPI)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64) -o $(PATH_BUILD_64_CORE_OBJ_ACPI)$(@F) -c $(abspath $<)
	
# Compiles a C file (64 bits) / OSL
$(PATH_BUILD_64_CORE_OBJ_ACPI_OSL)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64_OSL) -o $(PATH_BUILD_64_CORE_OBJ_ACPI_OSL)$(@F) -c $(abspath $<)
	
# Compiles a C file (64 bits) / ACPICA
$(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64_ACPICA) -o $(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA)$(@F) -c $(abspath $<)

# Targets with second expansion
.SECONDEXPANSION:

# Compiles a C file (32 bits)
$(PATH_BUILD_32_CORE_OBJ_ACPI)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_OBJ_ACPI),$(PATH_BUILD_64_CORE_OBJ_ACPI),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32) -o $(PATH_BUILD_32_CORE_OBJ_ACPI)$(@F) -c $(abspath $<)

# Compiles a C file (32 bits) / OSL
$(PATH_BUILD_32_CORE_OBJ_ACPI_OSL)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_OBJ_ACPI_OSL),$(PATH_BUILD_64_CORE_OBJ_ACPI_OSL),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32_OSL) -o $(PATH_BUILD_32_CORE_OBJ_ACPI_OSL)$(@F) -c $(abspath $<)

# Compiles a C file (32 bits) / ACPICA
$(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA),$(PATH_BUILD_64_CORE_OBJ_ACPI_ACPICA),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32_ACPICA) -o $(PATH_BUILD_32_CORE_OBJ_ACPI_ACPICA)$(@F) -c $(abspath $<)
