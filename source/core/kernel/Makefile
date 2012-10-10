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

#-------------------------------------------------------------------------------
# Debug options
#-------------------------------------------------------------------------------
DEBUG               = 0

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

AS_32               = nasm
AS_64               = nasm
CC_32               = /usr/local/xeos-build/llvm/bin/clang
CC_64               = /usr/local/xeos-build/llvm/bin/clang
LD_32               = /usr/local/xeos-build/binutils/bin/i386-elf-ld
LD_64               = /usr/local/xeos-build/binutils/bin/x86_64-elf-ld
RM                  = rm

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_AS_32          = -f elf -I $(DIR_SRC_INC)
ARGS_AS_64          = -f elf64 -I $(DIR_SRC_INC)
ARGS_CC_32          = -iquote $(DIR_SRC_INC) -I $(DIR_INC) -march=i386 -ccc-host-triple i386-elf-freebsd -nostdlib -fno-builtin -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_CC_64          = -iquote $(DIR_SRC_INC) -I $(DIR_INC) -march=x86-64 -ccc-host-triple x86_64-elf-freebsd -nostdlib -fno-builtin -std=c89 -Wall -Wextra  -Werror -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wstrict-prototypes -Wdeclaration-after-statement
ARGS_LD_32          = 
ARGS_LD_64          = 
ARGS_RM             = -rf

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD_32        = ../../../build/core/i386/
DIR_BUILD_64        = ../../../build/core/x86_64/
DIR_BUILD_BIN_32    = $(DIR_BUILD_32)core/
DIR_BUILD_BIN_64    = $(DIR_BUILD_64)core/
DIR_BUILD_OBJ_32    = $(DIR_BUILD_32)obj/kernel/
DIR_BUILD_OBJ_64    = $(DIR_BUILD_64)obj/kernel/
DIR_SRC             = ./
DIR_SRC_INTERRUPTS  = $(DIR_SRC)interrupts/
DIR_SRC_VIDEO       = $(DIR_SRC)video/
DIR_SRC_SYSCALLS    = $(DIR_SRC)syscalls/
DIR_SRC_SYSTEM      = $(DIR_SRC)system/
DIR_SRC_INC         = $(DIR_SRC)include/
DIR_INC             = $(DIR_SRC)../include/
PATH               := /usr/local/xeos-build/binutils/i386-elf/bin:$(PATH)
PATH               := /usr/local/xeos-build/binutils/x86_64-elf/bin:$(PATH)

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM             = .s
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
vpath %$(EXT_C)   $(DIR_SRC_VIDEO)
vpath %$(EXT_C)   $(DIR_SRC_INTERRUPTS)
vpath %$(EXT_C)   $(DIR_SRC_SYSCALLS)
vpath %$(EXT_C)   $(DIR_SRC_SYSTEM)
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
_FILES_ASM                      = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_ASM)))
_FILES_C                        = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_C)))
_FILES_C_INTERRUPTS             = $(foreach dir,$(DIR_SRC_INTERRUPTS),$(wildcard $(DIR_SRC_INTERRUPTS)*$(EXT_C)))
_FILES_C_VIDEO                  = $(foreach dir,$(DIR_SRC_VIDEO),$(wildcard $(DIR_SRC_VIDEO)*$(EXT_C)))
_FILES_C_SYSCALLS               = $(foreach dir,$(DIR_SRC_SYSCALLS),$(wildcard $(DIR_SRC_SYSCALLS)*$(EXT_C)))
_FILES_C_SYSTEM                 = $(foreach dir,$(DIR_SRC_SYSTEM),$(wildcard $(DIR_SRC_SYSTEM)*$(EXT_C)))

# Gets only the file name of the code files
_FILES_ASM_REL                  = $(notdir $(_FILES_ASM))
_FILES_C_REL                    = $(notdir $(_FILES_C))
_FILES_C_REL_INTERRUPTS         = $(notdir $(_FILES_C_INTERRUPTS))
_FILES_C_REL_VIDEO              = $(notdir $(_FILES_C_VIDEO))
_FILES_C_REL_SYSCALLS           = $(notdir $(_FILES_C_SYSCALLS))
_FILES_C_REL_SYSTEM             = $(notdir $(_FILES_C_SYSTEM))

# Replace the code extension by the object one
_FILES_ASM_OBJ                  = $(subst $(EXT_ASM),$(EXT_ASM)$(EXT_OBJ),$(_FILES_ASM_REL))
_FILES_C_OBJ                    = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL))
_FILES_C_OBJ_INTERRUPTS         = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_INTERRUPTS))
_FILES_C_OBJ_VIDEO              = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_VIDEO))
_FILES_C_OBJ_SYSCALLS           = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_SYSCALLS))
_FILES_C_OBJ_SYSTEM             = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(_FILES_C_REL_SYSTEM))

# Prefix all binary files with the build directory
_FILES_ASM_OBJ_BUILD            = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_ASM_OBJ))
_FILES_C_OBJ_BUILD              = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_C_OBJ))
_FILES_C_OBJ_BUILD_INTERRUPTS   = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_C_OBJ_INTERRUPTS))
_FILES_C_OBJ_BUILD_VIDEO        = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_C_OBJ_VIDEO))
_FILES_C_OBJ_BUILD_SYSCALLS     = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_C_OBJ_SYSCALLS))
_FILES_C_OBJ_BUILD_SYSTEM       = $(addprefix $(DIR_BUILD_OBJ_32),$(_FILES_C_OBJ_SYSTEM))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS: $(DIR_BUILD_OBJ_64)%$(EXT_C)$(EXT_OBJ) $(DIR_BUILD_OBJ_64)%$(EXT_ASM)$(EXT_OBJ)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: $(_FILES_ASM_OBJ_BUILD) $(_FILES_C_OBJ_BUILD) $(_FILES_C_OBJ_BUILD_INTERRUPTS) $(_FILES_C_OBJ_BUILD_VIDEO) $(_FILES_C_OBJ_BUILD_SYSCALLS) $(_FILES_C_OBJ_BUILD_SYSTEM)
	
# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_32)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_32)*
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_64)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_64)*
	
# Compiles an assembly file (64 bits)
$(DIR_BUILD_OBJ_64)%$(EXT_ASM)$(EXT_OBJ): %$(EXT_ASM)
	@echo "    *** Compiling assembly file (64 bits) $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $(DIR_BUILD_OBJ_64)$(@F) $<)
	@$(AS_64) $(ARGS_AS_64) -o $(DIR_BUILD_OBJ_64)$(@F) $(abspath $<)
	
# Compiles a C file (64 bits)
$(DIR_BUILD_OBJ_64)%$(EXT_C)$(EXT_OBJ): %$(EXT_C)
	@echo "    *** Compiling C file (64 bits) $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CC_64) $(ARGS_CC_64) -o $(DIR_BUILD_OBJ_64)$(@F) -c $<)
	@$(CC_64) $(ARGS_CC_64) -o $(DIR_BUILD_OBJ_64)$(@F) -c $(abspath $<)

# Targets with second expansion
.SECONDEXPANSION:

# Compiles an assembly file (32 bits)
$(DIR_BUILD_OBJ_32)%$(EXT_ASM)$(EXT_OBJ): %$(EXT_ASM) $$(subst $(DIR_BUILD_32),$(DIR_BUILD_64),$$@)
	@echo "    *** Compiling assembly file (32 bits) $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $(DIR_BUILD_OBJ_32)$(@F) $<)
	@$(AS_32) $(ARGS_AS_32) -o $(DIR_BUILD_OBJ_32)$(@F) $(abspath $<)
    
# Compiles a C file (32 bits)
$(DIR_BUILD_OBJ_32)%$(EXT_C)$(EXT_OBJ): %$(EXT_C) $$(subst $(DIR_BUILD_32),$(DIR_BUILD_64),$$@)
	@echo "    *** Compiling C file (32 bits) $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CC_32) $(ARGS_CC_32) -o $(DIR_BUILD_OBJ_32)$(@F) -c $<)
	@$(CC_32) $(ARGS_CC_32) -o $(DIR_BUILD_OBJ_32)$(@F) -c $(abspath $<)
