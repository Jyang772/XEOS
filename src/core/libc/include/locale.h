/*******************************************************************************
 * XEOS - x86 Experimental Operating System
 * 
 * Copyright (C) 2010 Jean-David Gadina (macmade@eosgarden.com)
 * All rights reserved
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *  -   Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 *  -   Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *  -   Neither the name of 'Jean-David Gadina' nor the names of its
 *      contributors may be used to endorse or promote products derived from
 *      this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

/* $Id$ */

#ifndef __LIBC_LOCALE_H__
#define __LIBC_LOCALE_H__
#pragma once

#include "private/__null.h"

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

#endif /* __LIBC_LOCALE_H__ */
