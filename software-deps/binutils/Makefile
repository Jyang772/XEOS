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

include ../../Makefile-Config.mk

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)"  SW  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" BIN  "$(COLOR_NONE)"]>           *** "

#-------------------------------------------------------------------------------
# Software versions
#-------------------------------------------------------------------------------

VERSION_BINUTILS    := 2.22

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           := $(realpath ./build/)/
DIR_BUILD_32        := $(DIR_BUILD)$(TARGET_32)/
DIR_BUILD_64        := $(DIR_BUILD)$(TARGET_64)/
DIR_SRC             := $(realpath ./source/)/
DIR_SRC_BINUTILS    := $(DIR_SRC)binutils-$(VERSION_BINUTILS)
DIR_DISTRIB         := $(realpath ./distrib/)/
DISTRIB_BINUTILS    := $(DIR_DISTRIB)binutils-$(VERSION_BINUTILS).tar.bz2

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean binutils_32 binutils_64

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: binutils_32 binutils_64

# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD_32)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_64)*
	
	@$(PRINT) $(PROMPT)"Cleaning all temporary files"
	@$(RM) $(ARGS_RM) $(DIR_SRC)*

# Builds GNU/BinUtils / 32 bits
binutils_32:
	
	@$(PRINT) $(PROMPT)"Unpacking GNU/BinUtils ($(VERSION_BINUTILS))"
	@if [ ! -d $(DIR_SRC_BINUTILS) ]; then $(TAR) $(ARGS_TAR_EXPAND) $(DISTRIB_BINUTILS) -C $(DIR_SRC); fi
	
	@$(PRINT) $(PROMPT)"Configuring GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_32))"
	@$(CD) $(DIR_BUILD_32) && $(EXEC) $(DIR_SRC_BINUTILS)/configure --prefix=$(PATH_TOOLCHAIN_BINUTILS) --target=$(TARGET_32)-$(TARGET_ABI) --disable-nls --disable-werror
	
	@$(PRINT) $(PROMPT)"Building GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_32))"
	@$(CD) $(DIR_BUILD_32) && $(MAKE) $(ARGS_MAKE_BUILD)
	
	@$(PRINT) $(PROMPT)"Installing GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_32))"
	@$(CD) $(DIR_BUILD_32) && $(SUDO) $(MAKE) $(ARGS_MAKE_INSTALL)

# Builds GNU/BinUtils / 64 bits
binutils_64:
	
	@$(PRINT) $(PROMPT)"Unpacking GNU/BinUtils ($(VERSION_BINUTILS))"
	@if [ ! -d $(DIR_SRC_BINUTILS) ]; then $(TAR) $(ARGS_TAR_EXPAND) $(DISTRIB_BINUTILS) -C $(DIR_SRC); fi
	
	@$(PRINT) $(PROMPT)"Configuring GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_32))"
	@$(CD) $(DIR_BUILD_64) && $(EXEC) $(DIR_SRC_BINUTILS)/configure --prefix=$(PATH_TOOLCHAIN_BINUTILS) --target=$(TARGET_64)-$(TARGET_ABI) --disable-nls --disable-werror
	
	@$(PRINT) $(PROMPT)"Building GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_64))"
	@$(CD) $(DIR_BUILD_64) && $(MAKE) $(ARGS_MAKE_BUILD)
	
	@$(PRINT) $(PROMPT)"Installing GNU/BinUtils ($(VERSION_BINUTILS)) - ($(TARGET_64))"
	@$(CD) $(DIR_BUILD_64) && $(SUDO) $(MAKE) $(ARGS_MAKE_INSTALL)
