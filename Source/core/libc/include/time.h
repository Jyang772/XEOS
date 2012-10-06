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
