package Fcntl;

=head1 NAME

Fcntl - load the C Fcntl.h defines

=head1 SYNOPSIS

    use Fcntl;
    use Fcntl qw(:DEFAULT :flock);

=head1 DESCRIPTION

This module is just a translation of the C F<fnctl.h> file.
Unlike the old mechanism of requiring a translated F<fnctl.ph>
file, this uses the B<h2xs> program (see the Perl source distribution)
and your native C compiler.  This means that it has a 
far more likely chance of getting the numbers right.

=head1 NOTE

Only C<#define> symbols get translated; you must still correctly
pack up your own arguments to pass as args for locking functions, etc.

=head1 EXPORTED SYMBOLS

By default your system's F_* and O_* constants (eg, F_DUPFD and
O_CREAT) and the FD_CLOEXEC constant are exported into your namespace.

You can request that the flock() constants (LOCK_SH, LOCK_EX, LOCK_NB
and LOCK_UN) be provided by using the tag C<:flock>.  See L<Exporter>.

You can request that the old constants (FAPPEND, FASYNC, FCREAT,
FDEFER, FEXCL, FNDELAY, FNONBLOCK, FSYNC, FTRUNC) be provided for
compatibility reasons by using the tag C<:Fcompat>.  For new
applications the newer versions of these constants are suggested
(O_APPEND, O_ASYNC, O_CREAT, O_DEFER, O_EXCL, O_NDELAY, O_NONBLOCK,
O_SYNC, O_TRUNC).

For ease of use also the SEEK_* constants (for seek() and sysseek(),
e.g. SEEK_END) and the S_I* constants (for chmod() and stat()) are
available for import.  They can be imported either separately or using
the tags C<:seek> and C<:mode>.

Please refer to your native fcntl(2), open(2), fseek(3), lseek(2)
(equal to Perl's seek() and sysseek(), respectively), and chmod(2)
documentation to see what constants are implemented in your system.

See L<perlopentut> to learn about the uses of the O_* constants
with sysopen().

See L<perlfunc/seek> and L<perlfunc/sysseek> about the SEEK_* constants.

See L<perlfunc/stat> about the S_I* constants.

=cut

our($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS, $AUTOLOAD);

require Exporter;
use XSLoader ();
@ISA = qw(Exporter);
$VERSION = "1.03";
# Items to export into callers namespace by default
# (move infrequently used names to @EXPORT_OK below)
@EXPORT =
  qw(
	FD_CLOEXEC
	F_ALLOCSP
	F_ALLOCSP64
	F_COMPAT
	F_DUP2FD
	F_DUPFD
	F_EXLCK
	F_FREESP
	F_FREESP64
	F_FSYNC
	F_FSYNC64
	F_GETFD
	F_GETFL
	F_GETLK
	F_GETLK64
	F_GETOWN
	F_NODNY
	F_POSIX
	F_RDACC
	F_RDDNY
	F_RDLCK
	F_RWACC
	F_RWDNY
	F_SETFD
	F_SETFL
	F_SETLK
	F_SETLK64
	F_SETLKW
	F_SETLKW64
	F_SETOWN
	F_SHARE
	F_SHLCK
	F_UNLCK
	F_UNSHARE
	F_WRACC
	F_WRDNY
	F_WRLCK
	O_ACCMODE
	O_ALIAS
	O_APPEND
	O_ASYNC
	O_BINARY
	O_CREAT
	O_DEFER
	O_DIRECT
	O_DIRECTORY
	O_DSYNC
	O_EXCL
	O_EXLOCK
	O_LARGEFILE
	O_NDELAY
	O_NOCTTY
	O_NOFOLLOW
	O_NOINHERIT
	O_NONBLOCK
	O_RANDOM
	O_RAW
	O_RDONLY
	O_RDWR
	O_RSRC
	O_RSYNC
	O_SEQUENTIAL
	O_SHLOCK
	O_SYNC
	O_TEMPORARY
	O_TEXT
	O_TRUNC
	O_WRONLY
     );

# Other items we are prepared to export if requested
@EXPORT_OK = qw(
	FAPPEND
	FASYNC
	FCREAT
	FDEFER
	FDSYNC
	FEXCL
	FLARGEFILE
	FNDELAY
	FNONBLOCK
	FRSYNC
	FSYNC
	FTRUNC
	LOCK_EX
	LOCK_NB
	LOCK_SH
	LOCK_UN
	S_ISUID S_ISGID S_ISVTX S_ISTXT
	_S_IFMT S_IFREG S_IFDIR S_IFLNK
	S_IFSOCK S_IFBLK S_IFCHR S_IFIFO S_IFWHT S_ENFMT
	S_IRUSR S_IWUSR S_IXUSR S_IRWXU
	S_IRGRP S_IWGRP S_IXGRP S_IRWXG
	S_IROTH S_IWOTH S_IXOTH S_IRWXO
	S_IREAD S_IWRITE S_IEXEC
	&S_ISREG &S_ISDIR &S_ISLNK &S_ISSOCK &S_ISBLK &S_ISCHR &S_ISFIFO
	&S_ISWHT &S_ISENFMT &S_IFMT &S_IMODE
	SEEK_SET
	SEEK_CUR
	SEEK_END
);
# Named groups of exports
%EXPORT_TAGS = (
    'flock'   => [qw(LOCK_SH LOCK_EX LOCK_NB LOCK_UN)],
    'Fcompat' => [qw(FAPPEND FASYNC FCREAT FDEFER FDSYNC FEXCL FLARGEFILE
		     FNDELAY FNONBLOCK FRSYNC FSYNC FTRUNC)],
    'seek'    => [qw(SEEK_SET SEEK_CUR SEEK_END)],
    'mode'    => [qw(S_ISUID S_ISGID S_ISVTX S_ISTXT
		     _S_IFMT S_IFREG S_IFDIR S_IFLNK
		     S_IFSOCK S_IFBLK S_IFCHR S_IFIFO S_IFWHT S_ENFMT
		     S_IRUSR S_IWUSR S_IXUSR S_IRWXU
		     S_IRGRP S_IWGRP S_IXGRP S_IRWXG
		     S_IROTH S_IWOTH S_IXOTH S_IRWXO
		     S_IREAD S_IWRITE S_IEXEC
		     S_ISREG S_ISDIR S_ISLNK S_ISSOCK
		     S_ISBLK S_ISCHR S_ISFIFO
		     S_ISWHT S_ISENFMT		
		     S_IFMT S_IMODE
                  )],
);

sub S_IFMT  { @_ ? ( $_[0] & _S_IFMT() ) : _S_IFMT()  }
sub S_IMODE { $_[0] & 07777 }

sub S_ISREG    { ( $_[0] & _S_IFMT() ) == S_IFREG()   }
sub S_ISDIR    { ( $_[0] & _S_IFMT() ) == S_IFDIR()   }
sub S_ISLNK    { ( $_[0] & _S_IFMT() ) == S_IFLNK()   }
sub S_ISSOCK   { ( $_[0] & _S_IFMT() ) == S_IFSOCK()  }
sub S_ISBLK    { ( $_[0] & _S_IFMT() ) == S_IFBLK()   }
sub S_ISCHR    { ( $_[0] & _S_IFMT() ) == S_IFCHR()   }
sub S_ISFIFO   { ( $_[0] & _S_IFMT() ) == S_IFIFO()   }
sub S_ISWHT    { ( $_[0] & _S_IFMT() ) == S_IFWHT()   }
sub S_ISENFMT  { ( $_[0] & _S_IFMT() ) == S_IFENFMT() }

sub AUTOLOAD {
    (my $constname = $AUTOLOAD) =~ s/.*:://;
    local $! = 0;
    my $val = constant($constname, 0);
    if ($! != 0) {
	if ($! =~ /Invalid/ || $!{EINVAL}) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    my ($pack,$file,$line) = caller;
	    die "Your vendor has not defined Fcntl macro $constname, used at $file line $line.
";
	}
    }
    *$AUTOLOAD = sub { $val };
    goto &$AUTOLOAD;
}

XSLoader::load 'Fcntl', $VERSION;

1;
