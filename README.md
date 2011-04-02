XEOS - X86 Experimental Operating System
========================================

About XEOS
----------

XEOS is an experimental 32 bits Operating System for x86 platforms, written in Assembly and C, including a C89 Standard Library (with some C99 parts).

Its main purpose is educationnal, and to provide people interested in OS development with a clean code base.

License
-------

XEOS is be released under the BSD License.

Installation
------------

### Requirements

In order to be built, XEOS needs a custom version of the GNU compiler (GCC).
The reason for this is that the compilers available by default on standard systems may only compile executables of a specific format.
For instance, you won't be able to build ELF on Mac OS X, nor Mach-O executables on Linux.

Additionally, the default compilers will usually automatically link with the standard C library that is available on the running system.
As XEOS is itself an operating system, it won't be able to use such a library.

So the first step, in order to compile XEOS, is to compile the compiler that will be able to compile it...
And of course, a version of GCC needs to be available on your system in order to compile another version of GCC.
It may seems funny, but don't worry: everything has been prepared for you.

### Building the compiler

A specific version of GCC has been prepared, and is included in the XEOS sources.
You need to compile and install it, before compiling XEOS.

From a terminal window, you need to cd to XEOS trunk's directory.
Then, type the following command:
    
    make cross
    
It will unpack and build everything that's needed to compile XEOS.
Everything will be installed in the «/usr/local/xeos/» directory, so you can easily clean everything up when needed.

The tools that will be installed are:

 - Binutils 2.20 - The GNU collection of binary tools
 - GMP 4.3.2 - The GNU multiple precision arithmetic library
 - MPFR 2.4.2 - The GNU multiple-precision floating-point computations with correct rounding library
 - GCC 4.4.3 - The GNU compiler collection
 - QEMU 0.12.2 - A generic and open source machine emulator and virtualizer
 
 The build process may take some time. But once it's done, you are ready to compile and use XEOS.
 
 ### Compiling
 
Compiling XEOS is a very simple task.
From the trunk's directory, simple type the following command:
    
    make
    
It will generate a FAT-12 floppy disk image containing the full OS, that you can run on any x86 machine or emulator.

### 4. Running XEOS

XEOS can be run with the QEMU emulator, which was automatically installed when building the compiler.
In order to launch it simply type, from the trunk's directory:
    
    make test
    
This will launch QEMU, which will boot from the XEOS floppy drive.
Enjoy!
