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

#ifndef __HAL_CRTC_H__
#define __HAL_CRTC_H__
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#define CRTC_DATA_REGISTER                 0x03D4
#define CRTC_INDEX_REGISTER                0x03D5

#define CRTC_HORIZONTAL_TOTAL              0x0000
#define CRTC_END_HORIZONTAL_DISPLAY        0x0001
#define CRTC_START_HORIZONTAL_BLANKING     0x0002
#define CRTC_END_HORIZONTAL_BLANKING       0x0003
#define CRTC_START_HORIZONTAL_RETRACE      0x0004
#define CRTC_END_HORIZONTAL_RETRACE        0x0005
#define CRTC_VERTICAL_TOTAL                0x0006
#define CRTC_OVERFLOW                      0x0007
#define CRTC_PRESET_ROW_SCAN               0x0008
#define CRTC_MAXIMUM_SCAN_LINE             0x0009
#define CRTC_CURSOR_START                  0x000A
#define CRTC_CURSOR_END                    0x000B
#define CRTC_START_ADDRESS_HIGH            0x000C
#define CRTC_START_ADDRESS_LOW             0x000D
#define CRTC_CURSOR_LOCATION_HIGH          0x000E
#define CRTC_CURSOR_LOCATION_LOW           0x000F
#define CRTC_VERTICAL_RETRACE_START        0x0010
#define CRTC_VERTICAL_RETRACE_END          0x0011
#define CRTC_VERTICAL_DISPLAY_END          0x0012
#define CRTC_OFFSET                        0x0013
#define CRTC_UNDERLINE_LOCATION            0x0014
#define CRTC_START_VERTICAL_BLANKING       0x0015
#define CRTC_END_VERTICAL_BLANKING         0x0016
#define CRTC_CRTC_MODE_CONTROL             0x0017
#define CRTC_LINE_COMPARE                  0x0018

#ifdef __cplusplus
}
#endif

#endif /* __HAL_CRTC_H__ */
