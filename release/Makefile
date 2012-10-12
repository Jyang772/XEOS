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

include ../Makefile-Config.mk

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

PROMPT              := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" DIST "$(COLOR_NONE)"]>                     *** "

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

MBR                 := $(PATH_BUILD_BOOT)MBR.BIN
BOOTLOADER          := $(PATH_BUILD_BOOT)BOOT.BIN
KERNEL32            := $(PATH_BUILD_32_CORE_BIN)XEOS32.ELF
KERNEL64            := $(PATH_BUILD_64_CORE_BIN)XEOS64.ELF
FLOPPY_DMG          := $(PATH_BUILD_TMP)boot.dmg
FLOPPY_IMG          := $(PATH_RELEASE_CDROM)boot/boot.img

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean boot_floppy_image boot_floppy

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: boot_floppy
	
	@:	

boot_floppy_image:
	
	@$(PRINT) $(PROMPT)"Creating a fresh floppy image"
	@hdiutil create -ov -type UDIF -sectors 2880 -fs "MS-DOS FAT12" -volname "XEOS" $(FLOPPY_DMG) > /dev/null
	@$(PRINT) $(PROMPT)"Installing the XEOS Master Boot Record (MBR)"
	@dd conv=notrunc if=$(MBR) of=$(FLOPPY_DMG) > /dev/null 2>&1

boot_floppy: boot_floppy_image
boot_floppy: _BOOT_FLOPPY_DEVICE = $(shell hdid -nobrowse -nomount $(FLOPPY_DMG))
boot_floppy:
	
	@$(PRINT) $(PROMPT)"Copying the XEOS boot files"
	@$(CP) $(BOOTLOADER) $(PATH_RELEASE_FLOPPY)
	@$(CP) $(KERNEL32) $(PATH_RELEASE_FLOPPY)
	@$(CP) $(KERNEL64) $(PATH_RELEASE_FLOPPY)
	
	@$(PRINT) $(PROMPT)"Attaching the boot floppy image to "$(COLOR_GRAY)$(_BOOT_FLOPPY_DEVICE)$(COLOR_NONE)
	
	@$(PRINT) $(PROMPT)"Mounting the boot floppy image"
	@mount -t msdos $(_BOOT_FLOPPY_DEVICE) $(PATH_BUILD_MOUNT)
	
	@$(PRINT) $(PROMPT)"Copying the XEOS boot files to the boot floppy"
	@cp $(PATH_RELEASE_FLOPPY)* $(PATH_BUILD_MOUNT)
	
	@$(PRINT) $(PROMPT)"Unmounting the boot floppy image"
	@umount $(_BOOT_FLOPPY_DEVICE) > /dev/null
	@hdiutil detach $(_BOOT_FLOPPY_DEVICE) > /dev/null
	
	@$(PRINT) $(PROMPT)"Converting the boot floppy image"
	@hdiutil convert -ov $(FLOPPY_DMG) -format Rdxx -o $(FLOPPY_IMG) > /dev/null

# Cleans the release files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all release files"
	@$(RM) $(ARGS_RM) $(FLOPPY_DMG)
	@$(RM) $(ARGS_RM) $(FLOPPY_IMG)
	@$(RM) $(ARGS_RM) $(PATH_RELEASE_FLOPPY)*
