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

#ifndef __XEOS_LIB_POSIX_UNISTD_H__
#define __XEOS_LIB_POSIX_UNISTD_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <system/types/null.h>
#include <system/types/size_t.h>
#include <system/types/ssize_t.h>
#include <system/types/uid_t.h>
#include <system/types/off_t.h>
#include <system/types/pid_t.h>
#include <system/types/gid_t.h>
#include <system/types/useconds_t.h>
#include <system/types/intptr_t.h>

#define	_POSIX_VERSION                          200809L
#define	_POSIX2_VERSION                         200809L
#define _POSIX_ASYNCHRONOUS_IO                  200809L
#define	_POSIX_BARRIERS                         200809L
#define	_POSIX_CHOWN_RESTRICTED                 1
#define	_POSIX_CLOCK_SELECTION                  200809L
#define	_POSIX_JOB_CONTROL                      1
#define	_POSIX_MAPPED_FILES                     200809L
#define	_POSIX_MEMORY_PROTECTION                200809L
#define	_POSIX_NO_TRUNC                         1
#define	_POSIX_READER_WRITER_LOCKS              200809L
#define	_POSIX_REALTIME_SIGNALS                 200809L
#define	_POSIX_REGEXP                           1
#define	_POSIX_SAVED_IDS                        1
#define	_POSIX_SEMAPHORES                       200809L
#define	_POSIX_SHELL                            1
#define	_POSIX_SPIN_LOCKS                       200809L
#define	_POSIX_THREAD_SAFE_FUNCTIONS            200809L
#define	_POSIX_THREADS                          200809L
#define	_POSIX_TIMEOUTS                         200809L
#define	_POSIX_TIMERS                           200809L
#define	_POSIX2_C_BIND                          200809L
#define	_POSIX2_CHAR_TERM                       1

/*
#define _POSIX_ADVISORY_INFO                    200809L
#define	_POSIX_CPUTIME                          200809L
#define	_POSIX_FSYNC                            200809L
#define	_POSIX_IPV6                             200809L
#define	_POSIX_MEMLOCK                          200809L
#define	_POSIX_MEMLOCK_RANGE                    200809L
#define	_POSIX_MESSAGE_PASSING                  200809L
#define	_POSIX_MONOTONIC_CLOCK                  200809L
#define	_POSIX_PRIORITIZED_IO                   200809L
#define	_POSIX_PRIORITY_SCHEDULING              200809L
#define	_POSIX_RAW_SOCKETS                      200809L
#define	_POSIX_SHARED_MEMORY_OBJECTS            200809L
#define	_POSIX_SPAWN                            200809L
#define	_POSIX_SPORADIC_SERVER                  200809L
#define	_POSIX_SYNCHRONIZED_IO                  200809L
#define	_POSIX_THREAD_ATTR_STACKADDR            200809L
#define	_POSIX_THREAD_ATTR_STACKSIZE            200809L
#define	_POSIX_THREAD_CPUTIME                   200809L
#define	_POSIX_THREAD_PRIO_INHERIT              200809L
#define	_POSIX_THREAD_PRIO_PROTECT              200809L
#define	_POSIX_THREAD_PRIORITY_SCHEDULING       200809L
#define	_POSIX_THREAD_PROCESS_SHARED            200809L
#define	_POSIX_THREAD_ROBUST_PRIO_INHERIT       200809L
#define	_POSIX_THREAD_ROBUST_PRIO_PROTECT       200809L
#define	_POSIX_THREAD_SPORADIC_SERVER           200809L
#define	_POSIX_TRACE                            200809L
#define	_POSIX_TRACE_EVENT_FILTER               200809L
#define	_POSIX_TRACE_INHERIT                    200809L
#define	_POSIX_TRACE_LOG                        200809L
#define	_POSIX_TYPED_MEMORY_OBJECTS             200809L
#define	_POSIX2_C_DEV                           200809L
#define	_POSIX2_FORT_DEV                        200809L
#define	_POSIX2_FORT_RUN                        200809L
#define	_POSIX2_LOCALEDEF                       200809L
#define	_POSIX2_PBS                             200809L
#define	_POSIX2_PBS_ACCOUNTING                  200809L
#define	_POSIX2_PBS_CHECKPOINT                  200809L
#define	_POSIX2_PBS_LOCATE                      200809L
#define	_POSIX2_PBS_MESSAGE                     200809L
#define	_POSIX2_PBS_TRACK                       200809L
#define	_POSIX2_SW_DEV                          200809L
#define	_POSIX2_UPE                             200809L
*/

/*
#define	_XOPEN_VERSION                          1
#define	_XOPEN_CRYPT                            1
#define	_XOPEN_ENH_I18N                         1
#define	_XOPEN_REALTIME                         1
#define	_XOPEN_REALTIME_THREADS                 1
#define	_XOPEN_SHM                              1
#define	_XOPEN_STREAMS                          1
#define	_XOPEN_UNIX                             1
#define	_XOPEN_UUCP                             200809L
*/

#ifdef __LP64__

#define	_POSIX_V6_LP64_OFF64                    1
#define	_POSIX_V7_LP64_OFF64                    1

#else

#define	_POSIX_V6_ILP32_OFFBIG                  1
#define	_POSIX_V7_ILP32_OFFBIG                  1

#endif

/*
#define	_POSIX_V6_ILP32_OFF32                   1
#define	_POSIX_V6_LPBIG_OFFBIG                  1
#define	_POSIX_V7_ILP32_OFF32                   1
#define	_POSIX_V7_LPBIG_OFFBIG                  1
*/

#define	_POSIX_ASYNC_IO                         1
#define	_POSIX_PRIO_IO                          2
#define	_POSIX_SYNC_IO                          3

#define _POSIX_TIMESTAMP_RESOLUTION             1
#define _POSIX2_SYMLINKS                        1

#define _POSIX_VDISABLE                         0

#define STDERR_FILENO                           2
#define STDIN_FILENO                            0
#define STDOUT_FILENO                           1

#define	F_OK                                    0
#define	X_OK                                    ( 1 << 0 )
#define	W_OK                                    ( 1 << 1 )
#define	R_OK                                    ( 1 << 2 )

#include <system/types/seek_set.h>
#include <system/types/seek_cur.h>
#include <system/types/seek_end.h>

#define	F_LOCK                                  0
#define	F_TEST                                  0
#define	F_ULOCK                                 0
#define	F_TLOCK                                 0

#define _CS_PATH                                ""

#ifdef __LP64__

#define _CS_POSIX_V6_LP64_OFF64_CFLAGS          ""
#define _CS_POSIX_V6_LP64_OFF64_LDFLAGS         ""
#define _CS_POSIX_V6_LP64_OFF64_LIBS            ""
#define _CS_POSIX_V7_LP64_OFF64_CFLAGS          ""
#define _CS_POSIX_V7_LP64_OFF64_LDFLAGS         ""
#define _CS_POSIX_V7_LP64_OFF64_LIBS            ""

#else

#define _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS        ""
#define _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS       ""
#define _CS_POSIX_V6_ILP32_OFFBIG_LIBS          ""
#define _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS        ""
#define _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS       ""
#define _CS_POSIX_V7_ILP32_OFFBIG_LIBS          ""

#endif

#define _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS      ""
#define _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS      ""
#define _CS_V6_ENV                              ""
#define _CS_V7_ENV                              ""
#define _CS_POSIX_V7_THREADS_CFLAGS             ""
#define _CS_POSIX_V7_THREADS_LDFLAGS            ""

/*
#define _CS_POSIX_V7_ILP32_OFF32_CFLAGS         ""
#define _CS_POSIX_V7_ILP32_OFF32_LDFLAGS        ""
#define _CS_POSIX_V7_ILP32_OFF32_LIBS           ""
#define _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS        ""
#define _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS       ""
#define _CS_POSIX_V7_LPBIG_OFFBIG_LIBS          ""
#define _CS_POSIX_V6_ILP32_OFF32_CFLAGS         ""
#define _CS_POSIX_V6_ILP32_OFF32_LDFLAGS        ""
#define _CS_POSIX_V6_ILP32_OFF32_LIBS           ""
#define _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS        ""
#define _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS       ""
#define _CS_POSIX_V6_LPBIG_OFFBIG_LIBS          ""
*/

#define _PC_2_SYMLINKS                          0
#define _PC_ALLOC_SIZE_MIN                      0
#define _PC_ASYNC_IO                            0
#define _PC_CHOWN_RESTRICTED                    0
#define _PC_FILESIZEBITS                        0
#define _PC_LINK_MAX                            0
#define _PC_MAX_CANON                           0
#define _PC_MAX_INPUT                           0
#define _PC_NAME_MAX                            0
#define _PC_NO_TRUNC                            0
#define _PC_PATH_MAX                            0
#define _PC_PIPE_BUF                            0
#define _PC_PRIO_IO                             0
#define _PC_REC_INCR_XFER_SIZE                  0
#define _PC_REC_MAX_XFER_SIZE                   0
#define _PC_REC_MIN_XFER_SIZE                   0
#define _PC_REC_XFER_ALIGN                      0
#define _PC_SYMLINK_MAX                         0
#define _PC_SYNC_IO                             0
#define _PC_TIMESTAMP_RESOLUTION                0
#define _PC_VDISABLE                            0

#define _SC_2_C_BIND                            0
#define _SC_2_C_DEV                             0
#define _SC_2_CHAR_TERM                         0
#define _SC_2_FORT_DEV                          0
#define _SC_2_FORT_RUN                          0
#define _SC_2_LOCALEDEF                         0
#define _SC_2_PBS                               0
#define _SC_2_PBS_ACCOUNTING                    0
#define _SC_2_PBS_CHECKPOINT                    0
#define _SC_2_PBS_LOCATE                        0
#define _SC_2_PBS_MESSAGE                       0
#define _SC_2_PBS_TRACK                         0
#define _SC_2_SW_DEV                            0
#define _SC_2_UPE                               0
#define _SC_2_VERSION                           0
#define _SC_ADVISORY_INFO                       0
#define _SC_AIO_LISTIO_MAX                      0
#define _SC_AIO_MAX                             0
#define _SC_AIO_PRIO_DELTA_MAX                  0
#define _SC_ARG_MAX                             0
#define _SC_ASYNCHRONOUS_IO                     0
#define _SC_ATEXIT_MAX                          0
#define _SC_BARRIERS                            0
#define _SC_BC_BASE_MAX                         0
#define _SC_BC_DIM_MAX                          0
#define _SC_BC_SCALE_MAX                        0
#define _SC_BC_STRING_MAX                       0
#define _SC_CHILD_MAX                           0
#define _SC_CLK_TCK                             0
#define _SC_CLOCK_SELECTION                     0
#define _SC_COLL_WEIGHTS_MAX                    0
#define _SC_CPUTIME                             0
#define _SC_DELAYTIMER_MAX                      0
#define _SC_EXPR_NEST_MAX                       0
#define _SC_FSYNC                               0
#define _SC_GETGR_R_SIZE_MAX                    0
#define _SC_GETPW_R_SIZE_MAX                    0
#define _SC_HOST_NAME_MAX                       0
#define _SC_IOV_MAX                             0
#define _SC_IPV6                                0
#define _SC_JOB_CONTROL                         0
#define _SC_LINE_MAX                            0
#define _SC_LOGIN_NAME_MAX                      0
#define _SC_MAPPED_FILES                        0
#define _SC_MEMLOCK                             0
#define _SC_MEMLOCK_RANGE                       0
#define _SC_MEMORY_PROTECTION                   0
#define _SC_MESSAGE_PASSING                     0
#define _SC_MONOTONIC_CLOCK                     0
#define _SC_MQ_OPEN_MAX                         0
#define _SC_MQ_PRIO_MAX                         0
#define _SC_NGROUPS_MAX                         0
#define _SC_OPEN_MAX                            0
#define _SC_PAGE_SIZE                           0
#define _SC_PAGESIZE                            0
#define _SC_PRIORITIZED_IO                      0
#define _SC_PRIORITY_SCHEDULING                 0
#define _SC_RAW_SOCKETS                         0
#define _SC_RE_DUP_MAX                          0
#define _SC_READER_WRITER_LOCKS                 0
#define _SC_REALTIME_SIGNALS                    0
#define _SC_REGEXP                              0
#define _SC_RTSIG_MAX                           0
#define _SC_SAVED_IDS                           0
#define _SC_SEM_NSEMS_MAX                       0
#define _SC_SEM_VALUE_MAX                       0
#define _SC_SEMAPHORES                          0
#define _SC_SHARED_MEMORY_OBJECTS               0
#define _SC_SHELL                               0
#define _SC_SIGQUEUE_MAX                        0
#define _SC_SPAWN                               0
#define _SC_SPIN_LOCKS                          0
#define _SC_SPORADIC_SERVER                     0
#define _SC_SS_REPL_MAX                         0
#define _SC_STREAM_MAX                          0
#define _SC_SYMLOOP_MAX                         0
#define _SC_SYNCHRONIZED_IO                     0
#define _SC_THREAD_ATTR_STACKADDR               0
#define _SC_THREAD_ATTR_STACKSIZE               0
#define _SC_THREAD_CPUTIME                      0
#define _SC_THREAD_DESTRUCTOR_ITERATIONS        0
#define _SC_THREAD_KEYS_MAX                     0
#define _SC_THREAD_PRIO_INHERIT                 0
#define _SC_THREAD_PRIO_PROTECT                 0
#define _SC_THREAD_PRIORITY_SCHEDULING          0
#define _SC_THREAD_PROCESS_SHARED               0
#define _SC_THREAD_ROBUST_PRIO_INHERIT          0
#define _SC_THREAD_ROBUST_PRIO_PROTECT          0
#define _SC_THREAD_SAFE_FUNCTIONS               0
#define _SC_THREAD_SPORADIC_SERVER              0
#define _SC_THREAD_STACK_MIN                    0
#define _SC_THREAD_THREADS_MAX                  0
#define _SC_THREADS                             0
#define _SC_TIMEOUTS                            0
#define _SC_TIMER_MAX                           0
#define _SC_TIMERS                              0
#define _SC_TRACE                               0
#define _SC_TRACE_EVENT_FILTER                  0
#define _SC_TRACE_EVENT_NAME_MAX                0
#define _SC_TRACE_INHERIT                       0
#define _SC_TRACE_LOG                           0
#define _SC_TRACE_NAME_MAX                      0
#define _SC_TRACE_SYS_MAX                       0
#define _SC_TRACE_USER_EVENT_MAX                0
#define _SC_TTY_NAME_MAX                        0
#define _SC_TYPED_MEMORY_OBJECTS                0
#define _SC_TZNAME_MAX                          0
#define _SC_V7_ILP32_OFF32                      0
#define _SC_V7_ILP32_OFFBIG                     0
#define _SC_V7_LP64_OFF64                       0
#define _SC_V7_LPBIG_OFFBIG                     0
#define _SC_V6_ILP32_OFF32                      0
#define _SC_V6_ILP32_OFFBIG                     0
#define _SC_V6_LP64_OFF64                       0
#define _SC_V6_LPBIG_OFFBIG                     0
#define _SC_VERSION                             0
#define _SC_XOPEN_CRYPT                         0
#define _SC_XOPEN_ENH_I18N                      0
#define _SC_XOPEN_REALTIME                      0
#define _SC_XOPEN_REALTIME_THREADS              0
#define _SC_XOPEN_SHM                           0
#define _SC_XOPEN_STREAMS                       0
#define _SC_XOPEN_UNIX                          0
#define _SC_XOPEN_UUCP                          0
#define _SC_XOPEN_VERSION                       0

#include <system/types/size_t.h>
#include <system/types/ssize_t.h>
#include <system/types/uid_t.h>
#include <system/types/gid_t.h>
#include <system/types/off_t.h>
#include <system/types/pid_t.h>
#include <system/types/intptr_t.h>

extern char * optarg;
extern int    optind;
extern int    opterr;
extern int    optopt;

int             access( const char * name, int type );
unsigned int    alarm( unsigned int seconds );
int             chdir( const char * path );
int             chown( const char * file, uid_t owner, gid_t group );
int             close( int fd );
size_t          confstr( int name, char * buf, size_t len );
char          * crypt( const char * key, const char * salt );
char          * ctermid( char * s );
int             dup( int fd );
int             dup2( int fd1, int fd2 );
void            _exit( int status );
void            encrypt( char block[ 64 ], int edflag );
int             execl( const char * path, const char * arg, ... );
int             execle( const char * path, const char * arg, ... );
int             execlp( const char * path, const char * arg, ... );
int             execv( const char * path, char * const argv[] );
int             execve( const char * path, char * const argv[] , char * const envp[] );
int             execvp( const char * path, char * const argv[] );
int             faccessat( int fd, const char * path, int amode, int flag );
int             fchdir( int fd );
int             fchown( int fd, uid_t owner, gid_t group );
int             fchownat( int fd, const char * path, uid_t owner, gid_t group, int flag );
int             fdatasync( int fd );
int             fexecve( int fd, char * const argv[], char * const envp[] );
pid_t           fork( void );
long int        fpathconf( int fd, int name );
int             fsync( int fd );
int             ftruncate( int fd, off_t len );
char          * getcwd( char * buf, size_t size );
gid_t           getegid( void );
uid_t           geteuid( void );
gid_t           getgid( void );
int             getgroups( int size, gid_t list[] );
long            gethostid( void );
char          * getlogin( void );
int             getlogin_r( char * name, size_t len );
int             getopt( int argc, char * const argv[], const char * options );
pid_t           getpgid( pid_t pid );
pid_t           getpgrp( void );
pid_t           getpid( void );
pid_t           getppid( void );
pid_t           getsid( pid_t pid );
uid_t           getuid( void );
int             isatty( int fd );
int             lchown( const char * file, uid_t owner, gid_t group );
int             link( const char * from, const char * to );
int             linkat( int fd1, const char * path1, int fd2, const char * path2, int flag );
int             lockf( int fd, int cmd, off_t len );
off_t           lseek( int fd, off_t offset, int whence );
int             nice( int inc );
long int        pathconf( const char * path, int name );
int             pause( void );
int             pipe( int desc[ 2 ] );
ssize_t         pread( int fd, void * buf, size_t nbytes, off_t offset );
ssize_t         pwrite( int fd, const void * buf, size_t nbytes, off_t offset );
ssize_t         read( int fd, void * buf, size_t nbytes );
int             readlink( const char * restrict path, char * restrict buf, size_t len );
ssize_t         readlinkat( int fd, const char * restrict path, char * restrict buf, size_t bufsize );
int             rmdir( const char * path );
int             setegid( gid_t gid );
int             seteuid( uid_t uid );
int             setgid( gid_t gid );
int             setpgid( pid_t pid, pid_t pgid );
pid_t           setpgrp( void );
int             setregid( gid_t rgid, gid_t egid );
int             setreuid( uid_t ruid, uid_t euid );
pid_t           setsid( void );
int             setuid( uid_t uid );
unsigned int    sleep( unsigned int seconds );
void            swab( const void * restrict from, void * restrict to, ssize_t n );
int             symlink( const char * from, const char * to );
int             symlinkat( const char * path1, int fd, const char * path2 );
void            sync( void );
long int        sysconf( int name );
pid_t           tcgetpgrp( int fd );
int             tcsetpgrp( int fd, pid_t pgrp_id );
int             truncate( const char * file, off_t len );
char *          ttyname( int fd );
int             ttyname_r( int fd, char * buf, size_t len );
int             unlink( const char * name );
int             unlinkat( int fd, const char * path, int flag );
ssize_t         write( int fd, const void * buf, size_t len );

#ifdef __cplusplus
}
#endif

#endif /* __XEOS_LIB_POSIX_UNISTD_H__ */
