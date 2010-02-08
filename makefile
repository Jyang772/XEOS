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
ARGS_EMU            = -boot order=a -M $(MACHINE) -cpu $(CPU) -vga $(VGA) -smp $(SMP) -m $(RAM) -soundhw $(SOUND)

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build/
DIR_BUILD_BIN       = $(DIR_BUILD)bin/
DIR_BUILD_BIN_BOOT	= $(DIR_BUILD_BIN)boot/
DIR_BUILD_BIN_CORE	= $(DIR_BUILD_BIN)core/
DIR_BUILD_OBJ       = $(DIR_BUILD)obj/
DIR_BUILD_OBJ_BOOT	= $(DIR_BUILD_OBJ)boot/
DIR_BUILD_OBJ_CORE	= $(DIR_BUILD_OBJ)core/
DIR_BUILD_MNT       = $(DIR_BUILD)mount/
DIR_BUILD_REL       = $(DIR_BUILD)release/
DIR_RES             = ./res/
DIR_SRC             = ./src/
DIR_SRC_BOOT        = $(DIR_SRC)boot/
DIR_SRC_BOOT_INC    = $(DIR_SRC_BOOT)include/
DIR_SRC_CORE        = $(DIR_SRC)core/
DIR_SRC_CORE_INC    = $(DIR_SRC_CORE)include/
DIR_SW              = ./sw/

#-------------------------------------------------------------------------------
# Resources
#-------------------------------------------------------------------------------

FLOPPY              = xeos.flp
FLOPPY_IN           = $(DIR_RES)$(FLOPPY)
FLOPPY_OUT          = $(DIR_BUILD_REL)$(FLOPPY)
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
.PHONY: all clean test boot core cross _mbr _mount _copy _umount

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: boot core _mbr _mount _copy _umount
	
# Tests the OS by launching the emulator
test:
	@echo "    *** Launching the emulator"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(EMU) $(ARGS_EMU) -fda $(FLOPPY_OUT))
	@$(EMU) $(ARGS_EMU) -fda $(FLOPPY_OUT)

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_BIN_BOOT)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BIN_BOOT)*
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_BIN_CORE)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_BIN_CORE)*
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_BOOT)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_BOOT)*
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_CORE)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD_OBJ_CORE)*

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
	
# Copies the MBR to the floppy image
_mbr:
	@echo "    *** Copying empty floppy image ($(FLOPPY_IN)) to the build directory ($(DIR_BUILD_MNT))"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CP) $(ARGS_CP) $(FLOPPY_IN) $(FLOPPY_OUT))
	@$(CP) $(ARGS_CP) $(FLOPPY_IN) $(FLOPPY_OUT)
	@echo "    *** Copying the bootloader ($(DIR_BUILD_BIN_BOOT)$(MBR)) into the installation floppy MBR ($(FLOPPY_OUT))"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(DD) $(ARGS_DD) if=$(DIR_BUILD_BIN_BOOT)$(MBR) of=$(FLOPPY_OUT))
	@$(DD) $(ARGS_DD) if=$(DIR_BUILD_BIN_BOOT)$(MBR) of=$(FLOPPY_OUT)

# Mounts the floppy drive image
_mount:
	@echo "    *** Mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(MOUNT) $(ARGS_MOUNT) \`$(HDID) $(ARGS_HDID) $(FLOPPY_OUT)\` $(DIR_BUILD_MNT))
	@$(MOUNT) $(ARGS_MOUNT) `$(HDID) $(ARGS_HDID) $(FLOPPY_OUT)` $(DIR_BUILD_MNT)

# Copy the build files to the floppy drive
_copy:
	@echo "    *** Copying the build files to the floppy drive"
	$(if $(filter 1,$(DEBUG)), @echo "        --- for bin in $(DIR_BUILD_BIN_BOOT)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done")
	@for bin in $(DIR_BUILD_BIN_BOOT)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done

# Un-mounts the floppy drive image
_umount:
	@echo "    *** Un-mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(UMOUNT) $(DIR_BUILD_MNT))
	@$(UMOUNT) $(DIR_BUILD_MNT)
	@sudo killall -SIGKILL diskimages-helper

