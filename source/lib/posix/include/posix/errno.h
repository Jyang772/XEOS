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

#ifndef __XEOS_LIB_POSIX_ERRNO_H__
#define __XEOS_LIB_POSIX_ERRNO_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <c99/errno.h>

#ifdef _POSIX_C_SOURCE

#define E2BIG               0x0004
#define EACCES              0x0005
#define EADDRINUSE          0x0006
#define EADDRNOTAVAIL       0x0007
#define EAFNOSUPPORT        0x0008
#define EAGAIN              0x0009
#define EALREADY            0x000A
#define EBADF               0x000B
#define EBADMSG             0x000C
#define EBUSY               0x000D
#define ECANCELED           0x000E
#define ECHILD              0x000F
#define ECONNABORTED        0x0010
#define ECONNREFUSED        0x0011
#define ECONNRESET          0x0012
#define EDEADLK             0x0013
#define EDESTADDRREQ        0x0014
#define EDQUOT              0x0015
#define EEXIST              0x0016
#define EFAULT              0x0017
#define EFBIG               0x0018
#define EHOSTUNREACH        0x0019
#define EIDRM               0x001A
#define EINPROGRESS         0x001B
#define EINTR               0x001C
#define EINVAL              0x001D
#define EIO                 0x001E
#define EISCONN             0x001F
#define EISDIR              0x0020
#define ELOOP               0x0021
#define EMFILE              0x0022
#define EMLINK              0x0023
#define EMSGSIZE            0x0024
#define EMULTIHOP           0x0025
#define ENAMETOOLONG        0x0026
#define ENETDOWN            0x0027
#define ENETRESET           0x0028
#define ENETUNREACH         0x0029
#define ENFILE              0x002A
#define ENOBUFS             0x002B
#define ENODATA             0x002C
#define ENODEV              0x002D
#define ENOENT              0x002E
#define ENOEXEC             0x002F
#define ENOLCK              0x0030
#define ENOLINK             0x0031
#define ENOMEM              0x0032
#define ENOMSG              0x0033
#define ENOPROTOOPT         0x0034
#define ENOSPC              0x0035
#define ENOSR               0x0036
#define ENOSTR              0x0037
#define ENOSYS              0x0038
#define ENOTCONN            0x0039
#define ENOTDIR             0x003A
#define ENOTEMPTY           0x003B
#define ENOTRECOVERABL      0x003C
#define ENOTSOCK            0x003D
#define ENOTSUP             0x003E
#define ENOTTY              0x003F
#define ENXIO               0x0040
#define EOPNOTSUPP          0x0041
#define EOVERFLOW           0x0042
#define EOWNERDEAD          0x0043
#define EPERM               0x0044
#define EPIPE               0x0045
#define EPROTO              0x0046
#define EPROTONOSUPPOR      0x0047
#define EPROTOTYPE          0x0048
#define EROFS               0x0049
#define ESPIPE              0x004A
#define ESRCH               0x004B
#define ESTALE              0x004C
#define ETIME               0x004D
#define ETIMEDOUT           0x004E
#define ETXTBSY             0x004F
#define EWOULDBLOCK         0x0050
#define EXDEV               0x0051

#endif /* _POSIX_C_SOURCE */

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_POSIX_ERRNO_H__ */
