#-------------------------------------------------------------------------------
# Copyright (c) <YEAR>, <OWNER>
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
# Build settings
#-------------------------------------------------------------------------------

TARGET              = i386-elf
PREFIX              = /usr/local/xeos-build

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

RM                  = rm
TAR                 = tar
MAKE                = make

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_RM             = -rf
ARGS_TAR            = -xf
ARGS_MAKE           = 

#-------------------------------------------------------------------------------
# Software versions
#-------------------------------------------------------------------------------

VERSION_BINUTILS    = 2.21.1
VERSION_GMP         = 5.0.2
VERSION_MPFR        = 3.1.0
VERSION_MPC         = 0.9
VERSION_GCC         = 4.5.3

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_BUILD_BINUTILS  = $(DIR_BUILD)binutils/
DIR_BUILD_GMP       = $(DIR_BUILD)gmp/
DIR_BUILD_MPFR      = $(DIR_BUILD)mpfr/
DIR_BUILD_MPC       = $(DIR_BUILD)mpc/
DIR_BUILD_GCC       = $(DIR_BUILD)gcc/
DIR_SRC             = ./src/
SRC_BINUTILS        = $(DIR_SRC)binutils-$(VERSION_BINUTILS).tar.bz2
SRC_GMP             = $(DIR_SRC)gmp-$(VERSION_GMP).tar.bz2
SRC_MPFR            = $(DIR_SRC)mpfr-$(VERSION_MPFR).tar.bz2
SRC_MPC             = $(DIR_SRC)mpc-$(VERSION_MPC).tar.gz
SRC_GCC             = $(DIR_SRC)gcc-core-$(VERSION_GCC).tar.bz2
DIR_TMP             = ./tmp/

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean binutils gmp mpfr mpc gcc

#-------------------------------------------------------------------------------
# Shell variables
#-------------------------------------------------------------------------------

PATH                := $(PREFIX)/binutils/bin:$(PATH)
LD_LIBRARY_PATH     := $(PREFIX)/gmp/lib:$(PREFIX)/mpfr/lib:$(PREFIX)/mpc/lib:$(LD_LIBRARY_PATH)
LPATH               := $(PREFIX)/gmp/lib:$(PREFIX)/mpfr/lib:$(PREFIX)/mpc/lib:$(LPATH)
CPATH               := $(PREFIX)/gmp/include:$(PREFIX)/mpfr/include:$(PREFIX)/mpc/include:$(CPATH)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: binutils gmp mpfr mpc gcc

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BINUTILS)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_GMP)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_MPFR)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_MPFR).libs
	@$(RM) $(ARGS_RM) $(DIR_BUILD_MPFR).deps
	@$(RM) $(ARGS_RM) $(DIR_BUILD_GCC)*
	@echo "    *** Cleaning all temporary files"
	@$(RM) $(ARGS_RM) $(DIR_TMP)*

# Builds BinUtils
binutils:
	@echo "    *** Unpacking binutils ($(VERSION_BINUTILS))"
	@if [ ! -d $(DIR_TMP)binutils-$(VERSION_BINUTILS) ]; then $(TAR) $(ARGS_TAR) $(SRC_BINUTILS) -C $(DIR_TMP); fi
	@echo "    *** Configuring binutils ($(VERSION_BINUTILS))"
	@cd $(DIR_BUILD_BINUTILS) && exec ../../$(DIR_TMP)binutils-$(VERSION_BINUTILS)/configure --prefix=$(PREFIX)/binutils --target=$(TARGET) --disable-nls --disable-werror
	@echo "    *** Compiling binutils ($(VERSION_BINUTILS))"
	@cd $(DIR_BUILD_BINUTILS) && $(MAKE) all
	@echo "    *** Installing binutils ($(VERSION_BINUTILS))"
	@cd $(DIR_BUILD_BINUTILS) && sudo $(MAKE) install

# Builds GMP
gmp:
	@echo "    *** Unpacking gmp ($(VERSION_GMP))"
	@if [ ! -d $(DIR_TMP)gmp-$(VERSION_GMP) ]; then $(TAR) $(ARGS_TAR) $(SRC_GMP) -C $(DIR_TMP); fi
	@echo "    *** Configuring gmp ($(VERSION_GMP))"
	@cd $(DIR_BUILD_GMP) && exec ../../$(DIR_TMP)gmp-$(VERSION_GMP)/configure --prefix=$(PREFIX)/gmp
	@echo "    *** Compiling gmp ($(VERSION_GMP))"
	@cd $(DIR_BUILD_GMP) && $(MAKE)
	@echo "    *** Installing gmp ($(VERSION_GMP))"
	@cd $(DIR_BUILD_GMP) && sudo $(MAKE) install

# Builds MPFR
mpfr:
	@echo "    *** Unpacking mpfr ($(VERSION_MPFR))"
	@if [ ! -d $(DIR_TMP)mpfr-$(VERSION_MPFR) ]; then $(TAR) $(ARGS_TAR) $(SRC_MPFR) -C $(DIR_TMP); fi
	@echo "    *** Configuring mpfr ($(VERSION_MPFR))"
	@cd $(DIR_BUILD_MPFR) && exec ../../$(DIR_TMP)mpfr-$(VERSION_MPFR)/configure --prefix=$(PREFIX)/mpfr
	@echo "    *** Compiling mpfr ($(VERSION_MPFR))"
	@cd $(DIR_BUILD_MPFR) && $(MAKE)
	@echo "    *** Installing mpfr ($(VERSION_MPFR))"
	@cd $(DIR_BUILD_MPFR) && sudo $(MAKE) install

# Builds MPC
mpc:
	@echo "    *** Unpacking mpc ($(VERSION_MPC))"
	@if [ ! -d $(DIR_TMP)mpc-$(VERSION_MPC) ]; then $(TAR) $(ARGS_TAR) $(SRC_MPC) -C $(DIR_TMP); fi
	@echo "    *** Configuring mpc ($(VERSION_MPC))"
	@cd $(DIR_BUILD_MPC) && exec ../../$(DIR_TMP)mpc-$(VERSION_MPC)/configure --prefix=$(PREFIX)/mpc
	@echo "    *** Compiling mpc ($(VERSION_MPC))"
	@cd $(DIR_BUILD_MPC) && $(MAKE)
	@echo "    *** Installing mpc ($(VERSION_MPC))"
	@cd $(DIR_BUILD_MPC) && sudo $(MAKE) install

# Builds GCC & LibGCC
gcc:
	@echo "    *** Unpacking gcc ($(VERSION_GCC))"
	@if [ ! -d $(DIR_TMP)gcc-$(VERSION_GCC) ]; then $(TAR) $(ARGS_TAR) $(SRC_GCC) -C $(DIR_TMP); fi
	@echo "    *** Configuring gcc ($(VERSION_GCC))"
	@cd $(DIR_BUILD_GCC) && exec ../../$(DIR_TMP)gcc-$(VERSION_GCC)/configure --prefix=$(PREFIX)/gcc --target=$(TARGET) --disable-nls --enable-languages=c --without-headers
	@echo "    *** Compiling gcc ($(VERSION_GCC))"
	@cd $(DIR_BUILD_GCC) && $(MAKE) all-gcc
	@echo "    *** Installing gcc ($(VERSION_GCC))"
	@cd $(DIR_BUILD_GCC) && sudo $(MAKE) install-gcc
	@echo "    *** Compiling libgcc ($(VERSION_GCC))"
	@cd $(DIR_BUILD_GCC) && $(MAKE) all-target-libgcc
	@echo "    *** Installing libgcc ($(VERSION_GCC))"
	@cd $(DIR_BUILD_GCC) && sudo $(MAKE) install-target-libgcc
