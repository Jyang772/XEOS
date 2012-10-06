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
DEBUG               = 1

#-------------------------------------------------------------------------------
# Emulation
#-------------------------------------------------------------------------------

CPU                 = 486
RAM                 = 16
VGA                 = std
SMP                 = 1
MACHINE             = pc
SOUND               = sb16

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

MAKE                = make
CP                  = cp
RM                  = rm
DD                  = dd
MV   				= mv
MOUNT               = sudo mount
UMOUNT              = sudo umount
HDID                = hdid
EMU                 = /usr/local/xeos-build/qemu/bin/qemu

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_MAKE           = 
ARGS_CP             = 
ARGS_RM             = -rf
ARGS_DD             = conv=notrunc
ARGS_MOUNT          = -t msdos
ARGS_HDID           = -nobrowse -nomount
ARGS_EMU            = -boot order=a -M $(MACHINE) -cpu $(CPU) -vga $(VGA) -smp $(SMP) -m $(RAM) -soundhw $(SOUND) $(ARGS_EMU_LOG)
ARGS_EMU_LOG        = -d out_asm,in_asm,op,op_opt,int,exec,cpu,pcall,cpu_reset

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/
DIR_BUILD_BIN_BOOT  = $(DIR_BUILD_BIN)boot/
DIR_BUILD_BIN_CORE  = $(DIR_BUILD_BIN)core/
DIR_BUILD_MNT       = $(DIR_BUILD)mount/
DIR_BUILD_REL       = $(DIR_BUILD)release/
DIR_RES             = ./res/
DIR_SRC             = ./src/
DIR_SRC_BOOT        = $(DIR_SRC)boot/
DIR_SRC_BOOT_INC    = $(DIR_SRC_BOOT)include/
DIR_SRC_CORE        = $(DIR_SRC)core/
DIR_SRC_CORE_INC    = $(DIR_SRC_CORE)include/
DIR_SW              = ./sw/
DIR_LLVM            = ./llvm/

#-------------------------------------------------------------------------------
# Resources
#-------------------------------------------------------------------------------

FLOPPY_NAME			= xeos
FLOPPY              = $(DIR_BUILD_REL)$(FLOPPY_NAME).flp
MBR                 = BOOT1.BIN

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES:

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean test boot core cross llvm _mbr _mount _copy _umount

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: boot core _mbr _mount _copy _umount
	
# Tests the OS by launching the emulator
test:
	@echo "    *** Launching the emulator"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(EMU) $(ARGS_EMU) -fda $(FLOPPY))
	@$(EMU) $(ARGS_EMU) -fda $(FLOPPY)

# Cleans the build files
clean:
	@cd $(DIR_SRC_BOOT) && $(MAKE) clean
	@cd $(DIR_SRC_CORE) && $(MAKE) clean
	@if [ -f $(FLOPPY) ]; then $(RM) $(FLOPPY); fi;

# Builds the boot files
boot:
	@echo "    *** Building the boot files"
	@cd $(DIR_SRC_BOOT) && $(MAKE)

# Builds the core files
core:
	@echo "    *** Building the core files"
	@cd $(DIR_SRC_CORE) && $(MAKE)

# Builds the cross-compiler
cross:
	@echo "    *** Building the cross-compiler"
	@cd $(DIR_SW) && $(MAKE)

# Builds the cross-compiler
llvm:
	@echo "    *** Building the cross-compiler"
	@cd $(DIR_LLVM) && $(MAKE)
	
# Copies the MBR to the floppy image
_mbr:
	@echo "    *** Creating empty floppy image ($(FLOPPY_NAME)) to the build directory ($(DIR_BUILD_REL))"
	@if [ -f $(FLOPPY).dmg ]; then $(RM) $(FLOPPY).dmg; fi;
	@if [ -f $(FLOPPY) ]; then $(RM) $(FLOPPY); fi;
	$(if $(filter 1,$(DEBUG)), @echo "        --- hdiutil create -size 10m -type UDIF -fs MS-DOS $(FLOPPY))"
	@hdiutil create -size 10m -type UDIF -fs MS-DOS $(FLOPPY)
	if [ -f $(FLOPPY).dmg ]; then $(MV) $(FLOPPY).dmg $(FLOPPY); fi;
	@echo "    *** Copying the bootloader ($(DIR_BUILD_BIN_BOOT)$(MBR)) into the installation floppy MBR ($(FLOPPY))"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(DD) $(ARGS_DD) if=$(DIR_BUILD_BIN_BOOT)$(MBR) of=$(FLOPPY))
	@$(DD) $(ARGS_DD) if=$(DIR_BUILD_BIN_BOOT)$(MBR) of=$(FLOPPY)

# Mounts the floppy drive image
_mount:
	@echo "    *** Mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(MOUNT) $(ARGS_MOUNT) \`$(HDID) $(ARGS_HDID) $(FLOPPY)\` $(DIR_BUILD_MNT))
	@$(MOUNT) $(ARGS_MOUNT) `$(HDID) $(ARGS_HDID) $(FLOPPY)` $(DIR_BUILD_MNT)

# Copy the build files to the floppy drive
_copy:
	@echo "    *** Copying the build files to the floppy drive"
	$(if $(filter 1,$(DEBUG)), @echo "        --- for bin in $(DIR_BUILD_BIN_BOOT)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done")
	@for bin in $(DIR_BUILD_BIN_BOOT)*; do cp -f $$bin $(DIR_BUILD_MNT); done
	$(if $(filter 1,$(DEBUG)), @echo "        --- for bin in $(DIR_BUILD_BIN_CORE)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done")
	@for bin in $(DIR_BUILD_BIN_CORE)*; do cp -f $$bin $(DIR_BUILD_MNT); done

# Un-mounts the floppy drive image
_umount:
	@echo "    *** Un-mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(UMOUNT) $(DIR_BUILD_MNT))
	@$(UMOUNT) $(DIR_BUILD_MNT)
	@sudo killall -SIGKILL diskimages-helper

