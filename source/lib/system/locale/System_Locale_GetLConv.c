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

#include <locale.h>
#include <system/locale.h>
#include <system/__private/locale.h>
#include <stdlib.h>
#include <limits.h>

bool                __System_Locale_LocalConvNeedUpdate = true;
static struct lconv __lconv;

struct lconv * System_Locale_GetLConv( void )
{
    System_LocaleRef            locale;
    System_Locale_NumericRef    numeric;
    System_Locale_MonetaryRef   monetary;
    
    if( __System_Locale_LocalConvNeedUpdate == true )
    {
        __System_Locale_LocalConvNeedUpdate = false;
        locale                              = System_Locale_GetCurrentLocale();
        numeric                             = System_Locale_GetNumeric( locale );
        monetary                            = System_Locale_GetMonetary( locale );
        
        __lconv.decimal_point   = ( char * )( numeric->decimal_point );
        __lconv.thousands_sep   = ( char * )( numeric->thousands_sep );
        __lconv.grouping        = ( char * )( numeric->grouping );
        
        __lconv.mon_decimal_point   = ( char * )( monetary->mon_decimal_point );
        __lconv.mon_thousands_sep   = ( char * )( monetary->mon_thousands_sep );
        __lconv.mon_grouping        = ( char * )( monetary->mon_grouping );
        __lconv.positive_sign       = ( char * )( monetary->positive_sign );
        __lconv.negative_sign       = ( char * )( monetary->negative_sign );
        __lconv.currency_symbol     = ( char * )( monetary->currency_symbol );
        __lconv.int_curr_symbol     = ( char * )( monetary->int_curr_symbol );
        
        __lconv.frac_digits         = ( monetary->frac_digits           == - 1 ) ? CHAR_MAX : ( char )( monetary->frac_digits );
        __lconv.p_cs_precedes       = ( monetary->p_cs_precedes         == - 1 ) ? CHAR_MAX : ( char )( monetary->p_cs_precedes );
        __lconv.n_cs_precedes       = ( monetary->n_cs_precedes         == - 1 ) ? CHAR_MAX : ( char )( monetary->n_cs_precedes );
        __lconv.p_sep_by_space      = ( monetary->p_sep_by_space        == - 1 ) ? CHAR_MAX : ( char )( monetary->p_sep_by_space );
        __lconv.n_sep_by_space      = ( monetary->n_sep_by_space        == - 1 ) ? CHAR_MAX : ( char )( monetary->n_sep_by_space );
        __lconv.p_sign_posn         = ( monetary->p_sign_posn           == - 1 ) ? CHAR_MAX : ( char )( monetary->p_sign_posn );
        __lconv.n_sign_posn         = ( monetary->n_sign_posn           == - 1 ) ? CHAR_MAX : ( char )( monetary->n_sign_posn );
        __lconv.int_frac_digits     = ( monetary->int_frac_digits       == - 1 ) ? CHAR_MAX : ( char )( monetary->int_frac_digits );
        __lconv.int_p_cs_precedes   = ( monetary->int_p_cs_precedes     == - 1 ) ? CHAR_MAX : ( char )( monetary->int_p_cs_precedes );
        __lconv.int_n_cs_precedes   = ( monetary->int_n_cs_precedes     == - 1 ) ? CHAR_MAX : ( char )( monetary->int_n_cs_precedes );
        __lconv.int_p_sep_by_space  = ( monetary->int_p_sep_by_space    == - 1 ) ? CHAR_MAX : ( char )( monetary->int_p_sep_by_space );
        __lconv.int_n_sep_by_space  = ( monetary->int_n_sep_by_space    == - 1 ) ? CHAR_MAX : ( char )( monetary->int_n_sep_by_space );
        __lconv.int_p_sign_posn     = ( monetary->int_p_sign_posn       == - 1 ) ? CHAR_MAX : ( char )( monetary->int_p_sign_posn );
        __lconv.int_n_sign_posn     = ( monetary->int_n_sign_posn       == - 1 ) ? CHAR_MAX : ( char )( monetary->int_n_sign_posn );
    }
    
    return &__lconv;
}
