/*******************************************************************************
 * Copyright (c) <YEAR>, <OWNER>
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

#ifndef __LIBC_TIME_H__
#define __LIBC_TIME_H__
#pragma once

#include <private/__null.h>
#include <private/__size_t.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * The number of clock_t units per second.
 */
#define CLOCKS_PER_SEC 1000

/**
 * An arithmetic type elapsed processor representing time.
 */
typedef unsigned int clock_t;

/**
 * An arithmetic type representing calendar time.
 */
typedef unsigned long time_t;

/**
 * Represents the components of calendar time.
 * Implementations may change field order and include additional fields.
 */
struct tm
{
    int tm_sec;     /* Seconds after the minute */
    int tm_min;     /* minutes after the hour */
    int tm_hour;    /* hours since midnight */
    int tm_mday;    /* day of the month */
    int tm_mon;     /* months since January */
    int tm_year;    /* years since 1900 */
    int tm_wday;    /* days since Sunday */
    int tm_yday;    /* days since January 1 */
    int tm_isdst;   /* Daylight Saving Time flag : is positive if DST is in
                       effect, zero if not in effect, negative if information
                       not known. */
};

/**
 * Returns elapsed processor time used by program or -1 if not available.
 */
clock_t clock( void );

/**
 * Returns current calendar time or -1 if not available. If tp is non-NULL,
 * return value is also assigned to * tp.
 */
time_t time( time_t * tp );

/**
 * Returns the difference in seconds between time2 and time1.
 */
double difftime( time_t time2, time_t time1 );

/**
 * If necessary, adjusts fields of * tp to fall withing normal ranges.
 * Returns the corresponding calendar time, or -1 if it cannot be represented.
 */
time_t mktime( struct tm * tp );

/**
 * Returns the given time as a string of the form: Sun Jan 3 13:08:42 1988\n\0
 */
char * asctime( const struct tm * tp );

/**
 * Returns string equivalent to calendar time tp converted to local time.
 * Equivalent to: asctime( localtime( tp ) )
 */
char * ctime( const time_t * tp );

/**
 * Returns calendar time * tp converted to Coordinated Universal Time, or NULL
 * if not available.
 */
struct tm * gmtime( const time_t * tp );

/**
 * Returns calendar time * tp converted into local time.
 */
struct tm * localtime( const time_t * tp );

/**
 * Formats * tp into s according to fmt. Places no more than smax characters
 * into s, and returns number of characters produced (excluding terminating
 * NUL), or 0 if greater than smax. Formatting conversions (%c) are:
 *      
 *      A   Name of weekday
 *      a   Abbreviated name of weekday
 *      B   Name of month
 *      b   Abbreviated name of month
 *      c   Local date and time representation
 *      d   Day of month [01-31]
 *      H   Hour (24-hour clock) [00-23]
 *      I   Hour (12-hour clock) [01-12]
 *      j   Day of year [001-366]
 *      M   Minute [00-59]
 *      m   Month [01-12]
 *      p   Local equivalent of "AM" or "PM"
 *      S   Second [00-61]
 *      U   Week number of year (Sunday as 1st day of week) [00-53]
 *      W   Week number of year (Monday as 1st day of week) [00-53]
 *      w   Weekday (Sunday as 0) [0-6]
 *      X   Local time representation
 *      x   Local date representation
 *      Y   Year with century
 *      y   Year without century [00-99]
 *      Z   Name (if any) of time zone
 *      %   %
 *      
 */
size_t strftime( char * s, size_t smax, const char * fmt, const struct tm * tp );

#ifdef __cplusplus
}
#endif

#endif /* __LIBC_TIME_H__ */
