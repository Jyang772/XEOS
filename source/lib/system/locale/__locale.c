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

#include <system/locale.h>
#include <system/__private/locale.h>
#include <stdlib.h>

#define __PAD_CHAR_4 { 0, 0, 0, 0 }

static int __System_Locale_DefaultLocale_Collate_Entries[] =
{
    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
    0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
    0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
    0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
    0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F
};

static int __System_Locale_DefaultLocale_Collate_Upper[] =
{
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
};

static int __System_Locale_DefaultLocale_Collate_Lower[] =
{
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y', 'z'
};

static int __System_Locale_DefaultLocale_Collate_Digit[] =
{
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
};

static int __System_Locale_DefaultLocale_Collate_Space[] =
{
    0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x20
};

static int __System_Locale_DefaultLocale_Collate_Control[] =
{
    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
    0x7F
};

static int __System_Locale_DefaultLocale_Collate_Punct[] =
{
    '!', '"', '#', '$', '%', '&', '\'', '(',
    ')', '*', '+', ',', '-', '.', '/', ':',
    ';', '<', '=', '>', '?', '@', '[', '\\',
    ']', '^', '_', '`', '{', '|', '}', '~'
};

static int __System_Locale_DefaultLocale_Collate_XDigit[] =
{
    '0', '1', '2', '3', '4', '5', '6', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F',
    'a', 'b', 'c', 'd', 'e', 'f'
};

static int __System_Locale_DefaultLocale_Collate_Blank[] =
{
    0x20, 0x09
};

static int __System_Locale_DefaultLocale_Collate_ToUpper[][ 2 ] =
{
    { 'a', 'A' },
    { 'b', 'B' },
    { 'c', 'C' },
    { 'd', 'D' },
    { 'e', 'E' },
    { 'f', 'F' },
    { 'g', 'G' },
    { 'h', 'H' },
    { 'i', 'I' },
    { 'j', 'J' },
    { 'k', 'K' },
    { 'l', 'L' },
    { 'm', 'M' },
    { 'n', 'N' },
    { 'o', 'O' },
    { 'p', 'P' },
    { 'q', 'Q' },
    { 'r', 'R' },
    { 's', 'S' },
    { 't', 'T' },
    { 'u', 'U' },
    { 'v', 'V' },
    { 'w', 'W' },
    { 'x', 'X' },
    { 'y', 'Y' },
    { 'z', 'Z' }
};

static int __System_Locale_DefaultLocale_Collate_ToLower[][ 2 ] =
{
    { 'A', 'a' },
    { 'B', 'b' },
    { 'C', 'c' },
    { 'D', 'd' },
    { 'E', 'e' },
    { 'F', 'f' },
    { 'G', 'g' },
    { 'H', 'h' },
    { 'I', 'i' },
    { 'J', 'j' },
    { 'K', 'k' },
    { 'L', 'l' },
    { 'M', 'm' },
    { 'N', 'n' },
    { 'O', 'o' },
    { 'P', 'p' },
    { 'Q', 'q' },
    { 'R', 'r' },
    { 'S', 's' },
    { 'T', 't' },
    { 'U', 'u' },
    { 'V', 'v' },
    { 'W', 'w' },
    { 'X', 'x' },
    { 'Y', 'y' },
    { 'Z', 'z' }
};

static struct __System_Locale_Collate __System_Locale_DefaultLocale_Collate =
{
    sizeof( __System_Locale_DefaultLocale_Collate_Entries ) / 4,
    __System_Locale_DefaultLocale_Collate_Entries
};

static struct __System_Locale_CType __System_Locale_DefaultLocale_CType =
{
    __System_Locale_DefaultLocale_Collate_Upper,
    __System_Locale_DefaultLocale_Collate_Lower,
    __System_Locale_DefaultLocale_Collate_Digit,
    __System_Locale_DefaultLocale_Collate_Space,
    __System_Locale_DefaultLocale_Collate_Control,
    __System_Locale_DefaultLocale_Collate_Punct,
    __System_Locale_DefaultLocale_Collate_XDigit,
    __System_Locale_DefaultLocale_Collate_Blank,
    __System_Locale_DefaultLocale_Collate_ToUpper,
    __System_Locale_DefaultLocale_Collate_ToLower,
    0x20,
    __PAD_CHAR_4,
    sizeof( __System_Locale_DefaultLocale_Collate_Upper )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Lower )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Digit )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Space )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Control ) / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Punct )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_XDigit )  / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_Blank )   / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_ToUpper ) / 4,
    sizeof( __System_Locale_DefaultLocale_Collate_ToLower ) / 4
};

static struct __System_Locale_Messages __System_Locale_DefaultLocale_Messages =
{
    "^[yY]",
    "^[nN]"
};

static struct __System_Locale_Monetary __System_Locale_DefaultLocale_Monetary =
{
    "",
    "",
    "",
    "",
    "",
    "",
    "-1",
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
};

static struct __System_Locale_Numeric __System_Locale_DefaultLocale_Numeric =
{
    ".",
    "",
    "-1"
};

static struct __System_Locale_Time __System_Locale_DefaultLocale_Time =
{
    {
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat"
    },
    {
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    },
    {
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dev"
    },
    {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    },
    {
        "AM",
        "PM"
    },
    "%a %b %e %H:%M:%S %Y",
    "%m/%d/%y",
    "%H:%M:%S",
    "%I:%M:%S %p"
};

locale_t __System_Locale_DefaultLocale =
{
    "C",
    &__System_Locale_DefaultLocale_Collate,
    &__System_Locale_DefaultLocale_CType,
    &__System_Locale_DefaultLocale_Messages,
    &__System_Locale_DefaultLocale_Monetary,
    &__System_Locale_DefaultLocale_Numeric,
    &__System_Locale_DefaultLocale_Time,
};
