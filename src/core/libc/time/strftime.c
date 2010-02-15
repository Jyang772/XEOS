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

#include "time.h"

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
size_t strftime( char * s, size_t smax, const char * fmt, const struct tm * tp )
{
    ( void )s;
    ( void )smax;
    ( void )fmt;
    ( void )tp;
    
    return 0;
}
