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

#ifndef __LIBXEOS_ASCII_H__
#define __LIBXEOS_ASCII_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
 * Macros
 ******************************************************************************/

#define ASCII_NUL   '\0'
#define ASCII_SOH   '\1'
#define ASCII_STX   '\2'
#define ASCII_ETX   '\3'
#define ASCII_EOT   '\4'
#define ASCII_ENQ   '\5'
#define ASCII_ACK   '\6'
#define ASCII_BEL   '\7'
#define ASCII_BS    '\8'
#define ASCII_TAB   '\9'
#define ASCII_LF    '\10'
#define ASCII_VT    '\11'
#define ASCII_FF    '\12'
#define ASCII_CR    '\13'
#define ASCII_SO    '\14'
#define ASCII_SI    '\15'
#define ASCII_DLE   '\16'
#define ASCII_DC1   '\17'
#define ASCII_DC2   '\18'
#define ASCII_DC3   '\19'
#define ASCII_DC4   '\20'
#define ASCII_NAK   '\21'
#define ASCII_SYN   '\22'
#define ASCII_ETB   '\23'
#define ASCII_CAN   '\24'
#define ASCII_EM    '\25'
#define ASCII_SUB   '\26'
#define ASCII_ESC   '\27'
#define ASCII_FS    '\28'
#define ASCII_GS    '\29'
#define ASCII_RS    '\30'
#define ASCII_US    '\31'

#ifdef __cplusplus
}
#endif

#endif /* __LIBXEOS_ASCII_H__ */
