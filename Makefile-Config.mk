#-------------------------------------------------------------------------------
# Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
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
# General
#-------------------------------------------------------------------------------

# Targets / Architectures

TARGET_ABI_MACHO                        := macho
TARGET_32_MACHO                         := i386
TARGET_64_MACHO                         := x86_64
TARGET_32_MARCH_MACHO                   := i386
TARGET_64_MARCH_MACHO                   := x86-64
TARGET_32_TRIPLE_MACHO                  := i386-apple-darwin
TARGET_64_TRIPLE_MACHO                  := x86_64-apple-darwin

TARGET_ABI_ELF                          := elf
TARGET_32_ELF                           := i386
TARGET_64_ELF                           := x86_64
TARGET_32_MARCH_ELF                     := i386
TARGET_64_MARCH_ELF                     := x86-64
TARGET_32_TRIPLE_ELF                    := i386-elf-freebsd
TARGET_64_TRIPLE_ELF                    := x86_64-elf-freebsd

TARGET_ABI_EFI                          := efi
TARGET_32_EFI                           := i386
TARGET_64_EFI                           := x86_64
TARGET_32_MARCH_EFI                     := i386
TARGET_64_MARCH_EFI                     := x86-64
TARGET_32_TRIPLE_EFI                    := i386-efi-pe
TARGET_64_TRIPLE_EFI                    := x86_64-efi-pe

TARGET_ABI                              := $(TARGET_ABI_ELF)
TARGET_32                               := $(TARGET_32_ELF)
TARGET_64                               := $(TARGET_64_ELF)
TARGET_32_MARCH                         := $(TARGET_32_MARCH_ELF)
TARGET_64_MARCH                         := $(TARGET_64_MARCH_ELF)
TARGET_32_TRIPLE                        := $(TARGET_32_TRIPLE_ELF)
TARGET_64_TRIPLE                        := $(TARGET_64_TRIPLE_ELF)

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

# Toolchain

PATH_TOOLCHAIN                          := /usr/local/xeos-build/

# Toolchain software

PATH_TOOLCHAIN_YASM                     := $(PATH_TOOLCHAIN)yasm/
PATH_TOOLCHAIN_GMP                      := $(PATH_TOOLCHAIN)gmp/
PATH_TOOLCHAIN_MPFR                     := $(PATH_TOOLCHAIN)mpfr/
PATH_TOOLCHAIN_BINUTILS                 := $(PATH_TOOLCHAIN)binutils/
PATH_TOOLCHAIN_CMAKE                    := $(PATH_TOOLCHAIN)cmake/
PATH_TOOLCHAIN_LLVM                     := $(PATH_TOOLCHAIN)llvm/

# Project root directories

PATH_PROJECT                            := $(realpath $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))))/
PATH_BUILD                              := $(PATH_PROJECT)build/
PATH_RELEASE                            := $(PATH_PROJECT)release/
PATH_SRC                                := $(PATH_PROJECT)source/
PATH_SW                                 := $(PATH_PROJECT)software-deps/

# Build directories

PATH_BUILD_BOOT                         := $(PATH_BUILD)boot/
PATH_BUILD_BOOT_BIOS                    := $(PATH_BUILD_BOOT)bios/
PATH_BUILD_BOOT_UEFI                    := $(PATH_BUILD_BOOT)uefi/
PATH_BUILD_TMP                          := $(PATH_BUILD)tmp/
PATH_BUILD_MOUNT                        := $(PATH_BUILD)mount/
PATH_BUILD_32                           := $(PATH_BUILD)$(TARGET_32)/
PATH_BUILD_64                           := $(PATH_BUILD)$(TARGET_64)/
PATH_BUILD_32_CORE                      := $(PATH_BUILD_32)core/
PATH_BUILD_64_CORE                      := $(PATH_BUILD_64)core/
PATH_BUILD_32_CORE_BIN                  := $(PATH_BUILD_32_CORE)bin/
PATH_BUILD_64_CORE_BIN                  := $(PATH_BUILD_64_CORE)bin/
PATH_BUILD_32_CORE_OBJ                  := $(PATH_BUILD_32_CORE)obj/
PATH_BUILD_64_CORE_OBJ                  := $(PATH_BUILD_64_CORE)obj/
PATH_BUILD_32_CORE_OBJ_KERNEL           := $(PATH_BUILD_32_CORE_OBJ)xeos/
PATH_BUILD_64_CORE_OBJ_KERNEL           := $(PATH_BUILD_64_CORE_OBJ)xeos/
PATH_BUILD_32_LIB                       := $(PATH_BUILD_32)lib/
PATH_BUILD_64_LIB                       := $(PATH_BUILD_64)lib/
PATH_BUILD_32_LIB_BIN                   := $(PATH_BUILD_32_LIB)bin/
PATH_BUILD_64_LIB_BIN                   := $(PATH_BUILD_64_LIB)bin/
PATH_BUILD_32_LIB_OBJ                   := $(PATH_BUILD_32_LIB)obj/
PATH_BUILD_64_LIB_OBJ                   := $(PATH_BUILD_64_LIB)obj/
PATH_BUILD_32_LIB_OBJ_LIBC              := $(PATH_BUILD_32_LIB_OBJ)c99/
PATH_BUILD_64_LIB_OBJ_LIBC              := $(PATH_BUILD_64_LIB_OBJ)c99/
PATH_BUILD_32_LIB_OBJ_LIBSYSTEM         := $(PATH_BUILD_32_LIB_OBJ)system/
PATH_BUILD_64_LIB_OBJ_LIBSYSTEM         := $(PATH_BUILD_64_LIB_OBJ)system/
PATH_BUILD_32_LIB_OBJ_LIBPOSIX          := $(PATH_BUILD_32_LIB_OBJ)posix/
PATH_BUILD_64_LIB_OBJ_LIBPOSIX          := $(PATH_BUILD_64_LIB_OBJ)posix/
PATH_BUILD_32_LIB_OBJ_LIBPTHREAD        := $(PATH_BUILD_32_LIB_OBJ)pthread/
PATH_BUILD_64_LIB_OBJ_LIBPTHREAD        := $(PATH_BUILD_64_LIB_OBJ)pthread/
PATH_BUILD_32_LIB_OBJ_LIBACPI           := $(PATH_BUILD_32_LIB_OBJ)acpi/
PATH_BUILD_64_LIB_OBJ_LIBACPI           := $(PATH_BUILD_64_LIB_OBJ)acpi/
PATH_BUILD_32_LIB_OBJ_LIBACPI_ACPICA    := $(PATH_BUILD_32_LIB_OBJ)acpi-acpica/
PATH_BUILD_64_LIB_OBJ_LIBACPI_ACPICA    := $(PATH_BUILD_64_LIB_OBJ)acpi-acpica/
PATH_BUILD_32_LIB_OBJ_LIBACPI_OSL       := $(PATH_BUILD_32_LIB_OBJ)acpi-osl/
PATH_BUILD_64_LIB_OBJ_LIBACPI_OSL       := $(PATH_BUILD_64_LIB_OBJ)acpi-osl/

# Source directories

PATH_SRC_INC                            := $(PATH_SRC)include/
PATH_SRC_BOOT                           := $(PATH_SRC)boot/
PATH_SRC_BOOT_BIOS                      := $(PATH_SRC_BOOT)bios/
PATH_SRC_BOOT_UEFI                      := $(PATH_SRC_BOOT)uefi/
PATH_SRC_CORE                           := $(PATH_SRC)core/
PATH_SRC_CORE_KERNEL                    := $(PATH_SRC_CORE)xeos/
PATH_SRC_LIB                            := $(PATH_SRC)lib/
PATH_SRC_LIB_LIBC                       := $(PATH_SRC_LIB)c99/
PATH_SRC_LIB_LIBSYSTEM                  := $(PATH_SRC_LIB)system/
PATH_SRC_LIB_LIBPOSIX                   := $(PATH_SRC_LIB)posix/
PATH_SRC_LIB_LIBPTHREAD                 := $(PATH_SRC_LIB)pthread/
PATH_SRC_LIB_LIBACPI                    := $(PATH_SRC_LIB)acpi/

# Release directories

PATH_RELEASE_CDROM                      := $(PATH_RELEASE)cdrom/
PATH_RELEASE_FLOPPY                     := $(PATH_RELEASE)floppy/

#-------------------------------------------------------------------------------
# File extensions
#-------------------------------------------------------------------------------

EXT_ASM                                 := .s
EXT_ASM_32                              := 32.s
EXT_ASM_64                              := 64.s
EXT_C                                   := .c
EXT_H                                   := .h
EXT_OBJ                                 := .o
EXT_OBJ_PIC                             := .o-pic
EXT_BIN_RAW                             := .BIN
EXT_BIN                                 := .$(TARGET_ABI)

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

# Assembler

AS                                      := $(PATH_TOOLCHAIN_YASM)bin/yasm
AS_32                                   := $(AS)
AS_64                                   := $(AS)

# Linker

LD_MACHO_32                             := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_MACHO)/bin/ld
LD_MACHO_64                             := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_64_TRIPLE_MACHO)/bin/ld
LD_ELF_32                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_ELF)/bin/ld
LD_ELF_64                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_64_TRIPLE_ELF)/bin/ld
LD_EFI_32                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_EFI)/bin/ld
LD_EFI_64                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_64_TRIPLE_EFI)/bin/ld
LD_32                                   := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE)/bin/ld
LD_64                                   := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_64_TRIPLE)/bin/ld

# C compiler

CC                                      := $(PATH_TOOLCHAIN_LLVM)bin/clang
CC_32                                   := $(CC)
CC_64                                   := $(CC)

# Archiver

AR_MACHO_32                             := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_MACHO)/bin/ar
AR_MACHO_64                             := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_MACHO)/bin/ar
AR_ELF_32                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_ELF)/bin/ar
AR_ELF_64                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_ELF)/bin/ar
AR_EFI_32                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_EFI)/bin/ar
AR_EFI_64                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_EFI)/bin/ar
AR_32                                   := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE)/bin/ar
AR_64                                   := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE)/bin/ar

RANLIB_MACHO_32                         := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_MACHO)/bin/ranlib
RANLIB_MACHO_64                         := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_MACHO)/bin/ranlib
RANLIB_ELF_32                           := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_ELF)/bin/ranlib
RANLIB_ELF_64                           := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_ELF)/bin/ranlib
RANLIB_EFI_32                           := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_EFI)/bin/ranlib
RANLIB_EFI_64                           := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE_EFI)/bin/ranlib
RANLIB_32                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE)/bin/ranlib
RANLIB_64                               := $(PATH_TOOLCHAIN_BINUTILS)$(TARGET_32_TRIPLE)/bin/ranlib

# Utilities

MAKE                                    := make
CMAKE                                   := $(PATH_TOOLCHAIN_CMAKE)bin/cmake
CD                                      := cd
MV                                      := mv
CP                                      := cp
RM                                      := rm
TAR                                     := tar
SUDO                                    := sudo
SVN                                     := svn
DD                                      := dd
EXEC                                    := exec
PRINT                                   := echo
MKDIR                                   := mkdir
PATCH                                   := patch
TOUCH                                   := touch
SOURCE                                  := source
PYTHON                                  := python

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

# C compiler warning flags

ARGS_CC_WARN                            := -Weverything -Werror
ARGS_CC_STD                             := -std=c99
ARGS_CC_CONST                           := -D __XEOS__ -D _POSIX_C_SOURCE=200809L -U __FreeBSD__ -U __FreeBSD_kernel__
ARGS_CC_INC                             := -I $(PATH_SRC_INC)
ARGS_CC_MISC                            := -Os -nostdlib -fno-builtin
ARGS_CC_PIC                             := -fPIC

ARGS_CC_TARGET_MACHO_32                 := -march=$(TARGET_32_MARCH_MACHO) -target $(TARGET_32_TRIPLE_MACHO)
ARGS_CC_TARGET_MACHO_54                 := -march=$(TARGET_64_MARCH_MACHO) -target $(TARGET_64_TRIPLE_MACHO)
ARGS_CC_TARGET_ELF_32                   := -march=$(TARGET_32_MARCH_ELF) -target $(TARGET_32_TRIPLE_ELF)
ARGS_CC_TARGET_ELF_64                   := -march=$(TARGET_64_MARCH_ELF) -target $(TARGET_64_TRIPLE_ELF)
ARGS_CC_TARGET_EFI_32                   := -march=$(TARGET_32_MARCH_EFI) -target $(TARGET_32_TRIPLE_EFI)
ARGS_CC_TARGET_EFI_64                   := -march=$(TARGET_64_MARCH_EFI) -target $(TARGET_64_TRIPLE_EFI)
ARGS_CC_TARGET_32                       := -march=$(TARGET_32_MARCH) -target $(TARGET_32_TRIPLE)
ARGS_CC_TARGET_64                       := -march=$(TARGET_64_MARCH) -target $(TARGET_64_TRIPLE)

ARGS_CC_MACHO_32                        := $(ARGS_CC_TARGET_MACHO_32) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_MACHO_64                        := $(ARGS_CC_TARGET_MACHO_64) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_ELF_32                          := $(ARGS_CC_TARGET_ELF_32) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_ELF_64                          := $(ARGS_CC_TARGET_ELF_64) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_EFI_32                          := $(ARGS_CC_TARGET_EFI_32) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_EFI_64                          := $(ARGS_CC_TARGET_EFI_64) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_32                              := $(ARGS_CC_TARGET_32) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)
ARGS_CC_64                              := $(ARGS_CC_TARGET_64) $(ARGS_CC_MISC) $(ARGS_CC_INC) $(ARGS_CC_STD) $(ARGS_CC_WARN) $(ARGS_CC_CONST)

# Linker flags

ARGS_LD_32                              := -z max-page-size=0x1000 -s
ARGS_LD_64                              := -z max-page-size=0x1000 -s
ARGS_LD_SHARED_32                       := -z max-page-size=0x1000 -s --shared
ARGS_LD_SHARED_64                       := -z max-page-size=0x1000 -s --shared

# Archiver flags

ARGS_AR_32                              := rcs
ARGS_AR_64                              := rcs

# Assembler flags

ARGS_AS_32                              := -f $(TARGET_ABI)
ARGS_AS_64                              := -f $(TARGET_ABI)64

# Utilities

ARGS_MAKE_CLEAN                         := clean
ARGS_MAKE_BUILD                         := all
ARGS_MAKE_INSTALL                       := install
ARGS_CP                                 := 
ARGS_RM                                 := -rf
ARGS_DD                                 := conv=notrunc
ARGS_HDID                               := -nobrowse -nomount
ARGS_TAR_EXPAND                         := -xf
ARGS_SVN_CO                             := checkout

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

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

COLOR_NONE                              := "\x1b[0m"
COLOR_GRAY                              := "\x1b[30;01m"
COLOR_RED                               := "\x1b[31;01m"
COLOR_GREEN                             := "\x1b[32;01m"
COLOR_YELLOW                            := "\x1b[33;01m"
COLOR_BLUE                              := "\x1b[34;01m"
COLOR_PURPLE                            := "\x1b[35;01m"
COLOR_CYAN                              := "\x1b[36;01m"

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------

XEOS_FUNC_S_SRC                         = $(foreach dir,$(1),$(wildcard $(1)*$(EXT_ASM_32)))
XEOS_FUNC_S_SRC_REL                     = $(notdir $(call XEOS_FUNC_S_SRC,$(1)))
XEOS_FUNC_S_OBJ_REL                     = $(subst $(EXT_ASM_32),$(EXT_ASM_32)$(EXT_OBJ),$(call XEOS_FUNC_S_SRC_REL,$(1)))
XEOS_FUNC_S_OBJ                         = $(addprefix $(1),$(call XEOS_FUNC_S_OBJ_REL,$(2)))

XEOS_FUNC_C_SRC                         = $(foreach dir,$(1),$(wildcard $(1)*$(EXT_C)))
XEOS_FUNC_C_SRC_REL                     = $(notdir $(call XEOS_FUNC_C_SRC,$(1)))
XEOS_FUNC_C_OBJ_REL                     = $(subst $(EXT_C),$(EXT_C)$(EXT_OBJ),$(call XEOS_FUNC_C_SRC_REL,$(1)))
XEOS_FUNC_C_OBJ                         = $(addprefix $(1),$(call XEOS_FUNC_C_OBJ_REL,$(2)))

#-------------------------------------------------------------------------------
# Targets with second expansion
#-------------------------------------------------------------------------------

# Declaration for precious targets, to avoid cleaning of intermediate files
.PRECIOUS:  $(PATH_BUILD_64)%$(EXT_ASM_64)$(EXT_OBJ_PIC)    \
            $(PATH_BUILD_64)%$(EXT_ASM_64)$(EXT_OBJ)        \
            $(PATH_BUILD_32)%$(EXT_ASM_32)$(EXT_OBJ_PIC)    \
            $(PATH_BUILD_64)%$(EXT_C)$(EXT_OBJ_PIC)         \
            $(PATH_BUILD_64)%$(EXT_C)$(EXT_OBJ)             \
            $(PATH_BUILD_32)%$(EXT_C)$(EXT_OBJ_PIC)

.SECONDEXPANSION:

# Compiles an assembly file (64 bits - PIC)
$(PATH_BUILD_64)%$(EXT_ASM_64)$(EXT_OBJ_PIC): $$(notdir $$(subst $(EXT_OBJ_PIC),,$$@))
	
	@$(PRINT) $(PROMPT)"Compiling assembly file [ 64 bits - PIC ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(AS_64) $(ARGS_AS_64) -o $@ $(abspath $<)

# Compiles an assembly file (64 bits)
$(PATH_BUILD_64)%$(EXT_ASM_64)$(EXT_OBJ): $$(notdir $$(subst $(EXT_OBJ),,$$@)) $$(subst $(EXT_OBJ),$(EXT_OBJ_PIC),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling assembly file [ 64 bits       ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(AS_64) $(ARGS_AS_64) -o $@ $(abspath $<)

# Compiles an assembly file (32 bits - PIC)
$(PATH_BUILD_32)%$(EXT_ASM_32)$(EXT_OBJ_PIC): $$(notdir $$(subst $(EXT_OBJ_PIC),,$$@))
	
	@$(PRINT) $(PROMPT)"Compiling assembly file [ 32 bits - PIC ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(AS_32) $(ARGS_AS_32) -o $@ $(abspath $<)

# Compiles an assembly file (32 bits)
$(PATH_BUILD_32)%$(EXT_ASM_32)$(EXT_OBJ): $$(notdir $$(subst $(EXT_OBJ),,$$@)) $$(subst $(EXT_OBJ),$(EXT_OBJ_PIC),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling assembly file [ 32 bits       ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(AS_32) $(ARGS_AS_32) -o $@ $(abspath $<)
	@if [ -f $(abspath $(subst $(EXT_ASM_32),$(EXT_ASM_64),$<)) ]; then $(MAKE) $(subst $(PATH_BUILD_32),$(PATH_BUILD_64),$(subst $(EXT_ASM_32),$(EXT_ASM_64),$@)); fi

# Compiles a C file (64 bits - PIC)
$(PATH_BUILD_64)%$(EXT_C)$(EXT_OBJ_PIC): $$(notdir $$(subst $(EXT_OBJ_PIC),,$$@))
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits - PIC ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_PIC) $(ARGS_CC_64) -o $@ -c $(abspath $<)

# Compiles a C file (64 bits)
$(PATH_BUILD_64)%$(EXT_C)$(EXT_OBJ): $$(notdir $$(subst $(EXT_OBJ),,$$@)) $$(subst $(EXT_OBJ),$(EXT_OBJ_PIC),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 64 bits       ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_64) $(ARGS_CC_64) -o $@ -c $(abspath $<)

# Compiles a C file (32 bits - PIC)
$(PATH_BUILD_32)%$(EXT_C)$(EXT_OBJ_PIC): $$(notdir $$(subst $(EXT_OBJ_PIC),,$$@))
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits - PIC ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_PIC) $(ARGS_CC_32) -o $@ -c $(abspath $<)

# Compiles a C file (32 bits)
$(PATH_BUILD_32)%$(EXT_C)$(EXT_OBJ): $$(notdir $$(subst $(EXT_OBJ),,$$@)) $$(subst $(PATH_BUILD_32),$(PATH_BUILD_64),$$@) $$(subst $(EXT_OBJ),$(EXT_OBJ_PIC),$$@)
	
	@$(PRINT) $(PROMPT)"Compiling C file [ 32 bits       ]: "$(COLOR_YELLOW)"$(notdir $< )"$(COLOR_NONE)" -> "$(COLOR_GRAY)"$(notdir $@)"$(COLOR_NONE)
	@$(CC_32) $(ARGS_CC_32) -o $@ -c $(abspath $<)
