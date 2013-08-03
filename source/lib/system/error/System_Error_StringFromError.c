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

#include <system/error.h>
#include <errno.h>

const char * System_Error_StringFromError( int errnum )
{
    char * err;
    
    switch( errnum )
    {
        /* C99 */
        case EDOM:              err = "Mathematics argument out of domain of function";         break;
        case EILSEQ:            err = "Illegal byte sequence";                                  break;
        case ERANGE:            err = "Result too large";                                       break;
        
        /* POSIX */
        case E2BIG:             err = "Argument list too long";                                 break;
        case EACCES:            err = "Permission denied";                                      break;
        case EADDRINUSE:        err = "Address in use";                                         break;
        case EADDRNOTAVAIL:     err = "Address not available";                                  break;
        case EAFNOSUPPORT:      err = "Address family not supported";                           break;
        case EAGAIN:            err = "Resource unavailable, try again";                        break;
        case EALREADY:          err = "Connection already in progress";                         break;
        case EBADF:             err = "Bad file descriptor";                                    break;
        case EBADMSG:           err = "Bad message";                                            break;
        case EBUSY:             err = "Device or resource busy";                                break;
        case ECANCELED:         err = "Operation canceled";                                     break;
        case ECHILD:            err = "No child processes";                                     break;
        case ECONNABORTED:      err = "Connection aborted";                                     break;
        case ECONNREFUSED:      err = "Connection refused";                                     break;
        case ECONNRESET:        err = "Connection reset";                                       break;
        case EDEADLK:           err = "Resource deadlock would occur";                          break;
        case EDESTADDRREQ:      err = "Destination address required";                           break;
        case EDQUOT:            err = "Reserved";                                               break;
        case EEXIST:            err = "File exists";                                            break;
        case EFAULT:            err = "Bad address";                                            break;
        case EFBIG:             err = "File too large";                                         break;
        case EHOSTUNREACH:      err = "Host is unreachable";                                    break;
        case EIDRM:             err = "Identifier removed";                                     break;
        case EINPROGRESS:       err = "Operation in progress";                                  break;
        case EINTR:             err = "Interrupted function";                                   break;
        case EINVAL:            err = "Invalid argument";                                       break;
        case EIO:               err = "I/O error";                                              break;
        case EISCONN:           err = "Socket is connected";                                    break;
        case EISDIR:            err = "Is a directory";                                         break;
        case ELOOP:             err = "Too many levels of symbolic links";                      break;
        case EMFILE:            err = "File descriptor value too large";                        break;
        case EMLINK:            err = "Too many links";                                         break;
        case EMSGSIZE:          err = "Message too large";                                      break;
        case EMULTIHOP:         err = "Reserved";                                               break;
        case ENAMETOOLONG:      err = "Filename too long";                                      break;
        case ENETDOWN:          err = "Network is down";                                        break;
        case ENETRESET:         err = "Connection aborted by network";                          break;
        case ENETUNREACH:       err = "Network unreachable";                                    break;
        case ENFILE:            err = "Too many files open in system";                          break;
        case ENOBUFS:           err = "No buffer space available";                              break;
        case ENODATA:           err = "No message is available on the STREAM head read queue";  break;
        case ENODEV:            err = "No such device";                                         break;
        case ENOENT:            err = "No such file or directory";                              break;
        case ENOEXEC:           err = "Executable file format error";                           break;
        case ENOLCK:            err = "No locks available";                                     break;
        case ENOLINK:           err = "Reserved";                                               break;
        case ENOMEM:            err = "Not enough space";                                       break;
        case ENOMSG:            err = "No message of the desired type";                         break;
        case ENOPROTOOPT:       err = "Protocol not available";                                 break;
        case ENOSPC:            err = "No space left on device";                                break;
        case ENOSR:             err = "No STREAM resources";                                    break;
        case ENOSTR:            err = "Not a STREAM";                                           break;
        case ENOSYS:            err = "Function not supported";                                 break;
        case ENOTCONN:          err = "The socket is not connected";                            break;
        case ENOTDIR:           err = "Not a directory";                                        break;
        case ENOTEMPTY:         err = "Directory not empty";                                    break;
        case ENOTRECOVERABL:    err = "State not recoverable";                                  break;
        case ENOTSOCK:          err = "Not a socket";                                           break;
        case ENOTSUP:           err = "Not supported";                                          break;
        case ENOTTY:            err = "Inappropriate I/O control operation";                    break;
        case ENXIO:             err = "No such device or address";                              break;
        case EOPNOTSUPP:        err = "Operation not supported on socket";                      break;
        case EOVERFLOW:         err = "Value too large to be stored in data type";              break;
        case EOWNERDEAD:        err = "Previous owner died";                                    break;
        case EPERM:             err = "Operation not permitted";                                break;
        case EPIPE:             err = "Broken pipe";                                            break;
        case EPROTO:            err = "Protocol error";                                         break;
        case EPROTONOSUPPOR:    err = "Protocol not supported";                                 break;
        case EPROTOTYPE:        err = "Protocol wrong type for socket";                         break;
        case EROFS:             err = "Read-only file system";                                  break;
        case ESPIPE:            err = "Invalid seek";                                           break;
        case ESRCH:             err = "No such process";                                        break;
        case ESTALE:            err = "Reserved";                                               break;
        case ETIME:             err = "Stream ioctl ( ) timeout";                               break;
        case ETIMEDOUT:         err = "Connection timed out";                                   break;
        case ETXTBSY:           err = "Text file busy";                                         break;
        case EWOULDBLOCK:       err = "Operation would block";                                  break;
        case EXDEV:             err = "Cross-device link";                                      break;
        
        /* Unknown */
        default:                err = "Unknown error";                                          break;
    }
    
    return err;
}
