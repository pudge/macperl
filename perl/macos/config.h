/*
 * The Macintosh version of this file was produced manually.
 */

/*
 * Package name      : perl
 * Configuration time: 22Nov99
 * Configured by     : Matthias Neeracher <neeri@iis.ee.ethz.ch>
 * Target system     : MacOS Traditional
 */
/*********************************************************************
Project	:	Perl5				-	
File	:	config.h			-	Mac configuration

$Log$
Revision 1.1  2000/05/14 21:45:03  neeri
First build released to public


*********************************************************************/

#ifndef _config_h_
#define _config_h_

/* LOC_SED:
 *	This symbol holds the complete pathname to the sed program.
 */
/* #define LOC_SED 	"$full_sed"	/**/

/* HAS_ALARM:
 *	This symbol, if defined, indicates that the alarm routine is
 *	available.
 */
#define HAS_ALARM		/**/

/* HASATTRIBUTE:
 *	This symbol indicates the C compiler can check for function attributes,
 *	such as printf formats. This is normally only supported by GNU cc.
 */
#define HASATTRIBUTE 	/**/
#ifndef HASATTRIBUTE
#define __attribute__(_arg_)
#endif

/* HAS_BCMP:
 *	This symbol is defined if the bcmp() routine is available to
 *	compare blocks of memory.
 */
#define HAS_BCMP	/**/

/* HAS_BCOPY:
 *	This symbol is defined if the bcopy() routine is available to
 *	copy blocks of memory.
 */
#define HAS_BCOPY	/**/

/* HAS_BZERO:
 *	This symbol is defined if the bzero() routine is available to
 *	set a memory block to 0.
 */
#define HAS_BZERO	/**/

/* HAS_CHOWN:
 *	This symbol, if defined, indicates that the chown routine is
 *	available.
 */
#undef HAS_CHOWN		/**/

/* HAS_CHROOT:
 *	This symbol, if defined, indicates that the chroot routine is
 *	available.
 */
#undef HAS_CHROOT		/**/

/* HAS_CHSIZE:
 *	This symbol, if defined, indicates that the chsize routine is available
 *	to truncate files.  You might need a -lx to get this routine.
 */
#undef	HAS_CHSIZE		/**/

/* HASCONST:
 *	This symbol, if defined, indicates that this C compiler knows about
 *	the const type. There is no need to actually test for that symbol
 *	within your programs. The mere use of the "const" keyword will
 *	trigger the necessary tests.
 */
#define HASCONST	/**/
#ifndef HASCONST
#define const
#endif

/* HAS_CRYPT:
 *	This symbol, if defined, indicates that the crypt routine is available
 *	to encrypt passwords and the like.
 */
#define HAS_CRYPT		/**/

/* HAS_CUSERID:
 *	This symbol, if defined, indicates that the cuserid routine is
 *	available to get character login names.
 */
#undef HAS_CUSERID		/**/

/* HAS_DBL_DIG:
 *	This symbol, if defined, indicates that this system's <float.h>
 *	or <limits.h> defines the symbol DBL_DIG, which is the number
 *	of significant digits in a double precision number.  If this
 *	symbol is not defined, a guess of 15 is usually pretty good.
 */
#define HAS_DBL_DIG 	/* */

/* HAS_DIFFTIME:
 *	This symbol, if defined, indicates that the difftime routine is
 *	available.
 */
#define HAS_DIFFTIME		/**/

/* HAS_DLERROR:
 *	This symbol, if defined, indicates that the dlerror routine is
 *	available to return a string describing the last error that
 *	occurred from a call to dlopen(), dlclose() or dlsym().
 */
#undef HAS_DLERROR	/**/

/* SETUID_SCRIPTS_ARE_SECURE_NOW:
 *	This symbol, if defined, indicates that the bug that prevents
 *	setuid scripts from being secure is not present in this kernel.
 */
/* DOSUID:
 *	This symbol, if defined, indicates that the C program should
 *	check the script that it is executing for setuid/setgid bits, and
 *	attempt to emulate setuid/setgid on systems that have disabled
 *	setuid #! scripts because the kernel can't do it securely.
 *	It is up to the package designer to make sure that this emulation
 *	is done securely.  Among other things, it should do an fstat on
 *	the script it just opened to make sure it really is a setuid/setgid
 *	script, it should make sure the arguments passed correspond exactly
 *	to the argument on the #! line, and it should not trust any
 *	subprocesses to which it must pass the filename rather than the
 *	file descriptor of the script to be executed.
 */
#undef SETUID_SCRIPTS_ARE_SECURE_NOW	/**/
#undef DOSUID		/**/

/* HAS_DUP2:
 *	This symbol, if defined, indicates that the dup2 routine is
 *	available to duplicate file descriptors.
 */
#define HAS_DUP2	/**/

/* HAS_FCHMOD:
 *	This symbol, if defined, indicates that the fchmod routine is available
 *	to change mode of opened files.  If unavailable, use chmod().
 */
#undef HAS_FCHMOD		/**/

/* HAS_FCHOWN:
 *	This symbol, if defined, indicates that the fchown routine is available
 *	to change ownership of opened files.  If unavailable, use chown().
 */
#undef HAS_FCHOWN		/**/

/* HAS_FCNTL:
 *	This symbol, if defined, indicates to the C program that
 *	the fcntl() function exists.
 */
#define HAS_FCNTL		/**/

/* HAS_FGETPOS:
 *	This symbol, if defined, indicates that the fgetpos routine is
 *	available to get the file position indicator, similar to ftell().
 */
#define HAS_FGETPOS	/**/

/* FLEXFILENAMES:
 *	This symbol, if defined, indicates that the system supports filenames
 *	longer than 14 characters.
 */
#define	FLEXFILENAMES		/**/

/* HAS_FLOCK:
 *	This symbol, if defined, indicates that the flock routine is
 *	available to do file locking.
 */
#undef HAS_FLOCK		/**/

/* HAS_FORK:
 *	This symbol, if defined, indicates that the fork routine is
 *	available.
 */
#undef HAS_FORK		/**/

/* HAS_FSETPOS:
 *	This symbol, if defined, indicates that the fsetpos routine is
 *	available to set the file position indicator, similar to fseek().
 */
#define HAS_FSETPOS	/**/

/* HAS_GETTIMEOFDAY:
 *	This symbol, if defined, indicates that the gettimeofday() system
 *	call is available for a sub-second accuracy clock. Usually, the file
 *	<sys/resource.h> needs to be included (see I_SYS_RESOURCE).
 *	The type "Timeval" should be used to refer to "struct timeval".
 */
#define HAS_GETTIMEOFDAY	/**/
#ifdef HAS_GETTIMEOFDAY
#define Timeval struct timeval	/* Structure used by gettimeofday() */
#endif

/* HAS_GETGROUPS:
 *	This symbol, if defined, indicates that the getgroups() routine is
 *	available to get the list of process groups.  If unavailable, multiple
 *	groups are probably not supported.
 */
#undef HAS_GETGROUPS		/**/

/* HAS_GETLOGIN:
 *	This symbol, if defined, indicates that the getlogin routine is
 *	available to get the login name.
 */
#undef HAS_GETLOGIN		/**/

/* HAS_GETPGID:
 *	This symbol, if defined, indicates to the C program that 
 *	the getpgid(pid) function is available to get the
 *	process group id.
 */
#undef HAS_GETPGID		/**/

/* HAS_GETPGRP:
 *	This symbol, if defined, indicates that the getpgrp routine is
 *	available to get the current process group.
 */
/* USE_BSD_GETPGRP:
 *	This symbol, if defined, indicates that getpgrp needs one
 *	arguments whereas USG one needs none.
 */
#undef HAS_GETPGRP		/**/
#undef USE_BSD_GETPGRP	/**/

/* HAS_GETPGRP2:
 *	This symbol, if defined, indicates that the getpgrp2() (as in DG/UX)
 *	routine is available to get the current process group.
 */
#undef HAS_GETPGRP2		/**/

/* HAS_GETPPID:
 *	This symbol, if defined, indicates that the getppid routine is
 *	available to get the parent process ID.
 */
#undef HAS_GETPPID		/**/

/* HAS_GETPRIORITY:
 *	This symbol, if defined, indicates that the getpriority routine is
 *	available to get a process's priority.
 */
#undef HAS_GETPRIORITY		/**/

/* HAS_INET_ATON:
 *	This symbol, if defined, indicates to the C program that the
 *	inet_aton() function is available to parse IP address "dotted-quad"
 *	strings.
 */
#define HAS_INET_ATON		/**/

/* HAS_KILLPG:
 *	This symbol, if defined, indicates that the killpg routine is available
 *	to kill process groups.  If unavailable, you probably should use kill
 *	with a negative process number.
 */
#undef HAS_KILLPG	/**/

/* HAS_LINK:
 *	This symbol, if defined, indicates that the link routine is
 *	available to create hard links.
 */
#undef HAS_LINK	/**/

/* HAS_LOCALECONV:
 *	This symbol, if defined, indicates that the localeconv routine is
 *	available for numeric and monetary formatting conventions.
 */
#define HAS_LOCALECONV	/**/

/* HAS_LOCKF:
 *	This symbol, if defined, indicates that the lockf routine is
 *	available to do file locking.
 */
#undef HAS_LOCKF		/**/

/* HAS_LSTAT:
 *	This symbol, if defined, indicates that the lstat routine is
 *	available to do file stats on symbolic links.
 */
#define HAS_LSTAT		/**/

/* HAS_MBLEN:
 *	This symbol, if defined, indicates that the mblen routine is available
 *	to find the number of bytes in a multibye character.
 */
#undef HAS_MBLEN		/**/

/* HAS_MBSTOWCS:
 *	This symbol, if defined, indicates that the mbstowcs routine is
 *	available to covert a multibyte string into a wide character string.
 */
#undef	HAS_MBSTOWCS		/**/

/* HAS_MBTOWC:
 *	This symbol, if defined, indicates that the mbtowc routine is available
 *	to covert a multibyte to a wide character.
 */
#undef HAS_MBTOWC		/**/

/* HAS_MEMCMP:
 *	This symbol, if defined, indicates that the memcmp routine is available
 *	to compare blocks of memory.
 */
#define HAS_MEMCMP	/**/

/* HAS_MEMCPY:
 *	This symbol, if defined, indicates that the memcpy routine is available
 *	to copy blocks of memory.
 */
#define HAS_MEMCPY	/**/

/* HAS_MEMMOVE:
 *	This symbol, if defined, indicates that the memmove routine is available
 *	to copy potentially overlapping blocks of memory. This should be used
 *	only when HAS_SAFE_BCOPY is not defined. If neither is there, roll your
 *	own version.
 */
#define HAS_MEMMOVE	/**/

/* HAS_MEMSET:
 *	This symbol, if defined, indicates that the memset routine is available
 *	to set blocks of memory.
 */
#define HAS_MEMSET	/**/

/* HAS_MKDIR:
 *	This symbol, if defined, indicates that the mkdir routine is available
 *	to create directories.  Otherwise you should fork off a new process to
 *	exec /bin/mkdir.
 */
#define HAS_MKDIR		/**/

/* HAS_MKFIFO:
 *	This symbol, if defined, indicates that the mkfifo routine is
 *	available to create FIFOs. Otherwise, mknod should be able to
 *	do it for you. However, if mkfifo is there, mknod might require
 *	super-user privileges which mkfifo will not.
 */
#undef HAS_MKFIFO		/**/

/* HAS_MKTIME:
 *	This symbol, if defined, indicates that the mktime routine is
 *	available.
 */
#define HAS_MKTIME		/**/

/* HAS_MSYNC:
 *	This symbol, if defined, indicates that the msync system call is
 *	available to synchronize a mapped file.
 */
#undef HAS_MSYNC		/**/

/* HAS_MUNMAP:
 *	This symbol, if defined, indicates that the munmap system call is
 *	available to unmap a region, usually mapped by mmap().
 */
#undef HAS_MUNMAP		/**/

/* HAS_NICE:
 *	This symbol, if defined, indicates that the nice routine is
 *	available.
 */
#undef HAS_NICE		/**/

/* HAS_PATHCONF:
 *	This symbol, if defined, indicates that pathconf() is available
 *	to determine file-system related limits and options associated
 *	with a given filename.
 */
/* HAS_FPATHCONF:
 *	This symbol, if defined, indicates that pathconf() is available
 *	to determine file-system related limits and options associated
 *	with a given open file descriptor.
 */
#undef HAS_PATHCONF		/**/
#undef HAS_FPATHCONF		/**/

/* HAS_PAUSE:
 *	This symbol, if defined, indicates that the pause routine is
 *	available to suspend a process until a signal is received.
 */
#define HAS_PAUSE		/**/

/* HAS_PIPE:
 *	This symbol, if defined, indicates that the pipe routine is
 *	available to create an inter-process channel.
 */
#define HAS_PIPE		/**/

/* HAS_POLL:
 *	This symbol, if defined, indicates that the poll routine is
 *	available to poll active file descriptors. You may safely
 *	include <poll.h> when this symbol is defined.
 */
#undef HAS_POLL		/**/

/* HAS_READDIR:
 *	This symbol, if defined, indicates that the readdir routine is
 *	available to read directory entries. You may have to include
 *	<dirent.h>. See I_DIRENT.
 */
#define HAS_READDIR		/**/

/* HAS_SEEKDIR:
 *	This symbol, if defined, indicates that the seekdir routine is
 *	available. You may have to include <dirent.h>. See I_DIRENT.
 */
#define HAS_SEEKDIR		/**/

/* HAS_TELLDIR:
 *	This symbol, if defined, indicates that the telldir routine is
 *	available. You may have to include <dirent.h>. See I_DIRENT.
 */
#define HAS_TELLDIR		/**/

/* HAS_REWINDDIR:
 *	This symbol, if defined, indicates that the rewinddir routine is
 *	available. You may have to include <dirent.h>. See I_DIRENT.
 */
#define HAS_REWINDDIR		/**/

/* HAS_READLINK:
 *	This symbol, if defined, indicates that the readlink routine is
 *	available to read the value of a symbolic link.
 */
#define HAS_READLINK		/**/

/* HAS_RENAME:
 *	This symbol, if defined, indicates that the rename routine is available
 *	to rename files.  Otherwise you should do the unlink(), link(), unlink()
 *	trick.
 */
#define HAS_RENAME	/**/

/* HAS_RMDIR:
 *	This symbol, if defined, indicates that the rmdir routine is
 *	available to remove directories. Otherwise you should fork off a
 *	new process to exec /bin/rmdir.
 */
#define HAS_RMDIR		/**/

/* HAS_SELECT:
 *	This symbol, if defined, indicates that the select routine is
 *	available to select active file descriptors. If the timeout field
 *	is used, <sys/time.h> may need to be included.
 */
#define HAS_SELECT	/**/

/* HAS_SETEGID:
 *	This symbol, if defined, indicates that the setegid routine is available
 *	to change the effective gid of the current program.
 */
#undef HAS_SETEGID		/**/

/* HAS_SETEUID:
 *	This symbol, if defined, indicates that the seteuid routine is available
 *	to change the effective uid of the current program.
 */
#undef HAS_SETEUID		/**/

/* HAS_SETLINEBUF:
 *	This symbol, if defined, indicates that the setlinebuf routine is
 *	available to change stderr or stdout from block-buffered or unbuffered
 *	to a line-buffered mode.
 */
#define HAS_SETLINEBUF		/**/

/* HAS_SETLOCALE:
 *	This symbol, if defined, indicates that the setlocale routine is
 *	available to handle locale-specific ctype implementations.
 */
#define HAS_SETLOCALE	/**/

/* HAS_SETPGID:
 *	This symbol, if defined, indicates that the setpgid(pid, gpid)
 *	routine is available to set process group ID.
 */
#undef HAS_SETPGID	/**/

/* HAS_SETPGRP:
 *	This symbol, if defined, indicates that the setpgrp routine is
 *	available to set the current process group.
 */
/* USE_BSD_SETPGRP:
 *	This symbol, if defined, indicates that setpgrp needs two
 *	arguments whereas USG one needs none.  See also HAS_SETPGID
 *	for a POSIX interface.
 */
#undef HAS_SETPGRP		/**/
#undef USE_BSD_SETPGRP	/**/

/* HAS_SETPGRP2:
 *	This symbol, if defined, indicates that the setpgrp2() (as in DG/UX)
 *	routine is available to set the current process group.
 */
#undef HAS_SETPGRP2		/**/

/* HAS_SETPRIORITY:
 *	This symbol, if defined, indicates that the setpriority routine is
 *	available to set a process's priority.
 */
#undef HAS_SETPRIORITY		/**/

/* HAS_SETREGID:
 *	This symbol, if defined, indicates that the setregid routine is
 *	available to change the real and effective gid of the current
 *	process.
 */
/* HAS_SETRESGID:
 *	This symbol, if defined, indicates that the setresgid routine is
 *	available to change the real, effective and saved gid of the current
 *	process.
 */
#undef HAS_SETREGID		/**/
#undef HAS_SETRESGID		/**/

/* HAS_SETREUID:
 *	This symbol, if defined, indicates that the setreuid routine is
 *	available to change the real and effective uid of the current
 *	process.
 */
/* HAS_SETRESUID:
 *	This symbol, if defined, indicates that the setresuid routine is
 *	available to change the real, effective and saved uid of the current
 *	process.
 */
#undef HAS_SETREUID		/**/
#undef HAS_SETRESUID		/**/

/* HAS_SETRGID:
 *	This symbol, if defined, indicates that the setrgid routine is available
 *	to change the real gid of the current program.
 */
#undef HAS_SETRGID		/**/

/* HAS_SETRUID:
 *	This symbol, if defined, indicates that the setruid routine is available
 *	to change the real uid of the current program.
 */
#undef HAS_SETRUID		/**/

/* HAS_SETSID:
 *	This symbol, if defined, indicates that the setsid routine is
 *	available to set the process group ID.
 */
#undef HAS_SETSID	/**/

/* Shmat_t:
 *	This symbol holds the return type of the shmat() system call.
 *	Usually set to 'void *' or 'char *'.
 */
/* HAS_SHMAT_PROTOTYPE:
 *	This symbol, if defined, indicates that the sys/shm.h includes
 *	a prototype for shmat().  Otherwise, it is up to the program to
 *	guess one.  Shmat_t shmat _((int, Shmat_t, int)) is a good guess,
 *	but not always right so it should be emitted by the program only
 *	when HAS_SHMAT_PROTOTYPE is not defined to avoid conflicting defs.
 */
/* #define Shmat_t $shmattype	/**/
#undef HAS_SHMAT_PROTOTYPE	/**/

/* HAS_STRCHR:
 *	This symbol is defined to indicate that the strchr()/strrchr()
 *	functions are available for string searching. If not, try the
 *	index()/rindex() pair.
 */
/* HAS_INDEX:
 *	This symbol is defined to indicate that the index()/rindex()
 *	functions are available for string searching.
 */
#define HAS_STRCHR	/**/
#undef HAS_INDEX	/**/

/* HAS_STRCOLL:
 *	This symbol, if defined, indicates that the strcoll routine is
 *	available to compare strings using collating information.
 */
#define HAS_STRCOLL	/**/

/* USE_STRUCT_COPY:
 *	This symbol, if defined, indicates that this C compiler knows how
 *	to copy structures.  If undefined, you'll need to use a block copy
 *	routine of some sort instead.
 */
#define	USE_STRUCT_COPY	/**/

/* HAS_STRTOD:
 *	This symbol, if defined, indicates that the strtod routine is
 *	available to provide better numeric string conversion than atof().
 */
#define HAS_STRTOD	/**/

/* HAS_STRTOL:
 *	This symbol, if defined, indicates that the strtol routine is available
 *	to provide better numeric string conversion than atoi() and friends.
 */
#define HAS_STRTOL	/**/

/* HAS_STRTOUL:
 *	This symbol, if defined, indicates that the strtoul routine is
 *	available to provide conversion of strings to unsigned long.
 */
#define HAS_STRTOUL	/**/

/* HAS_STRXFRM:
 *	This symbol, if defined, indicates that the strxfrm() routine is
 *	available to transform strings.
 */
#define HAS_STRXFRM	/**/

/* HAS_SYMLINK:
 *	This symbol, if defined, indicates that the symlink routine is available
 *	to create symbolic links.
 */
#define HAS_SYMLINK	/**/

/* HAS_SYSCALL:
 *	This symbol, if defined, indicates that the syscall routine is
 *	available to call arbitrary system calls. If undefined, that's tough.
 */
#undef HAS_SYSCALL	/**/

/* HAS_SYSCONF:
 *	This symbol, if defined, indicates that sysconf() is available
 *	to determine system related limits and options.
 */
#undef HAS_SYSCONF	/**/

/* HAS_SYSTEM:
 *	This symbol, if defined, indicates that the system routine is
 *	available to issue a shell command.
 */
#define HAS_SYSTEM	/**/

/* HAS_TCGETPGRP:
 *	This symbol, if defined, indicates that the tcgetpgrp routine is
 *	available to get foreground process group ID.
 */
#undef HAS_TCGETPGRP		/**/

/* HAS_TCSETPGRP:
 *	This symbol, if defined, indicates that the tcsetpgrp routine is
 *	available to set foreground process group ID.
 */
#undef HAS_TCSETPGRP		/**/

/* HAS_TRUNCATE:
 *	This symbol, if defined, indicates that the truncate routine is
 *	available to truncate files.
 */
#define HAS_TRUNCATE	/**/

/* HAS_TZNAME:
 *	This symbol, if defined, indicates that the tzname[] array is
 *	available to access timezone names.
 */
#undef HAS_TZNAME		/**/

/* HAS_UMASK:
 *	This symbol, if defined, indicates that the umask routine is
 *	available to set and get the value of the file creation mask.
 */
#undef HAS_UMASK		/**/

/* HASVOLATILE:
 *	This symbol, if defined, indicates that this C compiler knows about
 *	the volatile declaration.
 */
#define	HASVOLATILE	/**/
#ifndef HASVOLATILE
#define volatile
#endif

/* HAS_WAIT4:
 *	This symbol, if defined, indicates that wait4() exists.
 */
#undef HAS_WAIT4	/**/

/* HAS_WAITPID:
 *	This symbol, if defined, indicates that the waitpid routine is
 *	available to wait for child process.
 */
#undef HAS_WAITPID	/**/

/* HAS_WCSTOMBS:
 *	This symbol, if defined, indicates that the wcstombs routine is
 *	available to convert wide character strings to multibyte strings.
 */
#undef HAS_WCSTOMBS	/**/

/* HAS_WCTOMB:
 *	This symbol, if defined, indicates that the wctomb routine is available
 *	to covert a wide character to a multibyte.
 */
#undef HAS_WCTOMB		/**/

/* I_ARPA_INET:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <arpa/inet.h> to get inet_addr and friends declarations.
 */
#define	I_ARPA_INET		/**/

/* I_DBM:
 *	This symbol, if defined, indicates that <dbm.h> exists and should
 *	be included.
 */
/* I_RPCSVC_DBM:
 *	This symbol, if defined, indicates that <rpcsvc/dbm.h> exists and
 *	should be included.
 */
#define I_DBM	/**/
#undef I_RPCSVC_DBM	/**/

/* I_DIRENT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <dirent.h>. Using this symbol also triggers the definition
 *	of the Direntry_t define which ends up being 'struct dirent' or
 *	'struct direct' depending on the availability of <dirent.h>.
 */
/* DIRNAMLEN:
 *	This symbol, if defined, indicates to the C program that the length
 *	of directory entry names is provided by a d_namlen field.  Otherwise
 *	you need to do strlen() on the d_name field.
 */
/* Direntry_t:
 *	This symbol is set to 'struct direct' or 'struct dirent' depending on
 *	whether dirent is available or not. You should use this pseudo type to
 *	portably declare your directory entries.
 */
#define I_DIRENT		/**/
#undef DIRNAMLEN	/**/
#define Direntry_t struct dirent

/* I_DLFCN:
 *	This symbol, if defined, indicates that <dlfcn.h> exists and should
 *	be included.
 */
#undef I_DLFCN		/**/

/* I_FCNTL:
 *	This manifest constant tells the C program to include <fcntl.h>.
 */
#define I_FCNTL	/**/

/* I_FLOAT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <float.h> to get definition of symbols like DBL_MAX or
 *	DBL_MIN, i.e. machine dependent floating point values.
 */
#define I_FLOAT		/**/

/* I_LIMITS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <limits.h> to get definition of symbols like WORD_BIT or
 *	LONG_MAX, i.e. machine dependant limitations.
 */
#define I_LIMITS		/**/

/* I_LOCALE:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <locale.h>.
 */
#define	I_LOCALE		/**/

/* I_MATH:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <math.h>.
 */
#define I_MATH		/**/

/* I_MEMORY:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <memory.h>.
 */
#undef I_MEMORY		/**/

/* I_NDBM:
 *	This symbol, if defined, indicates that <ndbm.h> exists and should
 *	be included.
 */
#define I_NDBM	/**/

/* I_NET_ERRNO:
 *	This symbol, if defined, indicates that <net/errno.h> exists and 
 *	should be included.
 */
#undef I_NET_ERRNO		/**/

/* I_NETINET_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <netinet/in.h>. Otherwise, you may try <sys/in.h>.
 */
#define I_NETINET_IN	/**/

/* I_SFIO:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sfio.h>.
 */
#define	I_SFIO		/**/

/* I_STDDEF:
 *	This symbol, if defined, indicates that <stddef.h> exists and should
 *	be included.
 */
#define I_STDDEF	/**/

/* I_STDLIB:
 *	This symbol, if defined, indicates that <stdlib.h> exists and should
 *	be included.
 */
#define I_STDLIB		/**/

/* I_STRING:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <string.h> (USG systems) instead of <strings.h> (BSD systems).
 */
#define I_STRING		/**/

/* I_SYS_DIR:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/dir.h>.
 */
#undef I_SYS_DIR		/**/

/* I_SYS_FILE:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/file.h> to get definition of R_OK and friends.
 */
#undef I_SYS_FILE		/**/

/* I_SYS_IOCTL:
 *	This symbol, if defined, indicates that <sys/ioctl.h> exists and should
 *	be included. Otherwise, include <sgtty.h> or <termio.h>.
 */
#define	I_SYS_IOCTL		/**/

/* I_SYS_NDIR:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/ndir.h>.
 */
#undef I_SYS_NDIR	/**/

/* I_SYS_PARAM:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/param.h>.
 */
#undef I_SYS_PARAM		/**/

/* I_SYS_RESOURCE:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/resource.h>.
 */
#undef I_SYS_RESOURCE		/**/

/* I_SYS_SELECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct timeval.
 */
#undef I_SYS_SELECT	/**/

/* I_SYS_STAT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/stat.h>.
 */
#define	I_SYS_STAT		/**/

/* I_SYS_TIMES:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/times.h>.
 */
#undef	I_SYS_TIMES		/**/

/* I_SYS_TYPES:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/types.h>.
 */
#define	I_SYS_TYPES		/**/

/* I_SYS_UN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/un.h> to get UNIX domain socket definitions.
 */
#undef I_SYS_UN		/**/

/* I_SYS_WAIT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/wait.h>.
 */
#undef I_SYS_WAIT	/**/

/* I_TERMIO:
 *	This symbol, if defined, indicates that the program should include
 *	<termio.h> rather than <sgtty.h>.  There are also differences in
 *	the ioctl() calls that depend on the value of this symbol.
 */
/* I_TERMIOS:
 *	This symbol, if defined, indicates that the program should include
 *	the POSIX termios.h rather than sgtty.h or termio.h.
 *	There are also differences in the ioctl() calls that depend on the
 *	value of this symbol.
 */
/* I_SGTTY:
 *	This symbol, if defined, indicates that the program should include
 *	<sgtty.h> rather than <termio.h>.  There are also differences in
 *	the ioctl() calls that depend on the value of this symbol.
 */
#undef I_TERMIO		/**/
#undef I_TERMIOS		/**/
#undef I_SGTTY		/**/

/* I_UNISTD:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <unistd.h>.
 */
#define I_UNISTD		/**/

/* I_UTIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <utime.h>.
 */
#define I_UTIME		/**/

/* I_VALUES:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <values.h> to get definition of symbols like MINFLOAT or
 *	MAXLONG, i.e. machine dependant limitations.  Probably, you
 *	should use <limits.h> instead, if it is available.
 */
#undef I_VALUES		/**/

/* I_STDARG:
 *	This symbol, if defined, indicates that <stdarg.h> exists and should
 *	be included.
 */
/* I_VARARGS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <varargs.h>.
 */
#define I_STDARG		/**/
#undef I_VARARGS	/**/

/* I_VFORK:
 *	This symbol, if defined, indicates to the C program that it should
 *	include vfork.h.
 */
#undef I_VFORK	/**/

/* CAN_PROTOTYPE:
 *	If defined, this macro indicates that the C compiler can handle
 *	function prototypes.
 */
/* _:
 *	This macro is used to declare function parameters for folks who want
 *	to make declarations with prototypes using a different style than
 *	the above macros.  Use double parentheses.  For example:
 *
 *		int main _((int argc, char *argv[]));
 */
#define	CAN_PROTOTYPE	/**/
#ifdef CAN_PROTOTYPE
#define	_(args) args
#else
#define	_(args) ()
#endif

/* SH_PATH:
 *	This symbol contains the full pathname to the shell used on this
 *	on this system to execute Bourne shell scripts.  Usually, this will be
 *	/bin/sh, though it's possible that some systems will have /bin/ksh,
 *	/bin/pdksh, /bin/ash, /bin/bash, or even something such as
 *	D:/bin/sh.exe.
 */
/* #define SH_PATH "$sh"  /**/

/* STDCHAR:
 *	This symbol is defined to be the type of char used in stdio.h.
 *	It has the values "unsigned char" or "char".
 */
#define STDCHAR char	/**/


/* HAS_QUAD:
 *	This symbol, if defined, tells that there's a 64-bit integer type,
 *	Quad_t, and its unsigned counterpar, Uquad_t. QUADKIND will be one
 *	of QUAD_IS_INT, QUAD_IS_LONG, QUAD_IS_LONG_LONG, or QUAD_IS_INT64_T.
 */
#define HAS_QUAD	/**/
#ifdef HAS_QUAD
#   define Quad_t int64_t	/**/
#   define Uquad_t uint64_t	/**/
#   define QUADKIND QUAD_IS_INT64_T	/**/
#   define QUAD_IS_INT	1
#   define QUAD_IS_LONG	2
#   define QUAD_IS_LONG_LONG	3
#   define QUAD_IS_INT64_T	4
#endif

/* HAS_ACCESSX:
 *	This symbol, if defined, indicates that the accessx routine is
 *	available to do extended access checks.
 */
#undef HAS_ACCESSX		/**/

/* HAS_EACCESS:
 *	This symbol, if defined, indicates that the eaccess routine is
 *	available to do extended access checks.
 */
#undef HAS_EACCESS		/**/

/* I_SYS_ACCESS:
 *     This symbol, if defined, indicates to the C program that it should
 *     include <sys/access.h>.
 */
#undef   I_SYS_ACCESS                /**/

/* I_SYS_SECURITY:
 *     This symbol, if defined, indicates to the C program that it should
 *     include <sys/security.h>.
 */
#undef   I_SYS_SECURITY	/**/

/* CROSSCOMPILE:
 *	This symbol, if defined, signifies that we our
 *	build process is a cross-compilation.
 */
#undef CROSSCOMPILE		/**/

/* INTSIZE:
 *	This symbol contains the value of sizeof(int) so that the C
 *	preprocessor can make decisions based on it.
 */
/* LONGSIZE:
 *	This symbol contains the value of sizeof(long) so that the C
 *	preprocessor can make decisions based on it.
 */
/* SHORTSIZE:
 *	This symbol contains the value of sizeof(short) so that the C
 *	preprocessor can make decisions based on it.
 */
#define INTSIZE 	4		/**/
#define LONGSIZE 	4		/**/
#define SHORTSIZE 	2		/**/

/* MULTIARCH:
 *	This symbol, if defined, signifies that the build
 *	process will produce some binary files that are going to be
 *	used in a cross-platform environment.  This is the case for
 *	example with the NeXT "fat" binaries that contain executables
 *	for several CPUs.
 */
#define MULTIARCH		/**/

/* MEM_ALIGNBYTES:
 *	This symbol contains the number of bytes required to align a
 *	double. Usual values are 2, 4 and 8. The default is eight,
 *	for safety.
 */
#if defined(CROSSCOMPILE) || defined(MULTIARCH)
#  define MEM_ALIGNBYTES 8
#else
#define MEM_ALIGNBYTES 8
#endif

/* BYTEORDER:
 *	This symbol holds the hexadecimal constant defined in byteorder,
 *	i.e. 0x1234 or 0x4321, etc...
 *	If the compiler supports cross-compiling or multiple-architecture
 *	binaries (eg. on NeXT systems), use compiler-defined macros to
 *	determine the byte order.
 *	On NeXT 3.2 (and greater), you can build "Fat" Multiple Architecture
 *	Binaries (MAB) on either big endian or little endian machines.
 *	The endian-ness is available at compile-time.  This only matters
 *	for perl, where the config.h can be generated and installed on 
 *	one system, and used by a different architecture to build an
 *	extension.  Older versions of NeXT that might not have
 *	defined either *_ENDIAN__ were all on Motorola 680x0 series,
 *	so the default case (for NeXT) is big endian to catch them. 
 *	This might matter for NeXT 3.0.
 */
#if defined(CROSSCOMPILE) || defined(MULTIARCH)
#  ifdef __LITTLE_ENDIAN__
#    if LONGSIZE == 4
#      define BYTEORDER 0x1234
#    else
#      if LONGSIZE == 8
#        define BYTEORDER 0x12345678
#      endif
#    endif
#  else
#    ifdef __BIG_ENDIAN__
#      if LONGSIZE == 4
#        define BYTEORDER 0x4321
#      else
#        if LONGSIZE == 8
#          define BYTEORDER 0x87654321
#        endif
#      endif
#    endif
#  endif
#  if !defined(BYTEORDER) && (defined(NeXT) || defined(__NeXT__))
#    define BYTEORDER 0x4321
#  endif
#else
#define BYTEORDER 0x4321	/* large digits for MSB */
#endif /* NeXT */

/* CASTI32:
 *	This symbol is defined if the C compiler can cast negative
 *	or large floating point numbers to 32-bit ints.
 */
#define	CASTI32		/**/

/* CASTNEGFLOAT:
 *	This symbol is defined if the C compiler can cast negative
 *	numbers to unsigned longs, ints and shorts.
 */
/* CASTFLAGS:
 *	This symbol contains flags that say what difficulties the compiler
 *	has casting odd floating values to unsigned long:
 *		0 = ok
 *		1 = couldn't cast < 0
 *		2 = couldn't cast >= 0x80000000
 *		4 = couldn't cast in argument expression list
 */
#undef	CASTNEGFLOAT		/**/
#define CASTFLAGS 1		/**/

/* VOID_CLOSEDIR:
 *	This symbol, if defined, indicates that the closedir() routine
 *	does not return a value.
 */
#define VOID_CLOSEDIR /**/

/* HAS_FD_SET:
 *	This symbol, when defined, indicates presence of the fd_set typedef
 *	in <sys/types.h>
 */
#define HAS_FD_SET /**/

/* Gconvert:
 *	This preprocessor macro is defined to convert a floating point
 *	number to a string without a trailing decimal point.  This
 *	emulates the behavior of sprintf("%g"), but is sometimes much more
 *	efficient.  If gconvert() is not available, but gcvt() drops the
 *	trailing decimal point, then gcvt() is used.  If all else fails,
 *	a macro using sprintf("%g") is used. Arguments for the Gconvert
 *	macro are: value, number of digits, whether trailing zeros should
 *	be retained, and the output buffer.
 *	Possible values are:
 *		d_Gconvert='gconvert((x),(n),(t),(b))'
 *		d_Gconvert='gcvt((x),(n),(b))'
 *		d_Gconvert='sprintf((b),"%.*g",(n),(x))'
 *	The last two assume trailing zeros should not be kept.
 */
#define Gconvert(x,n,t,b) sprintf((b),"%.*g",(n),(x))

/* HAS_GNULIBC:
 *	This symbol, if defined, indicates to the C program that 
 *	the GNU C library is being used.
 */
#undef HAS_GNULIBC /**/
/* HAS_ISASCII:
 *	This manifest constant lets the C program know that isascii 
 *	is available.
 */
#define HAS_ISASCII /**/

/* HAS_LCHOWN:
 *	This symbol, if defined, indicates that the lchown routine is
 *	available to operate on a symbolic link (instead of following the
 *	link).
 */
#undef HAS_LCHOWN /**/

/* HAS_OPEN3:
 *	This manifest constant lets the C program know that the three
 *	argument form of open(2) is available.
 */
#undef HAS_OPEN3 /**/

/* HAS_SAFE_BCOPY:
 *	This symbol, if defined, indicates that the bcopy routine is available
 *	to copy potentially overlapping memory blocks. Otherwise you should
 *	probably use memmove() or memcpy(). If neither is defined, roll your
 *	own version.
 */
#define HAS_SAFE_BCOPY /**/

/* HAS_SAFE_MEMCPY:
 *	This symbol, if defined, indicates that the memcpy routine is available
 *	to copy potentially overlapping memory blocks. Otherwise you should
 *	probably use memmove() or memcpy(). If neither is defined, roll your
 *	own version.
 */
#undef HAS_SAFE_MEMCPY /**/

/* HAS_SANE_MEMCMP:
 *	This symbol, if defined, indicates that the memcmp routine is available
 *	and can be used to compare relative magnitudes of chars with their high
 *	bits set.  If it is not defined, roll your own version.
 */
#define HAS_SANE_MEMCMP / **/

/* HAS_SIGACTION:
 *	This symbol, if defined, indicates that Vr4's sigaction() routine
 *	is available.
 */
#define HAS_SIGACTION /**/

/* HAS_SIGSETJMP:
 *	This variable indicates to the C program that the sigsetjmp()
 *	routine is available to save the calling process's registers
 *	and stack environment for later use by siglongjmp(), and
 *	to optionally save the process's signal mask.  See
 *	Sigjmp_buf, Sigsetjmp, and Siglongjmp.
 */
/* Sigjmp_buf:
 *	This is the buffer type to be used with Sigsetjmp and Siglongjmp.
 */
/* Sigsetjmp:
 *	This macro is used in the same way as sigsetjmp(), but will invoke
 *	traditional setjmp() if sigsetjmp isn't available.
 *	See HAS_SIGSETJMP.
 */
/* Siglongjmp:
 *	This macro is used in the same way as siglongjmp(), but will invoke
 *	traditional longjmp() if siglongjmp isn't available.
 *	See HAS_SIGSETJMP.
 */
#undef HAS_SIGSETJMP /**/
#ifdef HAS_SIGSETJMP
#define Sigjmp_buf sigjmp_buf
#define Sigsetjmp(buf,save_mask) sigsetjmp((buf),(save_mask))
#define Siglongjmp(buf,retval) siglongjmp((buf),(retval))
#else
#define Sigjmp_buf jmp_buf
#define Sigsetjmp(buf,save_mask) setjmp((buf))
#define Siglongjmp(buf,retval) longjmp((buf),(retval))
#endif

/* USE_STDIO_PTR:
 *	This symbol is defined if the _ptr and _cnt fields (or similar)
 *	of the stdio FILE structure can be used to access the stdio buffer
 *	for a file handle.  If this is defined, then the FILE_ptr(fp)
 *	and FILE_cnt(fp) macros will also be defined and should be used
 *	to access these fields.
 */
/* FILE_ptr:
 *	This macro is used to access the _ptr field (or equivalent) of the
 *	FILE structure pointed to by its argument. This macro will always be
 *	defined if USE_STDIO_PTR is defined.
 */
/* STDIO_PTR_LVALUE:
 *	This symbol is defined if the FILE_ptr macro can be used as an
 *	lvalue.
 */
/* FILE_cnt:
 *	This macro is used to access the _cnt field (or equivalent) of the
 *	FILE structure pointed to by its argument. This macro will always be
 *	defined if USE_STDIO_PTR is defined.
 */
/* STDIO_CNT_LVALUE:
 *	This symbol is defined if the FILE_cnt macro can be used as an
 *	lvalue.
 */
#define USE_STDIO_PTR /**/
#ifdef USE_STDIO_PTR
#define FILE_ptr(fp) ((fp)->_Next)
#define STDIO_PTR_LVALUE /**/
#define FILE_cnt(fp) (((fp)->_Rend > (fp)->_Next) ? (fp)->_Rend - (fp)->_Next : 0)
#undef STDIO_CNT_LVALUE /**/
#endif

/* USE_STDIO_BASE:
 *	This symbol is defined if the _base field (or similar) of the
 *	stdio FILE structure can be used to access the stdio buffer for
 *	a file handle.  If this is defined, then the FILE_base(fp) macro
 *	will also be defined and should be used to access this field.
 *	Also, the FILE_bufsiz(fp) macro will be defined and should be used
 *	to determine the number of bytes in the buffer.  USE_STDIO_BASE
 *	will never be defined unless USE_STDIO_PTR is.
 */
/* FILE_base:
 *	This macro is used to access the _base field (or equivalent) of the
 *	FILE structure pointed to by its argument. This macro will always be
 *	defined if USE_STDIO_BASE is defined.
 */
/* FILE_bufsiz:
 *	This macro is used to determine the number of bytes in the I/O
 *	buffer pointed to by _base field (or equivalent) of the FILE
 *	structure pointed to its argument. This macro will always be defined
 *	if USE_STDIO_BASE is defined.
 */
#define USE_STDIO_BASE /**/
#ifdef USE_STDIO_BASE
#define FILE_base(fp) ((fp)->_Buf)
#define FILE_bufsiz(fp) ((fp)->_Rend - (fp)->_Buf)
#endif

/* HAS_VPRINTF:
 *	This symbol, if defined, indicates that the vprintf routine is available
 *	to printf with a pointer to an argument list.  If unavailable, you
 *	may need to write your own, probably in terms of _doprnt().
 */
/* USE_CHAR_VSPRINTF:
 *	This symbol is defined if this system has vsprintf() returning type
 *	(char*).  The trend seems to be to declare it as "int vsprintf()".  It
 *	is up to the package author to declare vsprintf correctly based on the
 *	symbol.
 */
#define HAS_VPRINTF /**/
#define USE_CHAR_VSPRINTF /**/

/* DOUBLESIZE:
 *	This symbol contains the size of a double, so that the C preprocessor
 *	can make decisions based on it.
 */
#define DOUBLESIZE 8

/* I_TIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <time.h>.
 */
/* I_SYS_TIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h>.
 */
/* I_SYS_TIME_KERNEL:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h> with KERNEL defined.
 */
#define I_TIME /**/
#define I_SYS_TIME /**/
#undef I_SYS_TIME_KERNEL /**/

/* VAL_O_NONBLOCK:
 *	This symbol is to be used during open() or fcntl(F_SETFL) to turn on
 *	non-blocking I/O for the file descriptor. Note that there is no way
 *	back, i.e. you cannot turn it blocking again this way. If you wish to
 *	alternatively switch between blocking and non-blocking, use the
 *	ioctl(FIOSNBIO) call instead, but that is not supported by all devices.
 */
/* VAL_EAGAIN:
 *	This symbol holds the errno error code set by read() when no data was
 *	present on the non-blocking file descriptor.
 */
/* RD_NODATA:
 *	This symbol holds the return code from read() when no data is present
 *	on the non-blocking file descriptor. Be careful! If EOF_NONBLOCK is
 *	not defined, then you can't distinguish between no data and EOF by
 *	issuing a read(). You'll have to find another way to tell for sure!
 */
/* EOF_NONBLOCK:
 *	This symbol, if defined, indicates to the C program that a read() on
 *	a non-blocking file descriptor will return 0 on EOF, and not the value
 *	held in RD_NODATA (-1 usually, in that case!).
 */
#define VAL_O_NONBLOCK O_NONBLOCK
#define VAL_EAGAIN EWOULDBLOCK
#define RD_NODATA -1
#define EOF_NONBLOCK

/* PTRSIZE:
 *	This symbol contains the size of a pointer, so that the C preprocessor
 *	can make decisions based on it.  It will be sizeof(void *) if
 *	the compiler supports (void *); otherwise it will be
 *	sizeof(char *).
 */
#define PTRSIZE 4

/* Drand01:
 *	This macro is to be used to generate uniformly distributed
 *	random numbers over the range [0., 1.[.  You may have to supply
 *	an 'extern double drand48();' in your program since SunOS 4.1.3
 *	doesn't provide you with anything relevant in it's headers.
 *	See HAS_DRAND48_PROTO.
 */
/* Rand_seed_t:
 *	This symbol defines the type of the argument of the
 *	random seed function.
 */
/* seedDrand01:
 *	This symbol defines the macro to be used in seeding the
 *	random number generator (see Drand01).
 */
/* RANDBITS:
 *	This symbol indicates how many bits are produced by the
 *	function used to generate normalized random numbers.
 *	Values include 15, 16, 31, and 48.
 */
#define Drand01() (rand()/(RAND_MAX+1))
#define Rand_seed_t unsigned int
#define seedDrand01(x) srand((Rand_seed_t)x)
#define RANDBITS 15		/**/

/* SSize_t:
 *	This symbol holds the type used by functions that return
 *	a count of bytes or an error condition.  It must be a signed type.
 *	It is usually ssize_t, but may be long or int, etc.
 *	It may be necessary to include <sys/types.h> or <unistd.h>
 *	to get any typedef'ed information.
 *	We will pick a type such that sizeof(SSize_t) == sizeof(Size_t).
 */
#define SSize_t ssize_t	 /* signed count of bytes */

/* EBCDIC:
 *     This symbol, if defined, indicates that this system uses
 *	EBCDIC encoding.
 */
#undef EBCDIC /**/

/* ARCHLIB:
 *	This variable, if defined, holds the name of the directory in
 *	which the user wants to put architecture-dependent public
 *	library files for $package.  It is most often a local directory
 *	such as /usr/local/lib.  Programs using this variable must be
 *	prepared to deal with filename expansion.  If ARCHLIB is the
 *	same as PRIVLIB, it is not defined, since presumably the
 *	program already searches PRIVLIB.
 */
/* ARCHLIB_EXP:
 *	This symbol contains the ~name expanded version of ARCHLIB, to be used
 *	in programs that are not prepared to deal with ~ expansion at run-time.
 */
#undef ARCHLIB /**/
#undef ARCHLIB_EXP /**/

/* BIN:
 *	This symbol holds the path of the bin directory where the package will
 *	be installed. Program must be prepared to deal with ~name substitution.
 */
/* BIN_EXP:
 *	This symbol is the filename expanded version of the BIN symbol, for
 *	programs that do not want to deal with that at run-time.
 */
#define BIN "~:Tools:"	/**/
#define BIN_EXP ""	/**/

/* INSTALL_USR_BIN_PERL:
 *	This symbol, if defined, indicates that Perl is to be installed
 * 	also as /usr/bin/perl.
 */
#undef INSTALL_USR_BIN_PERL /**/

/* PRIVLIB:
 *	This symbol contains the name of the private library for this package.
 *	The library is private in the sense that it needn't be in anyone's
 *	execution path, but it should be accessible by the world.  The program
 *	should be prepared to do ~ expansion.
 */
/* PRIVLIB_EXP:
 *	This symbol contains the ~name expanded version of PRIVLIB, to be used
 *	in programs that are not prepared to deal with ~ expansion at run-time.
 */
#undef PRIVLIB 	/**/
#define PRIVLIB_EXP ""

/* SITEARCH:
 *	This symbol contains the name of the private library for this package.
 *	The library is private in the sense that it needn't be in anyone's
 *	execution path, but it should be accessible by the world.  The program
 *	should be prepared to do ~ expansion.
 *	The standard distribution will put nothing in this directory.
 *	Individual sites may place their own extensions and modules in
 *	this directory.
 */
/* SITEARCH_EXP:
 *	This symbol contains the ~name expanded version of SITEARCH, to be used
 *	in programs that are not prepared to deal with ~ expansion at run-time.
 */
#undef SITEARCH /**/
#undef SITEARCH_EXP /**/

/* SITELIB:
 *	This symbol contains the name of the private library for this package.
 *	The library is private in the sense that it needn't be in anyone's
 *	execution path, but it should be accessible by the world.  The program
 *	should be prepared to do ~ expansion.
 *	The standard distribution will put nothing in this directory.
 *	Individual sites may place their own extensions and modules in
 *	this directory.
 */
/* SITELIB_EXP:
 *	This symbol contains the ~name expanded version of SITELIB, to be used
 *	in programs that are not prepared to deal with ~ expansion at run-time.
 */
#undef SITELIB /**/
#undef SITELIB_EXP /**/

/* PERL_VENDORLIB_EXP:
 *	This symbol contains the ~name expanded version of VENDORLIB, to be used
 *	in programs that are not prepared to deal with ~ expansion at run-time.
 */
#undef PERL_VENDORLIB_EXP /**/

/* OSNAME:
 *	This symbol contains the name of the operating system, as determined
 *	by Configure.  You shouldn't rely on it too much; the specific
 *	feature tests from Configure are generally more reliable.
 */
#define OSNAME "MacOS"		/**/

/* CAT2:
 *	This macro catenates 2 tokens together.
 */
/* STRINGIFY:
 *	This macro surrounds its token with double quotes.
 */
#if 42 == 1
#define CAT2(a,b)a/**/b
#define STRINGIFY(a)"a"
		/* If you can get stringification with catify, tell me how! */
#endif
#if 42 == 42
#define CAT2(a,b)a ## b
#define StGiFy(a)# a
#define STRINGIFY(a)StGiFy(a)
#endif
#if 42 != 1 && 42 != 42
#include "Bletch: How does this C preprocessor catenate tokens?"
#endif

/* CPPSTDIN:
 *	This symbol contains the first part of the string which will invoke
 *	the C preprocessor on the standard input and produce to standard
 *	output.	 Typical value of "cc -E" or "/lib/cpp", but it can also
 *	call a wrapper. See CPPRUN.
 */
/* CPPMINUS:
 *	This symbol contains the second part of the string which will invoke
 *	the C preprocessor on the standard input and produce to standard
 *	output.  This symbol will have the value "-" if CPPSTDIN needs a minus
 *	to specify standard input, otherwise the value is "".
 */
/* CPPRUN:
 *	This symbol contains the string which will invoke a C preprocessor on
 *	the standard input and produce to standard output. It needs to end
 *	with CPPLAST, after all other preprocessor flags have been specified.
 *	The main difference with CPPSTDIN is that this program will never be a
 *	pointer to a shell wrapper, i.e. it will be empty if no preprocessor is
 *	available directly to the user. Note that it may well be different from
 *	the preprocessor used to compile the C program.
 */
#define CPPSTDIN "C -e"
#define CPPMINUS  "Dev:Console"
#undef CPPRUN /**/

/* HAS_ACCESS:
 *	This manifest constant lets the C program know that the access()
 *	system call is available to check for accessibility using real UID/GID.
 *	(always present on UNIX.)
 */
#define HAS_ACCESS /**/

/* HAS_CSH:
 *	This symbol, if defined, indicates that the C-shell exists.
 */
/* CSH:
 *	This symbol, if defined, contains the full pathname of csh.
 */
#undef HAS_CSH /**/
#ifdef HAS_CSH
#define CSH /**/
#endif

/* HAS_ENDGRENT:
 *	This symbol, if defined, indicates that the getgrent routine is
 *	available for finalizing sequential access of the group database.
 */
#undef HAS_ENDGRENT /**/

/* HAS_ENDHOSTENT:
 *	This symbol, if defined, indicates that the endhostent() routine is
 *	available to close whatever was being used for host queries.
 */
#undef HAS_ENDHOSTENT /**/

/* HAS_ENDNETENT:
 *	This symbol, if defined, indicates that the endnetent() routine is
 *	available to close whatever was being used for network queries.
 */
#undef HAS_ENDNETENT /**/

/* HAS_ENDPROTOENT:
 *	This symbol, if defined, indicates that the endprotoent() routine is
 *	available to close whatever was being used for protocol queries.
 */
#undef HAS_ENDPROTOENT /**/

/* HAS_ENDPWENT:
 *	This symbol, if defined, indicates that the getgrent routine is
 *	available for finalizing sequential access of the passwd database.
 */
#undef HAS_ENDPWENT /**/

/* HAS_ENDSERVENT:
 *	This symbol, if defined, indicates that the endservent() routine is
 *	available to close whatever was being used for service queries.
 */
#define HAS_ENDSERVENT /**/

/* HAS_GETGRENT:
 *	This symbol, if defined, indicates that the getgrent routine is
 *	available for sequential access of the group database.
 */
#undef HAS_GETGRENT /**/

/* HAS_GETHOSTBYADDR:
 *	This symbol, if defined, indicates that the gethostbyaddr() routine is
 *	available to look up hosts by their IP addresses.
 */
#define HAS_GETHOSTBYADDR /**/

/* HAS_GETHOSTBYNAME:
 *	This symbol, if defined, indicates that the gethostbyname() routine is
 *	available to look up host names in some data base or other.
 */
#define HAS_GETHOSTBYNAME /**/

/* HAS_GETHOSTENT:
 *	This symbol, if defined, indicates that the gethostent() routine is
 *	available to look up host names in some data base or another.
 */
#undef HAS_GETHOSTENT /**/

/* HAS_GETHOSTNAME:
 *	This symbol, if defined, indicates that the C program may use the
 *	gethostname() routine to derive the host name.  See also HAS_UNAME
 *	and PHOSTNAME.
 */
/* HAS_UNAME:
 *	This symbol, if defined, indicates that the C program may use the
 *	uname() routine to derive the host name.  See also HAS_GETHOSTNAME
 *	and PHOSTNAME.
 */
/* PHOSTNAME:
 *	This symbol, if defined, indicates the command to feed to the
 *	popen() routine to derive the host name.  See also HAS_GETHOSTNAME
 *	and HAS_UNAME.	Note that the command uses a fully qualified path,
 *	so that it is safe even if used by a process with super-user
 *	privileges.
 */
#define HAS_GETHOSTNAME /**/
#undef HAS_UNAME /**/
#undef HAS_PHOSTNAME
#ifdef HAS_PHOSTNAME
#define PHOSTNAME /**/
#endif

/* HAS_GETNETBYADDR:
 *	This symbol, if defined, indicates that the getnetbyaddr() routine is
 *	available to look up networks by their IP addresses.
 */
#undef HAS_GETNETBYADDR /**/

/* HAS_GETNETBYNAME:
 *	This symbol, if defined, indicates that the getnetbyname() routine is
 *	available to look up networks by their names.
 */
#undef HAS_GETNETBYNAME /**/

/* HAS_GETNETENT:
 *	This symbol, if defined, indicates that the getnetent() routine is
 *	available to look up network names in some data base or another.
 */
#undef HAS_GETNETENT /**/

/* HAS_GETPROTOENT:
 *	This symbol, if defined, indicates that the getprotoent() routine is
 *	available to look up protocols in some data base or another.
 */
#undef HAS_GETPROTOENT /**/

/* HAS_GETPROTOBYNAME:
 *	This symbol, if defined, indicates that the getprotobyname()
 *	routine is available to look up protocols by their name.
 */
/* HAS_GETPROTOBYNUMBER:
 *	This symbol, if defined, indicates that the getprotobynumber()
 *	routine is available to look up protocols by their number.
 */
#define HAS_GETPROTOBYNAME /**/
#define HAS_GETPROTOBYNUMBER /**/

/* HAS_GETPWENT:
 *	This symbol, if defined, indicates that the getpwent routine is
 *	available for sequential access of the passwd database.
 *	If this is not available, the older getpw() function may be available.
 */
#undef HAS_GETPWENT /**/

/* HAS_GETSERVENT:
 *	This symbol, if defined, indicates that the getservent() routine is
 *	available to look up network services in some data base or another.
 */
#define HAS_GETSERVENT /**/

/* HAS_GETSERVBYNAME:
 *	This symbol, if defined, indicates that the getservbyname()
 *	routine is available to look up services by their name.
 */
/* HAS_GETSERVBYPORT:
 *	This symbol, if defined, indicates that the getservbyport()
 *	routine is available to look up services by their port.
 */
#define HAS_GETSERVBYNAME /**/
#define HAS_GETSERVBYPORT /**/

/* HAS_HTONL:
 *	This symbol, if defined, indicates that the htonl() routine (and
 *	friends htons() ntohl() ntohs()) are available to do network
 *	order byte swapping.
 */
/* HAS_HTONS:
 *	This symbol, if defined, indicates that the htons() routine (and
 *	friends htonl() ntohl() ntohs()) are available to do network
 *	order byte swapping.
 */
/* HAS_NTOHL:
 *	This symbol, if defined, indicates that the ntohl() routine (and
 *	friends htonl() htons() ntohs()) are available to do network
 *	order byte swapping.
 */
/* HAS_NTOHS:
 *	This symbol, if defined, indicates that the ntohs() routine (and
 *	friends htonl() htons() ntohl()) are available to do network
 *	order byte swapping.
 */
#define HAS_HTONL /**/
#define HAS_HTONS /**/
#define HAS_NTOHL /**/
#define HAS_NTOHS /**/

/* HAS_LONG_DOUBLE:
 *	This symbol will be defined if the C compiler supports long
 *	doubles.
 */
/* LONG_DOUBLESIZE:
 *	This symbol contains the size of a long double, so that the 
 *	C preprocessor can make decisions based on it.  It is only
 *	defined if the system supports long doubles.
 */
#undef HAS_LONG_DOUBLE /**/
#ifdef HAS_LONG_DOUBLE
#define LONG_DOUBLESIZE /**/
#endif

/* HAS_LONG_LONG:
 *	This symbol will be defined if the C compiler supports long long.
 */
/* LONGLONGSIZE:
 *	This symbol contains the size of a long long, so that the 
 *	C preprocessor can make decisions based on it.  It is only
 *	defined if the system supports long long.
 */
#undef HAS_LONG_LONG /**/
#ifdef HAS_LONG_LONG
#define LONGLONGSIZE /**/
#endif

/* HAS_MEMCHR:
 *	This symbol, if defined, indicates that the memchr routine is available
 *	to locate characters within a C string.
 */
#define HAS_MEMCHR /**/

/* HAS_MMAP:
 *	This symbol, if defined, indicates that the mmap system call is
 *	available to map a file into memory.
 */
/* Mmap_t:
 *	This symbol holds the return type of the mmap() system call
 *	(and simultaneously the type of the first argument).
 *	Usually set to 'void *' or 'cadd_t'.
 */
#undef HAS_MMAP /**/
#define Mmap_t /**/

/* HAS_MSG:
 *	This symbol, if defined, indicates that the entire msg*(2) library is
 *	supported (IPC mechanism based on message queues).
 */
#undef HAS_MSG /**/

/* HAS_SEM:
 *	This symbol, if defined, indicates that the entire sem*(2) library is
 *	supported.
 */
#undef HAS_SEM /**/

/* HAS_SETGRENT:
 *	This symbol, if defined, indicates that the setgrent routine is
 *	available for initializing sequential access of the group database.
 */
#undef HAS_SETGRENT /**/

/* HAS_SETGROUPS:
 *	This symbol, if defined, indicates that the setgroups() routine is
 *	available to set the list of process groups.  If unavailable, multiple
 *	groups are probably not supported.
 */
#undef HAS_SETGROUPS /**/

/* HAS_SETHOSTENT:
 *	This symbol, if defined, indicates that the sethostent() routine is
 *	available.
 */
#undef HAS_SETHOSTENT /**/

/* HAS_SETNETENT:
 *	This symbol, if defined, indicates that the setnetent() routine is
 *	available.
 */
#undef HAS_SETNETENT /**/

/* HAS_SETPROTOENT:
 *	This symbol, if defined, indicates that the setprotoent() routine is
 *	available.
 */
#undef HAS_SETPROTOENT /**/

/* HAS_SETPWENT:
 *	This symbol, if defined, indicates that the setpwent routine is
 *	available for initializing sequential access of the passwd database.
 */
#undef HAS_SETPWENT /**/

/* HAS_SETSERVENT:
 *	This symbol, if defined, indicates that the setservent() routine is
 *	available.
 */
#undef HAS_SETSERVENT /**/

/* HAS_SETVBUF:
 *	This symbol, if defined, indicates that the setvbuf routine is
 *	available to change buffering on an open stdio stream.
 *	to a line-buffered mode.
 */
#define HAS_SETVBUF /**/

/* HAS_SHM:
 *	This symbol, if defined, indicates that the entire shm*(2) library is
 *	supported.
 */
#undef HAS_SHM /**/

/* HAS_SOCKET:
 *	This symbol, if defined, indicates that the BSD socket interface is
 *	supported.
 */
/* HAS_SOCKETPAIR:
 *	This symbol, if defined, indicates that the BSD socketpair() call is
 *	supported.
 */
/* HAS_MSG_CTRUNC:
 *	This symbol, if defined, indicates that the MSG_CTRUNC is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_MSG_DONTROUTE:
 *	This symbol, if defined, indicates that the MSG_DONTROUTE is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_MSG_OOB:
 *	This symbol, if defined, indicates that the MSG_OOB is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_MSG_PEEK:
 *	This symbol, if defined, indicates that the MSG_PEEK is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_MSG_PROXY:
 *	This symbol, if defined, indicates that the MSG_PROXY is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_SCM_RIGHTS:
 *	This symbol, if defined, indicates that the SCM_RIGHTS is supported.
 *	Checking just with #ifdef might not be enough because this symbol
 *	has been known to be an enum.
 */
/* HAS_SENDMSG:
 *	This symbol, if defined, indicates that the sendmsg is supported
 *	to send messages between sockets.  You will also need struct
 *	iovec from <sys/uio.h>, HAS_STRUCT_IOVEC and I_SYSUIO.
 */
/* HAS_RECVMSG:
 *	This symbol, if defined, indicates that the recvmsg is supported
 *	to send messages between sockets.  You will also need struct
 *	iovec from <sys/uio.h>, HAS_STRUCT_IOVEC and I_SYSUIO.
 */
/* HAS_STRUCT_MSGHDR:
 *	This symbol, if defined, indicates that the struct msghdr
 *	(BSD 4.3 or 4.4) is supported.  You will also need struct
 *	iovec from <sys/uio.h>, HAS_STRUCT_IOVEC and I_SYSUIO.
 */
/* HAS_STRUCT_CMSGHDR:
 *	This symbol, if defined, indicates that the struct cmsghdr
 *	(BSD 4.4) is supported.  You will also need struct
 *	iovec from <sys/uio.h>, HAS_STRUCT_IOVEC and I_SYSUIO.
 */
#define HAS_SOCKET /**/
#define HAS_SOCKETPAIR /**/
#undef HAS_MSG_CTRUNC /**/
#undef HAS_MSG_DONTROUTE /**/
#define HAS_MSG_OOB /**/
#define HAS_MSG_PEEK /**/
#undef HAS_MSG_PROXY /**/
#undef HAS_SCM_RIGHTS /**/
#undef HAS_SENDMSG /**/
#undef HAS_RECVMSG /**/
#undef HAS_STRUCT_MSGHDR /**/
#undef HAS_STRUCT_CMSGHDR /**/

/* USE_STAT_BLOCKS:
 *	This symbol is defined if this system has a stat structure declaring
 *	st_blksize and st_blocks.
 */
#define USE_STAT_BLOCKS /**/

/* HAS_STRERROR:
 *	This symbol, if defined, indicates that the strerror routine is
 *	available to translate error numbers to strings. See the writeup
 *	of Strerror() in this file before you try to define your own.
 */
/* HAS_SYS_ERRLIST:
 *	This symbol, if defined, indicates that the sys_errlist array is
 *	available to translate error numbers to strings. The extern int
 *	sys_nerr gives the size of that table.
 */
/* Strerror:
 *	This preprocessor symbol is defined as a macro if strerror() is
 *	not available to translate error numbers to strings but sys_errlist[]
 *	array is there.
 */
#undef HAS_STRERROR /**/
#define HAS_SYS_ERRLIST /**/
/* #undef Strerror(e) /**/

/* HAS_UNION_SEMUN:
 *	This symbol, if defined, indicates that the union semun is
 *	defined by including <sys/sem.h>.  If not, the user code
 *	probably needs to define it as:
 *	union semun {
 *	    int val;
 *	    struct semid_ds *buf;
 *	    unsigned short *array;
 *	}
 */
/* USE_SEMCTL_SEMUN:
 *	This symbol, if defined, indicates that union semun is
 *	used for semctl IPC_STAT.
 */
/* USE_SEMCTL_SEMID_DS:
 *	This symbol, if defined, indicates that struct semid_ds * is
 *	used for semctl IPC_STAT.
 */
#undef HAS_UNION_SEMUN /**/
#undef USE_SEMCTL_SEMUN /**/
#undef USE_SEMCTL_SEMID_DS /**/

/* HAS_VFORK:
 *	This symbol, if defined, indicates that vfork() exists.
 */
#define HAS_VFORK /**/

/* Signal_t:
 *	This symbol's value is either "void" or "int", corresponding to the
 *	appropriate return type of a signal handler.  Thus, you can declare
 *	a signal handler using "Signal_t (*handler)()", and define the
 *	handler using "Signal_t handler(sig)".
 */
#define Signal_t void	/* Signal handler's return type */

/* Groups_t:
 *	This symbol holds the type used for the second argument to
 *	getgroups() and setgropus().  Usually, this is the same as
 *	gidtype (gid_t) , but sometimes it isn't.
 *	It can be int, ushort, uid_t, etc... 
 *	It may be necessary to include <sys/types.h> to get any 
 *	typedef'ed information.  This is only required if you have
 *	getgroups() or setgropus()..
 */
#if defined(HAS_GETGROUPS) || defined(HAS_SETGROUPS)
#define Groups_t gid_t	/* Type for 2nd arg to getgroups() */
#endif

/* I_GRP:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <grp.h>.
 */
/* GRPASSWD:
 *	This symbol, if defined, indicates to the C program that struct group
 *	in <grp.h> contains gr_passwd.
 */
#undef I_GRP /**/
#undef GRPASSWD /**/

/* I_NETDB:
 *	This symbol, if defined, indicates that <netdb.h> exists and
 *	should be included.
 */
#define I_NETDB /**/

/* I_PWD:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <pwd.h>.
 */
/* PWQUOTA:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_quota.
 */
/* PWAGE:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_age.
 */
/* PWCHANGE:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_change.
 */
/* PWCLASS:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_class.
 */
/* PWEXPIRE:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_expire.
 */
/* PWCOMMENT:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_comment.
 */
/* PWGECOS:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_gecos.
 */
/* PWPASSWD:
 *	This symbol, if defined, indicates to the C program that struct passwd
 *	contains pw_passwd.
 */
#undef I_PWD /**/
#undef PWQUOTA /**/
#undef PWAGE /**/
#undef PWCHANGE /**/
#undef PWCLASS /**/
#undef PWEXPIRE /**/
#undef PWCOMMENT /**/
#undef PWGECOS /**/
#undef PWPASSWD /**/

/* I_SYSUIO:
 *	This symbol, if defined, indicates that <sys/uio.h> exists and
 *	should be included.
 */
#undef I_SYSUIO /**/

/* Free_t:
 *	This variable contains the return type of free().  It is usually
 * void, but occasionally int.
 */
/* Malloc_t:
 *	This symbol is the type of pointer returned by malloc and realloc.
 */
#define Malloc_t void *			/**/
#define Free_t void			/**/

/* MYMALLOC:
 *	This symbol, if defined, indicates that we're using our own malloc.
 */
#undef MYMALLOC /**/

/* SIG_NAME:
 *	This symbol contains a list of signal names in order of
 *	signal number. This is intended
 *	to be used as a static array initialization, like this:
 *		char *sig_name[] = { SIG_NAME };
 *	The signals in the list are separated with commas, and each signal
 *	is surrounded by double quotes. There is no leading SIG in the signal
 *	name, i.e. SIGQUIT is known as "QUIT".
 *	Gaps in the signal numbers (up to NSIG) are filled in with NUMnn,
 *	etc., where nn is the actual signal number (e.g. NUM37).
 *	The signal number for sig_name[i] is stored in sig_num[i].
 *	The last element is 0 to terminate the list with a NULL.  This
 *	corresponds to the 0 at the end of the sig_num list.
 */
/* SIG_NUM:
 *	This symbol contains a list of signal numbers, in the same order as the
 *	SIG_NAME list. It is suitable for static array initialization, as in:
 *		int sig_num[] = { SIG_NUM };
 *	The signals in the list are separated with commas, and the indices
 *	within that list and the SIG_NAME list match, so it's easy to compute
 *	the signal name from a number or vice versa at the price of a small
 *	dynamic linear lookup. 
 *	Duplicates are allowed, but are moved to the end of the list.
 *	The signal number corresponding to sig_name[i] is sig_number[i].
 *	if (i < NSIG) then sig_number[i] == i.  
 *	The last element is 0, corresponding to the 0 at the end of
 *	the sig_name list.
 */
#define SIG_NAME "NUM0", "NUM1", "INT", "NUM3", "ILL", "NUM5", "NUM6", "NUM7", "FPE", "NUM9", "NUM10", "SEGV", "NUM12", "NUM13", "ALRM", "TERM", 0
#define SIG_NUM 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0

/* VOIDFLAGS:
 *	This symbol indicates how much support of the void type is given by this
 *	compiler.  What various bits mean:
 *
 *	    1 = supports declaration of void
 *	    2 = supports arrays of pointers to functions returning void
 *	    4 = supports comparisons between pointers to void functions and
 *		    addresses of void functions
 *	    8 = suports declaration of generic void pointers
 *
 *	The package designer should define VOIDUSED to indicate the requirements
 *	of the package.  This can be done either by #defining VOIDUSED before
 *	including config.h, or by defining defvoidused in Myinit.U.  If the
 *	latter approach is taken, only those flags will be tested.  If the
 *	level of void support necessary is not present, defines void to int.
 */
#ifndef VOIDUSED
#define VOIDUSED 15
#endif
#define VOIDFLAGS 15
#if (VOIDFLAGS & VOIDUSED) != VOIDUSED
#define void int		/* is void to be avoided? */
#define M_VOID			/* Xenix strikes again */
#endif

/* HAS_ATOLF:
 *	This symbol, if defined, indicates that the atolf routine is
 *	available to convert strings into long doubles.
 */
#undef HAS_ATOLF /**/

/* HAS_ATOLL:
 *	This symbol, if defined, indicates that the atoll routine is
 *	available to convert strings into long longs.
 */
#undef HAS_ATOLL /**/

/* PERL_BINCOMPAT_5005:
 *	This symbol, if defined, indicates that Perl 5.006 should be
 *	binary-compatible with Perl 5.005.  This is impossible for builds
 *	that use features like threads and multiplicity it is always $undef
 *	for those versions.
 */
#undef PERL_BINCOMPAT_5005 /**/

/* DLSYM_NEEDS_UNDERSCORE:
 *	This symbol, if defined, indicates that we need to prepend an
 *	underscore to the symbol name before calling dlsym().  This only
 *	makes sense if you *have* dlsym, which we will presume is the
 *	case if you're using dl_dlopen.xs.
 */
#undef DLSYM_NEEDS_UNDERSCORE /* */

/* HAS_ENDSPENT:
 *	This symbol, if defined, indicates that the endspent system call is
 *	available to finalize the scan of SysV shadow password entries.
 */
#undef HAS_ENDSPENT /**/

/* HAS_FSEEKO:
 *	This symbol, if defined, indicates that the fseeko routine is
 *	available to fseek beyond 32 bits (useful for ILP32 hosts).
 */
#undef HAS_FSEEKO /**/

/* HAS_FTELLO:
 *	This symbol, if defined, indicates that the ftello routine is
 *	available to ftell beyond 32 bits (useful for ILP32 hosts).
 */
#undef HAS_FTELLO /**/

/* HAS_GETMNTENT:
 *	This symbol, if defined, indicates that the getmntent routine is
 *	available to iterate through mounted file systems.
 */
#undef HAS_GETMNTENT /**/

/* HAS_GETSPENT:
 *	This symbol, if defined, indicates that the getspent system call is
 *	available to retrieve SysV shadow password entries sequentially.
 */
#undef HAS_GETSPENT /**/

/* HAS_GETSPNAM:
 *	This symbol, if defined, indicates that the getspnam system call is
 *	available to retrieve SysV shadow password entries by name.
 */
#undef HAS_GETSPNAM /**/

/* HAS_HASMNTOPT:
 *	This symbol, if defined, indicates that the hasmntopt routine is
 *	available to query the mount options of file systems.
 */
#undef HAS_HASMNTOPT /**/

/* HAS_LDBL_DIG:
 *	This symbol, if defined, indicates that this system's <float.h>
 *	or <limits.h> defines the symbol LDBL_DIG, which is the number
 *	of significant digits in a long double precision number. Unlike
 *	for DBL_DIG, there's no good guess for LDBL_DIG if it is undefined.
 */
#undef HAS_LDBL_DIG /**/

/* HAS_MADVISE:
 *	This symbol, if defined, indicates that the madvise system call is
 *	available to map a file into memory.
 */
#undef HAS_MADVISE /**/

/* HAS_MPROTECT:
 *	This symbol, if defined, indicates that the mprotect system call is
 *	available to modify the access protection of a memory mapped file.
 */
#undef HAS_MPROTECT /**/

/* HAS_READV:
 *	This symbol, if defined, indicates that the readv routine is
 *	available to do gather reads.  You will also need <sys/uio.h>
 *	and there I_SYSUIO.
 */
#define HAS_READV /**/

/* HAS_SETSPENT:
 *	This symbol, if defined, indicates that the setspent system call is
 *	available to initialize the scan of SysV shadow password entries.
 */
#undef HAS_SETSPENT /**/

/* USE_SFIO:
 *	This symbol, if defined, indicates that sfio should
 *	be used.
 */
#define USE_SFIO / **/

/* HAS_FSTATFS:
 *	This symbol, if defined, indicates that the fstatfs routine is
 *	available to stat filesystems of file descriptors.
 */
/* HAS_STRUCT_STATFS_FLAGS:
 *	This symbol, if defined, indicates that the struct statfs
 *	does have the f_flags member containing the mount flags of
 *	the filesystem holding the file.
 *	This kind of struct statfs is coming from sys/mount.h (BSD),
 *	not from sys/statfs.h (SYSV).
 */
#undef HAS_FSTATFS /**/
#undef HAS_STRUCT_STATFS_FLAGS /**/

/* HAS_FSTATVFS:
 *	This symbol, if defined, indicates that the fstatvfs routine is
 *	available to stat filesystems of file descriptors.
 */
#undef HAS_FSTATVFS /**/

/* HAS_TELLDIR_PROTO:
 *	This symbol, if defined, indicates that the system provides
 *	a prototype for the telldir() function.  Otherwise, it is up
 *	to the program to supply one.  A good guess is
 *		extern long telldir _((DIR*));
 */
#define HAS_TELLDIR_PROTO /**/

/* HAS_WRITEV:
 *	This symbol, if defined, indicates that the writev routine is
 *	available to do scatter writes.
 */
#define HAS_WRITEV /**/

/* USE_DYNAMIC_LOADING:
 *	This symbol, if defined, indicates that dynamic loading of
 *	some sort is available.
 */
#define USE_DYNAMIC_LOADING /**/

/* FFLUSH_NULL:
 *	This symbol, if defined, tells that fflush(NULL) does flush
 *	all pending stdio output.
 */
/* FFLUSH_ALL:
 *	This symbol, if defined, tells that to flush
 *	all pending stdio output one must loop through all
 *	the stdio file handles stored in an array and fflush them.
 *	Note that if fflushNULL is defined, fflushall will not
 *	even be probed for and will be left undefined.
 */
#define FFLUSH_NULL /**/
#undef FFLUSH_ALL /**/

/* DB_Prefix_t:
 *	This symbol contains the type of the prefix structure element
 *	in the <db.h> header file.  In older versions of DB, it was
 *	int, while in newer ones it is u_int32_t.
 */
/* DB_Hash_t:
 *	This symbol contains the type of the prefix structure element
 *	in the <db.h> header file.  In older versions of DB, it was
 *	int, while in newer ones it is size_t.
 */
#define DB_Hash_t u_int32_t		/**/
#define DB_Prefix_t size_t  	/**/

/* I_INTTYPES:
 *     This symbol, if defined, indicates to the C program that it should
 *     include <inttypes.h>.
 */
/* HAS_INT64_T:
 *     This symbol will defined if the C compiler supports int64_t.
 *     Usually the <inttypes.h> needs to be included, but sometimes
 *	<sys/types.h> is enough.
 */
#define I_INTTYPES /**/
#define HAS_INT64_T /**/

/* I_MNTENT:
 *	This symbol, if defined, indicates that <mntent.h> exists and
 *	should be included.
 */
#undef I_MNTENT /**/

/* I_NETINET_TCP:
 *     This symbol, if defined, indicates to the C program that it should
 *     include <netinet/tcp.h>.
 */
#undef I_NETINET_TCP /**/

/* I_POLL:
 *	This symbol, if defined, indicates that <poll.h> exists and
 *	should be included.
 */
#undef I_POLL /**/

/* I_SHADOW:
 *	This symbol, if defined, indicates that <shadow.h> exists and
 *	should be included.
 */
#undef I_SHADOW /**/

/* I_SOCKS:
 *	This symbol, if defined, indicates that <socks.h> exists and
 *	should be included.
 */
#undef I_SOCKS /**/

/* I_SYS_MMAN:
 *	This symbol, if defined, indicates that <sys/mman.h> exists and
 *	should be included.
 */
#undef I_SYS_MMAN /**/

/* I_SYS_MOUNT:
 *	This symbol, if defined, indicates that <sys/mount.h> exists and
 *	should be included.
 */
#undef I_SYS_MOUNT /**/

/* I_SYS_STATVFS:
 *	This symbol, if defined, indicates that <sys/statvfs.h> exists and
 *	should be included.
 */
#undef I_SYS_STATVFS /**/

/* HAS_OFF64_T:
 *	This symbol will be defined if the C compiler supports off64_t.
 */
/* HAS_FPOS64_T:
 *	This symbol will be defined if the C compiler supports fpos64_t.
 */
#undef HAS_OFF64_T /**/
#undef HAS_FPOS64_T /**/

/* PERL_PRIfldbl:
 *	This symbol, if defined, contains the string used by stdio to
 *	format long doubles (format 'f') for output.
 */
/* PERL_PRIgldbl:
 *	This symbol, if defined, contains the string used by stdio to
 *	format long doubles (format 'g') for output.
 */
#undef PERL_PRIfldbl /**/
#undef PERL_PRIgldbl /**/

/* IVTYPE:
 *	This symbol defines the C type used for Perl's IV.
 */
/* UVTYPE:
 *	This symbol defines the C type used for Perl's UV.
 */
/* I8TYPE:
 *	This symbol defines the C type used for Perl's I8.
 */
/* U8TYPE:
 *	This symbol defines the C type used for Perl's U8.
 */
/* I16TYPE:
 *	This symbol defines the C type used for Perl's I16.
 */
/* U16TYPE:
 *	This symbol defines the C type used for Perl's U16.
 */
/* I32TYPE:
 *	This symbol defines the C type used for Perl's I32.
 */
/* U32TYPE:
 *	This symbol defines the C type used for Perl's U32.
 */
/* I64TYPE:
 *	This symbol defines the C type used for Perl's I64.
 */
/* U64TYPE:
 *	This symbol defines the C type used for Perl's U64.
 */
/* NVTYPE:
 *	This symbol defines the C type used for Perl's NV.
 */
/* IVSIZE:
 *	This symbol contains the sizeof(IV).
 */
/* UVSIZE:
 *	This symbol contains the sizeof(UV).
 */
/* I8SIZE:
 *	This symbol contains the sizeof(I8).
 */
/* U8SIZE:
 *	This symbol contains the sizeof(U8).
 */
/* I16SIZE:
 *	This symbol contains the sizeof(I16).
 */
/* U16SIZE:
 *	This symbol contains the sizeof(U16).
 */
/* I32SIZE:
 *	This symbol contains the sizeof(I32).
 */
/* U32SIZE:
 *	This symbol contains the sizeof(U32).
 */
/* I64SIZE:
 *	This symbol contains the sizeof(I64).
 */
/* U64SIZE:
 *	This symbol contains the sizeof(U64).
 */
#define	IVTYPE		int				/**/
#define	UVTYPE		unsigned int	/**/
#define	I8TYPE		int8_t			/**/
#define	U8TYPE		uint8_t			/**/
#define	I16TYPE		int16_t			/**/
#define	U16TYPE		uint16_t		/**/
#define	I32TYPE		int32_t			/**/
#define	U32TYPE		uint32_t		/**/
#ifdef HAS_QUAD
#define	I64TYPE		int64_t			/**/
#define	U64TYPE		uint64_t		/**/
#endif
#define	NVTYPE		double		/**/
#define	IVSIZE		4			/**/
#define	UVSIZE		4			/**/
#define	I8SIZE		1			/**/
#define	U8SIZE		1			/**/
#define	I16SIZE		2			/**/
#define	U16SIZE		2			/**/
#define	I32SIZE		4			/**/
#define	U32SIZE		4			/**/
#ifdef HAS_QUAD
#define	I64SIZE		8			/**/
#define	U64SIZE		8			/**/
#endif


/* IVdf:
 *	This symbol defines the format string used for printing a Perl IV
 *	as a signed decimal integer.
 */
/* UVuf:
 *	This symbol defines the format string used for printing a Perl UV
 *	as an unsigned decimal integer.
 */
/* UVof:
 *	This symbol defines the format string used for printing a Perl UV
 *	as an unsigned octal integer.
 */
/* UVxf:
 *	This symbol defines the format string used for printing a Perl UV
 *	as an unsigned hexadecimal integer.
 */
#define	IVdf		"d"		/**/
#define	UVuf		"u"		/**/
#define	UVof		"o"		/**/
#define	UVxf		"x"		/**/

/* SELECT_MIN_BITS:
 *	This symbol holds the minimum number of bits operated by select.
 *	That is, if you do select(n, ...), how many bits at least will be
 *	cleared in the masks if some activity is detected.  Usually this
 *	is either n or 32*ceil(n/32), especially many little-endians do
 *	the latter.  This is only useful if you have select(), naturally.
 */
#define SELECT_MIN_BITS 32

/* STARTPERL:
 *	This variable contains the string to put in front of a perl
 *	script to make sure (one hopes) that it runs with perl and not
 *	some shell.
 */
#define STARTPERL "Perl -Sx \"{0}\" {\"Parameters\"}; Exit {Status}\n#!perl"		/**/

/* HAS_STDIO_STREAM_ARRAY:
 *	This symbol, if defined, tells that there is an array
 *	holding the stdio streams.
 */
/* STDIO_STREAM_ARRAY:
 *	This symbol tells the name of the array holding the stdio streams.
 *	Usual values include _iob, __iob, and __sF.
 */
#undef HAS_STDIO_STREAM_ARRAY /**/
#define STDIO_STREAM_ARRAY /**/

/* HAS_STRTOULL:
 *	This symbol, if defined, indicates that the strtoull routine is
 *	available to convert strings into unsigned long longs.
 */
#undef HAS_STRTOULL /**/

/* USE_64_BITS:
 *	This symbol, if defined, indicates that 64-bit interfaces should
 *	be used when available.  If not defined, the native default interfaces
 *	will be used (be they 32 or 64 bits).
 */
#undef USE_64_BITS /**/

/* USE_LONG_DOUBLE:
 *	This symbol, if defined, indicates that long doubles should
 *	be used when available.
 */
#undef USE_LONG_DOUBLE /**/

/* MULTIPLICITY:
 *	This symbol, if defined, indicates that Perl should
 *	be built to use multiplicity.
 */
#define MULTIPLICITY /**/

/* USE_PERLIO:
 *	This symbol, if defined, indicates that the PerlIO abstraction should
 *	be used throughout.  If not defined, stdio should be
 *	used in a fully backward compatible manner.
 */
#define USE_PERLIO /**/

/* USE_SOCKS:
 *	This symbol, if defined, indicates that Perl should
 *	be built to use socks.
 */
#undef USE_SOCKS /**/

/* HAS_DRAND48_PROTO:
 *	This symbol, if defined, indicates that the system provides
 *	a prototype for the drand48() function.  Otherwise, it is up
 *	to the program to supply one.  A good guess is
 *		extern double drand48 _((void));
 */
#undef HAS_DRAND48_PROTO /**/

/* HAS_GETHOST_PROTOS:
 *	This symbol, if defined, indicates that <netdb.h> includes
 *	prototypes for gethostent(), gethostbyname(), and
 *	gethostbyaddr().  Otherwise, it is up to the program to guess
 *	them.  See netdbtype.U for probing for various Netdb_xxx_t types.
 */
#define HAS_GETHOST_PROTOS /**/

/* HAS_GETNET_PROTOS:
 *	This symbol, if defined, indicates that <netdb.h> includes
 *	prototypes for getnetent(), getnetbyname(), and
 *	getnetbyaddr().  Otherwise, it is up to the program to guess
 *	them.  See netdbtype.U for probing for various Netdb_xxx_t types.
 */
#undef HAS_GETNET_PROTOS /**/

/* HAS_GETPROTO_PROTOS:
 *	This symbol, if defined, indicates that <netdb.h> includes
 *	prototypes for getprotoent(), getprotobyname(), and
 *	getprotobyaddr().  Otherwise, it is up to the program to guess
 *	them.  See netdbtype.U for probing for various Netdb_xxx_t types.
 */
#define HAS_GETPROTO_PROTOS /**/

/* HAS_GETSERV_PROTOS:
 *	This symbol, if defined, indicates that <netdb.h> includes
 *	prototypes for getservent(), getservbyname(), and
 *	getservbyaddr().  Otherwise, it is up to the program to guess
 *	them.  See netdbtype.U for probing for various Netdb_xxx_t types.
 */
#define HAS_GETSERV_PROTOS /**/

/* Netdb_host_t:
 *	This symbol holds the type used for the 1st argument
 *	to gethostbyaddr().
 */
/* Netdb_hlen_t:
 *	This symbol holds the type used for the 2nd argument
 *	to gethostbyaddr().
 */
/* Netdb_name_t:
 *	This symbol holds the type used for the argument to
 *	gethostbyname().
 */
/* Netdb_net_t:
 *	This symbol holds the type used for the 1st argument to
 *	getnetbyaddr().
 */
#define Netdb_host_t void *
#define Netdb_hlen_t size_t
#define Netdb_name_t char *
#define Netdb_net_t void *

/* Select_fd_set_t:
 *	This symbol holds the type used for the 2nd, 3rd, and 4th
 *	arguments to select.  Usually, this is 'fd_set *', if HAS_FD_SET
 *	is defined, and 'int *' otherwise.  This is only useful if you 
 *	have select(), of course.
 */
#define Select_fd_set_t fd_set *	/**/

/* ARCHNAME:
 *	This symbol holds a string representing the architecture name.
 *	It may be used to construct an architecture-dependant pathname
 *	where library files may be held under a private library, for
 *	instance.
 */
#undef ARCHNAME /**/

/* OLD_PTHREAD_CREATE_JOINABLE:
 *	This symbol, if defined, indicates how to create pthread
 *	in joinable (aka undetached) state.  NOTE: not defined
 *	if pthread.h already has defined PTHREAD_CREATE_JOINABLE
 *	(the new version of the constant).
 *	If defined, known values are PTHREAD_CREATE_UNDETACHED
 *	and __UNDETACHED.
 */
#undef OLD_PTHREAD_CREATE_JOINABLE /**/

/* HAS_PTHREAD_YIELD:
 *	This symbol, if defined, indicates that the pthread_yield 
 *	routine is available to yield the execution of the current
 *	thread.	 sched_yield is preferable to pthread_yield.
 */
/* SCHED_YIELD:
 *	This symbol defines the way to yield the execution of
 *	the current thread.  Known ways are sched_yield,
 *	pthread_yield, and pthread_yield with NULL.
 */
/* HAS_SCHED_YIELD:
 *	This symbol, if defined, indicates that the sched_yield
 *	routine is available to yield the execution of the current
 *	thread.	 sched_yield is preferable to pthread_yield.
 */
#undef HAS_PTHREAD_YIELD /**/
#define SCHED_YIELD sched_yield()
#define HAS_SCHED_YIELD /**/

/* I_MACH_CTHREADS:
 *     This symbol, if defined, indicates to the C program that it should
 *     include <mach/cthreads.h>.
 */
#undef I_MACH_CTHREADS /**/

/* USE_THREADS:
 *	This symbol, if defined, indicates that Perl should
 *	be built to use threads.
 */
/* OLD_PTHREADS_API:
 *	This symbol, if defined, indicates that Perl should
 *	be built to use the old draft POSIX threads API.
 */
#undef USE_THREADS /**/
#undef OLD_PTHREADS_API /**/

/* Time_t:
 *	This symbol holds the type returned by time(). It can be long,
 *	or time_t on BSD sites (in which case <sys/types.h> should be
 *	included).
 */
#define Time_t time_t		/* Time type */

/* HAS_TIMES:
 *	This symbol, if defined, indicates that the times() routine exists.
 *	Note that this became obsolete on some systems (SUNOS), which now
 * use getrusage(). It may be necessary to include <sys/times.h>.
 */
#undef HAS_TIMES /**/

/* Fpos_t:
 *	This symbol holds the type used to declare file positions in libc.
 *	It can be fpos_t, long, uint, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Fpos_t long		/* File position type */

/* Gid_t:
 *	This symbol holds the return type of getgid() and the type of
 *	argument to setrgid() and related functions.  Typically,
 *	it is the type of group ids in the kernel. It can be int, ushort,
 *	uid_t, etc... It may be necessary to include <sys/types.h> to get
 *	any typedef'ed information.
 */
#define Gid_t gid_t		/* Type for getgid(), etc... */

/* Off_t:
 *	This symbol holds the type used to declare offsets in the kernel.
 *	It can be int, long, off_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
/* LSEEKSIZE:
 *	This symbol holds the number of bytes used by the Off_t.
 */
#define Off_t off_t		/* <offset> type */
#define LSEEKSIZE 4

/* Mode_t:
 *	This symbol holds the type used to declare file modes 
 *	for systems calls.  It is usually mode_t, but may be
 *	int or unsigned short.  It may be necessary to include <sys/types.h>
 *	to get any typedef'ed information.
 */
#define Mode_t mode_t	 /* file mode parameter for system calls */

/* Pid_t:
 *	This symbol holds the type used to declare process ids in the kernel.
 *	It can be int, uint, pid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Pid_t pid_t

/* Size_t:
 *	This symbol holds the type used to declare length parameters
 *	for string functions.  It is usually size_t, but may be
 *	unsigned long, int, etc.  It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Size_t size_t	 /* length paramater for string functions */

/* Uid_t:
 *	This symbol holds the type used to declare user ids in the kernel.
 *	It can be int, ushort, uid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Uid_t uid_t		/* UID type */

#define STANDARD_C 1

/* MacOS Specials */

#ifdef macintosh
/* Prevent including standard stdio header */
#ifdef __MWERKS__
#define __cstdio__	1
#else
#define __STDIO__	1
#endif
#define BIG_TIME
#endif

#define Sock_size_t socklen_t

#include <compat.h>
#endif
