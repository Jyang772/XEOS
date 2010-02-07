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

VERSION_BINUTILS    = 2.20
VERSION_GMP         = 4.3.2
VERSION_MPFR        = 2.4.2
VERSION_GCC         = 4.4.3

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_BUILD_BINUTILS  = $(DIR_BUILD)binutils/
DIR_BUILD_GMP       = $(DIR_BUILD)gmp/
DIR_BUILD_MPFR      = $(DIR_BUILD)mpfr/
DIR_BUILD_GCC       = $(DIR_BUILD)gcc/
DIR_SRC             = ./src/
SRC_BINUTILS        = $(DIR_SRC)binutils-$(VERSION_BINUTILS).tar.bz2
SRC_GMP             = $(DIR_SRC)gmp-$(VERSION_GMP).tar.bz2
SRC_MPFR            = $(DIR_SRC)mpfr-$(VERSION_MPFR).tar.gz
SRC_GCC             = $(DIR_SRC)gcc-core-$(VERSION_GCC).tar.bz2
DIR_TMP             = ./tmp/

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean binutils gmp mpfr gcc

#-------------------------------------------------------------------------------
# Shell variables
#-------------------------------------------------------------------------------

PATH                := $(PREFIX)/binutils/bin:$(PATH)
LD_LIBRARY_PATH     := $(PREFIX)/gmp/lib:$(PREFIX)/mpfr/lib:$(LD_LIBRARY_PATH)
LPATH               := $(PREFIX)/gmp/lib:$(PREFIX)/mpfr/lib:$(LPATH)
CPATH               := $(PREFIX)/gmp/include:$(PREFIX)/mpfr/include:$(CPATH)

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: binutils gmp mpfr gcc

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BINUTILS)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_GMP)*
	@$(RM) $(ARGS_RM) $(DIR_BUILD_MPFR)*
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
