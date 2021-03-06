/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
 * All rights reserved.
 * 
 * XEOS Software License - Version 1.0 - December 21, 2012
 * 
 * Permission is hereby granted, free of charge, to any person or organisation
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to deal in the Software, with or without
 * modification, without restriction, including without limitation the rights
 * to use, execute, display, copy, reproduce, transmit, publish, distribute,
 * modify, merge, prepare derivative works of the Software, and to permit
 * third-parties to whom the Software is furnished to do so, all subject to the
 * following conditions:
 * 
 *      1.  Redistributions of source code, in whole or in part, must retain the
 *          above copyright notice and this entire statement, including the
 *          above license grant, this restriction and the following disclaimer.
 * 
 *      2.  Redistributions in binary form must reproduce the above copyright
 *          notice and this entire statement, including the above license grant,
 *          this restriction and the following disclaimer in the documentation
 *          and/or other materials provided with the distribution, unless the
 *          Software is distributed by the copyright owner as a library.
 *          A "library" means a collection of software functions and/or data
 *          prepared so as to be conveniently linked with application programs
 *          (which use some of those functions and data) to form executables.
 * 
 *      3.  The Software, or any substancial portion of the Software shall not
 *          be combined, included, derived, or linked (statically or
 *          dynamically) with software or libraries licensed under the terms
 *          of any GNU software license, including, but not limited to, the GNU
 *          General Public License (GNU/GPL) or the GNU Lesser General Public
 *          License (GNU/LGPL).
 * 
 *      4.  All advertising materials mentioning features or use of this
 *          software must display an acknowledgement stating that the product
 *          includes software developed by the copyright owner.
 * 
 *      5.  Neither the name of the copyright owner nor the names of its
 *          contributors may be used to endorse or promote products derived from
 *          this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
 * 
 * IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
 * THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

/* $Id$ */

/*!
 * @file            XEOS_HAL_CPU_SoftwareInterrupt.c
 * @author          Jean-David Gadina
 * @copyright       (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
 */

#include <xeos/hal/cpu.h>

#define __XEOS_HAL_CPU_GENT_INT( _n_ )  __asm__ __volatile__( "int $0x" # _n_ )

#define __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( _n_ )                       \
                                                                        \
    case 0x ## _n_ ## 0: __XEOS_HAL_CPU_GENT_INT( _n_ ## 0 ); break;    \
    case 0x ## _n_ ## 1: __XEOS_HAL_CPU_GENT_INT( _n_ ## 1 ); break;    \
    case 0x ## _n_ ## 2: __XEOS_HAL_CPU_GENT_INT( _n_ ## 2 ); break;    \
    case 0x ## _n_ ## 3: __XEOS_HAL_CPU_GENT_INT( _n_ ## 3 ); break;    \
    case 0x ## _n_ ## 4: __XEOS_HAL_CPU_GENT_INT( _n_ ## 4 ); break;    \
    case 0x ## _n_ ## 5: __XEOS_HAL_CPU_GENT_INT( _n_ ## 5 ); break;    \
    case 0x ## _n_ ## 6: __XEOS_HAL_CPU_GENT_INT( _n_ ## 6 ); break;    \
    case 0x ## _n_ ## 7: __XEOS_HAL_CPU_GENT_INT( _n_ ## 7 ); break;    \
    case 0x ## _n_ ## 8: __XEOS_HAL_CPU_GENT_INT( _n_ ## 8 ); break;    \
    case 0x ## _n_ ## 9: __XEOS_HAL_CPU_GENT_INT( _n_ ## 9 ); break;    \
    case 0x ## _n_ ## A: __XEOS_HAL_CPU_GENT_INT( _n_ ## A ); break;    \
    case 0x ## _n_ ## B: __XEOS_HAL_CPU_GENT_INT( _n_ ## B ); break;    \
    case 0x ## _n_ ## C: __XEOS_HAL_CPU_GENT_INT( _n_ ## C ); break;    \
    case 0x ## _n_ ## D: __XEOS_HAL_CPU_GENT_INT( _n_ ## D ); break;    \
    case 0x ## _n_ ## E: __XEOS_HAL_CPU_GENT_INT( _n_ ## E ); break;    \
    case 0x ## _n_ ## F: __XEOS_HAL_CPU_GENT_INT( _n_ ## F ); break

void XEOS_HAL_CPU_SoftwareInterrupt( uint8_t n )
{
    switch( n )
    {
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 0 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 1 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 2 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 3 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 4 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 5 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 6 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 7 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 8 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( 9 );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( A );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( B );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( C );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( D );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( E );
        __XEOS_HAL_CPU_GENT_INT_CASE_GROUP( F );
        
        default: break;
    }
}
