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

#ifndef __XEOS_LIB_SYSTEM___PRIVATE_LOCALE_H__
#define __XEOS_LIB_SYSTEM___PRIVATE_LOCALE_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <system/types/size_t.h>
#include <stdbool.h>

struct __System_Locale_Collate
{
    size_t count;
    int  * entries;
};

struct __System_Locale_CType
{
    int   * upper;
    int   * lower;
    int   * digit;
    int   * space;
    int   * cntrl;
    int   * punct;
    int   * xdigit;
    int   * blank;
    int ( * toupper )[ 2 ];
    int ( * tolower )[ 2 ];
    int     space_c;
    char    __pad_0[ 4 ];
    size_t  upper_count;
    size_t  lower_count;
    size_t  digit_count;
    size_t  space_count;
    size_t  cntrl_count;
    size_t  punct_count;
    size_t  xdigit_count;
    size_t  blank_count;
    size_t  toupper_count;
    size_t  tolower_count;
};

struct __System_Locale_Messages
{
    const char * yesexpr;
    const char * noexpr;
};

struct __System_Locale_Monetary
{
    const char    * int_curr_symbol;
    const char    * currency_symbol;
    const char    * mon_decimal_point;
    const char    * mon_thousands_sep;
    const char    * positive_sign;
    const char    * negative_sign;
    const char    * mon_grouping;
    int             int_frac_digits;
    int             frac_digits;
    int             p_cs_precedes;
    int             p_sep_by_space;
    int             n_cs_precedes;
    int             n_sep_by_space;
    int             p_sign_posn;
    int             n_sign_posn;
    int             int_p_cs_precedes;
    int             int_p_sep_by_space;
    int             int_n_cs_precedes;
    int             int_n_sep_by_space;
    int             int_p_sign_posn;
    int             int_n_sign_posn;
};

struct __System_Locale_Numeric
{
    const char * decimal_point;
    const char * thousands_sep;
    const char * grouping;
};

struct __System_Locale_Time
{
    const char * abday[ 7 ];
    const char * day[ 7 ];
    const char * abmon[ 12 ];
    const char * mon[ 12 ];
    const char * am_pm[ 2 ];
    const char * d_t_fmt;
    const char * d_fmt;
    const char * t_fmt;
    const char * t_fmt_ampm;
};

struct __System_Locale
{
    const char                      * name;
    struct __System_Locale_Collate  * lc_collate;
    struct __System_Locale_CType    * lc_ctype;
    struct __System_Locale_Messages * lc_messages;
    struct __System_Locale_Monetary * lc_monetary;
    struct __System_Locale_Numeric  * lc_numeric;
    struct __System_Locale_Time     * lc_time;
};

extern struct __System_Locale __System_Locale_DefaultLocale;
extern bool                   __System_Locale_LocalConvNeedUpdate;

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_SYSTEM___PRIVATE_LOCALE_H__ */
