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

#ifndef __XEOS_LIB_POSIX_NETINET_IN_H__
#define __XEOS_LIB_POSIX_NETINET_IN_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <arpa/inet.h>
#include <inttypes.h>
#include <sys/socket.h>

#include <system/types/in_port_t.h>
#include <system/types/in_addr_t.h>
#include <system/types/sa_family_t.h>
#include <system/types/uint8_t.h>
#include <system/types/uint32_t.h>
#include <system/types/struct_in_addr.h>
#include <system/types/struct_sockaddr_in.h>
#include <system/types/struct_in6_addr.h>
#include <system/types/struct_sockaddr_in6.h>
#include <system/types/struct_ipv6_mreq.h>

extern const struct in6_addr in6addr_any;
extern const struct in6_addr in6addr_loopback;

#define IN6ADDR_ANY_INIT                    {{                              \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x00      \
                                            }}
#define IN6ADDR_LOOPBACK_INIT               {{                              \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x00,     \
                                                0x00, 0x00, 0x00, 0x01      \
                                            }}

#define IPPROTO_IP                          0
#define IPPROTO_IPV6                        2
#define IPPROTO_ICMP                        3
#define IPPROTO_RAW                         4
#define IPPROTO_TCP                         5
#define IPPROTO_UDP                         6

#define INADDR_ANY                          ( ( in_addr_t )0x00000000 )
#define INADDR_BROADCAST                    ( ( in_addr_t )0xFFFFFFFF )

#include <system/types/inet_addrstrlen.h>
#include <system/types/inet6_addrstrlen.h>

#define IPV6_JOIN_GROUP                     1
#define IPV6_LEAVE_GROUP                    2
#define IPV6_MULTICAST_HOPS                 3
#define IPV6_MULTICAST_IF                   4
#define IPV6_MULTICAST_LOOP                 5
#define IPV6_UNICAST_HOPS                   6
#define IPV6_V6ONLY                         7

#define IN6_IS_ADDR_UNSPECIFIED( _s_ )      0
#define IN6_IS_ADDR_LOOPBACK( _s_ )         0
#define IN6_IS_ADDR_MULTICAST( _s_ )        0
#define IN6_IS_ADDR_LINKLOCAL( _s_ )        0
#define IN6_IS_ADDR_SITELOCAL( _s_ )        0
#define IN6_IS_ADDR_V4MAPPED( _s_ )         0
#define IN6_IS_ADDR_V4COMPAT( _s_ )         0
#define IN6_IS_ADDR_MC_NODELOCAL( _s_ )     0
#define IN6_IS_ADDR_MC_LINKLOCAL( _s_ )     0
#define IN6_IS_ADDR_MC_SITELOCAL( _s_ )     0
#define IN6_IS_ADDR_MC_ORGLOCAL( _s_ )      0
#define IN6_IS_ADDR_MC_GLOBAL( _s_ )        0

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_POSIX_NETINET_IN_H__ */
