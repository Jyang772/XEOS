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

VERSION_QEMU        = 1.1.0-rc4

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_BUILD_QEMU      = $(DIR_BUILD)qemu/
DIR_SRC             = ./src/
SRC_QEMU            = $(DIR_SRC)qemu-$(VERSION_QEMU).tar.bz2
DIR_TMP             = ./tmp/

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean qemu

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
all: qemu

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD_QEMU)*
	@echo "    *** Cleaning all temporary files"
	@$(RM) $(ARGS_RM) $(DIR_TMP)*

# Builds Quemu
qemu:
	@echo "    *** Unpacking qemu ($(VERSION_QEMU))"
	@if [ ! -d $(DIR_TMP)qemu-$(VERSION_QEMU) ]; then $(TAR) $(ARGS_TAR) $(SRC_QEMU) -C $(DIR_TMP); fi
	@echo "    *** Configuring qemu ($(VERSION_QEMU))"
	@cd $(DIR_BUILD_QEMU) && exec ../../$(DIR_TMP)qemu-$(VERSION_QEMU)/configure --prefix=$(PREFIX)/qemu --disable-sdl --enable-system --enable-user --target-list="i386-softmmu x86_64-softmmu"
	@echo "    *** Compiling qemu ($(VERSION_QEMU))"
	@cd $(DIR_BUILD_QEMU) && $(MAKE)
	@echo "    *** Installing qemu ($(VERSION_QEMU))"
	@cd $(DIR_BUILD_QEMU) && sudo $(MAKE) install
