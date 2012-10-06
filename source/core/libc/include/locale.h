/*******************************************************************************
 * XEOS - X86 Experimental Operating System
 * 
 * Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
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

#ifndef __LIBC_LOCALE_H__
#define __LIBC_LOCALE_H__
#pragma once

#include <private/__null.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Describes formatting of monetary and other numeric values
 */
struct lconv
{
    /**
     * Decimal point for non-monetary values
     */
    char * decimal_point;
    
    /**
     * Sizes of digit groups for non-monetary values
     */
    char * grouping;
    
    /**
     * Separator for digit groups for non-monetary values
     * (left of "decimal point")
     */
    char * thousands_sep;
    
    /**
     * Currency symbol
     */
    char * currency_symbol;
    
    /**
     * International currency symbol
     */
    char * int_curr_symbol;
    
    /**
     * Decimal point for monetary values
     */
    char * mon_decimal_point;
    
    /**
     * Sizes of digit groups for monetary values
     */
    char * mon_grouping;
    
    /**
     * Separator for digit groups for monetary values (left of "decimal point")
     */
    char * mon_thousands_sep;
    
    /**
     * Negative sign for monetary values
     */
    char * negative_sign;
    
    /**
     * Positive sign for monetary values
     */
    char * positive_sign;
    
    /**
     * Number of digits to be displayed to right of "decimal point" for monetary
     * values
     */
    char frac_digits;
    
    /**
     * Number of digits to be displayed to right of "decimal point" for
     * international monetary values
     */
    char int_frac_digits;
    
    /**
     * Whether currency symbol precedes (1) or follows (0) negative monetary
     * values
     */
    char n_cs_precedes;
    
    /**
     * Whether currency symbol is (1) or is not (0) separated by space from
     * negative monetary values
     */
    char n_sep_by_space;
    
    /**
     * Format for negative monetary values:
     * 
     *      - 0     parentheses surround quantity and currency symbol
     *      - 1     sign precedes quantity and currency symbol
     *      - 2     sign follows quantity and currency symbol
     *      - 3     sign immediately precedes currency symbol
     *      - 4     sign immediately follows currency symbol
     */
    char n_sign_posn;
    
    /**
     * Whether currency symbol precedes (1) or follows (0) positive monetary
     * values
     */
    char p_cs_precedes;
    
    /**
     * Whether currency symbol is (1) or is not (0) separated by space from
     * non-negative monetary values
     */
    char p_sep_by_space;
    
    /**
     * Format for non-negative monetary values, with values as for n_sign_posn
     */
    char p_sign_posn;
};

/**
 * Returns pointer to formatting information for current locale
 */
struct lconv * localeconv( void );

/**
 * Sets components of locale according to specified category and locale.
 * Returns string describing new locale or null on error. (Implementations are
 * permitted to define values of category additional to those describe here.)
 */
char * setlocale( int category, const char * locale );

/**
 * Category argument for all categories
 */
#define LC_ALL      0x01

/**
 * Category for numeric formatting information
 */
#define LC_NUMERIC  0x02

/**
 * Category for monetary formatting information
 */
#define LC_MONETARY 0x03

/**
 * Category for information affecting collating functions
 */
#define LC_COLLATE  0x04

/**
 * Category for information affecting character class tests functions
 */
#define LC_CTYPE    0x05

/**
 * Category for information affecting time conversions functions
 */
#define LC_TIME     0x06

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_LOCALE_H__ */
