# -----------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------

# $Id$

#-------------------------------------------------------------------------------
# Debug options
#-------------------------------------------------------------------------------
DEBUG           = 1

#-------------------------------------------------------------------------------
# Emulation
#-------------------------------------------------------------------------------

CPU             = 486
RAM             = 16
VGA             = std
SMP             = 1
MACHINE         = pc
SOUND           = sb16

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

AS              = nasm
CP              = cp
RM              = rm
DD              = dd
MOUNT           = sudo mount
UMOUNT          = sudo umount
HDID            = hdid
EMU             = qemu

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_AS         = -f bin -I $(DIR_SRC_INC)
ARGS_CP         = 
ARGS_RM         = -rf
ARGS_DD         = conv=notrunc
ARGS_MOUNT      = -t msdos
ARGS_HDID       = -nobrowse -nomount
ARGS_EMU        = -boot order=a -M $(MACHINE) -cpu $(CPU) -vga $(VGA) -smp $(SMP) -m $(RAM) -soundhw $(SOUND)

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD       = ./BUILD/
DIR_BUILD_BIN   = $(DIR_BUILD)BIN/
DIR_BUILD_MNT   = $(DIR_BUILD)MNT/
DIR_RES         = ./RES/
DIR_SRC         = ./SRC/
DIR_SRC_INC     = $(DIR_SRC)INC/

#-------------------------------------------------------------------------------
# Resources
#-------------------------------------------------------------------------------

FLOPPY          = XEOS.FLP
FLOPPY_IN       = $(DIR_RES)$(FLOPPY)
FLOPPY_OUT      = $(DIR_BUILD)$(FLOPPY)
MBR				= $(DIR_BUILD_BIN)BOOT1$(EXT_BIN)

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM         = .ASM
EXT_BIN         = .BIN

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

# Define the search paths for source files
vpath %$(EXT_ASM) $(DIR_SRC)

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_ASM) $(EXT_BIN)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Gets every assembly file in the source directory
_FILES_ASM        = $(foreach dir,$(DIR_SRC),$(wildcard $(DIR_SRC)*$(EXT_ASM)))

# Gets only the file name of the assembly files
_FILES_ASM_REL    = $(notdir $(_FILES_ASM))

# Replace the code extension by the binary one
_FILES_ASM_BIN    = $(subst $(EXT_ASM),$(EXT_BIN),$(_FILES_ASM_REL))

# Prefix all binary files with the build directory
_FILES_BIN_BUILD  = $(addprefix $(DIR_BUILD_BIN),$(_FILES_ASM_BIN))

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean _build_setup  _mbr _mount _mount _copy _umount

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: _build_setup $(_FILES_BIN_BUILD) _mbr _mount _copy _umount
	
# Tests the OS by launching the emulator
test:
	@echo "    *** Launching the emulator"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(EMU) $(ARGS_EMU) -fda $(FLOPPY_OUT))
	@$(EMU) $(ARGS_EMU) -fda $(FLOPPY_OUT)

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(RM) $(ARGS_RM) $(DIR_BUILD)*)
	@$(RM) $(ARGS_RM) $(DIR_BUILD)*

# Creates the necessary directories in the build directory
_build_setup:
	@if [ ! -d $(DIR_BUILD_BIN) ]; then mkdir $(DIR_BUILD_BIN); fi
	@if [ ! -d $(DIR_BUILD_MNT) ]; then mkdir $(DIR_BUILD_MNT); fi

# Copies the MBR to the floppy image
_mbr: $(DIR_BUILD_BIN)BOOT1$(EXT_BIN)
	@echo "    *** Copying empty floppy image ($(FLOPPY_IN)) to the build directory ($(DIR_BUILD))"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(CP) $(ARGS_CP) $(FLOPPY_IN) $(FLOPPY_OUT))
	@$(CP) $(ARGS_CP) $(FLOPPY_IN) $(FLOPPY_OUT)
	@echo "    *** Copying the bootloader ($(MBR)) into the installation floppy MBR ($(FLOPPY_OUT))"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(DD) $(ARGS_DD) if=$(MBR) of=$(FLOPPY_OUT))
	@$(DD) $(ARGS_DD) if=$(MBR) of=$(FLOPPY_OUT)

# Compiles an assembly file
$(DIR_BUILD_BIN)%$(EXT_BIN): %$(EXT_ASM)
	@echo "    *** Compiling assembly file $< into $@"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(AS) $(ARGS_AS) -o $@ $<)
	@$(AS) $(ARGS_AS) -o $@ $<

# Mounts the floppy drive image
_mount:
	@echo "    *** Mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(MOUNT) $(ARGS_MOUNT) \`$(HDID) $(ARGS_HDID) $(FLOPPY_OUT)\` $(DIR_BUILD_MNT))
	@$(MOUNT) $(ARGS_MOUNT) `$(HDID) $(ARGS_HDID) $(FLOPPY_OUT)` $(DIR_BUILD_MNT)

# Copy the build files to the floppy drive
_copy: #_mount
	@echo "    *** Copying the build files to the floppy drive"
	$(if $(filter 1,$(DEBUG)), @echo "        --- for bin in $(DIR_BUILD_BIN)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done")
	@for bin in $(DIR_BUILD_BIN)*; do if [ $$bin != $(MBR) ]; then cp -f $$bin $(DIR_BUILD_MNT); fi; done

# Un-mounts the floppy drive image
_umount:
	@echo "    *** Un-mounting the floppy image"
	$(if $(filter 1,$(DEBUG)), @echo "        ---" $(UMOUNT) $(DIR_BUILD_MNT))
	@$(UMOUNT) $(DIR_BUILD_MNT)
	@sudo killall -SIGKILL diskimages-helper

