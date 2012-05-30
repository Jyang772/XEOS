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
# Build settings
#-------------------------------------------------------------------------------

PREFIX              = /usr/local/xeos-llvm

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

RM                  = rm
TAR                 = tar
MAKE                = make
SVN                 = svn

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_RM             = -rf
ARGS_TAR            = -xf
ARGS_MAKE           = 
ARGS_SVN_CO         = checkout

#-------------------------------------------------------------------------------
# Source repositories
#-------------------------------------------------------------------------------

REPOS_LLVM          = http://llvm.org/svn/llvm-project/llvm/trunk
REPOS_CLANG         = http://llvm.org/svn/llvm-project/cfe/trunk

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_LLVM            = ./src/llvm/
DIR_CLANG           = $(DIR_LLVM)clang

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: llvm_co clang_co llvm_build

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD)*

# LLVM checkout
llvm_co:
	@echo "    *** Checking out LLVM sources"
	@$(SVN) $(ARGS_SVN_CO) $(REPOS_LLVM) $(DIR_LLVM)

# Clang checkout
clang_co:
	@echo "    *** Checking out Clang sources"
	@$(SVN) $(ARGS_SVN_CO) $(REPOS_CLANG) $(DIR_CLANG)

# LLVM build
llvm_build:
	@echo "    *** Building LLVM toolchain"
