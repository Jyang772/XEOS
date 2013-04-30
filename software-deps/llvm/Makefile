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

include ../../Makefile-Config.mk

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)"  SW  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" LLVM "$(COLOR_NONE)"]>           *** "

#-------------------------------------------------------------------------------
# Source repositories
#-------------------------------------------------------------------------------

REPOS_LLVM          := http://llvm.org/svn/llvm-project/llvm/trunk
REPOS_CLANG         := http://llvm.org/svn/llvm-project/cfe/trunk
REPOS_CRT           := http://llvm.org/svn/llvm-project/compiler-rt/trunk

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           := $(realpath ./build/)/
DIR_SRC             := $(realpath ./source/)/
DIR_LLVM            := $(DIR_SRC)llvm/
DIR_CLANG           := $(DIR_LLVM)tools/clang/
DIR_CRT             := $(DIR_LLVM)projects/compiler-rt/

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean llvm_co clang_co crt_co llvm_build

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: llvm_co clang_co crt_co llvm_build

	@:

# Cleans the build files
clean:

	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD)*
	@$(RM) $(ARGS_RM) $(DIR_LLVM)

# LLVM checkout
llvm_co:

	@$(PRINT) $(PROMPT)"Checking out LLVM sources"
	@if [ ! -d $(DIR_LLVM) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_LLVM) $(DIR_LLVM); fi

# Clang checkout
clang_co:
	
	@$(PRINT) $(PROMPT)"Checking out Clang sources"
	@if [ ! -d $(DIR_CLANG) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_CLANG) $(DIR_CLANG); fi

# CRT checkout
crt_co:
	
	@$(PRINT) $(PROMPT)"Checking out CRT sources"
	@if [ ! -d $(DIR_CRT) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_CRT) $(DIR_CRT); fi

# LLVM build
llvm_build:
	
	@$(PRINT) $(PROMPT)"Configuring Clang/LLVM"
	@$(CD) $(DIR_BUILD) && $(DIR_LLVM)configure --prefix=$(PATH_TOOLCHAIN_LLVM)

	@$(PRINT) $(PROMPT)"Bulding Clang/LLVM"
	@$(CD) $(DIR_BUILD) && $(MAKE)
	
	@$(PRINT) $(PROMPT)"Installing Clang/LLVM"
	@$(CD) $(DIR_BUILD) && $(SUDO) $(MAKE) $(ARGS_MAKE_INSTALL)
