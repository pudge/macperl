package File::Spec;

use strict;
our(@ISA, $VERSION);

$VERSION = 0.83 ;

my %module = (MacOS   => 'Mac',
	      MSWin32 => 'Win32',
	      os2     => 'OS2',
	      VMS     => 'VMS',
	      epoc    => 'Epoc');

my $module = $module{$^O} || 'Unix';
require "File/Spec/$module.pm";
@ISA = ("File::Spec::$module");

1;

__END__

=head1 NAME

File::Spec - portably perform operations on file names

=head1 SYNOPSIS

	use File::Spec;

	$x=File::Spec->catfile('a', 'b', 'c');

which returns 'a/b/c' under Unix. Or:

	use File::Spec::Functions;

	$x = catfile('a', 'b', 'c');

=head1 DESCRIPTION

This module is designed to support operations commonly performed on file
specifications (usually called "file names", but not to be confused with the
contents of a file, or Perl's file handles), such as concatenating several
directory and file names into a single path, or determining whether a path
is rooted. It is based on code directly taken from MakeMaker 5.17, code
written by Andreas KE<ouml>nig, Andy Dougherty, Charles Bailey, Ilya
Zakharevich, Paul Schinder, and others.

Since these functions are different for most operating systems, each set of
OS specific routines is available in a separate module, including:

	File::Spec::Unix
	File::Spec::Mac
	File::Spec::OS2
	File::Spec::Win32
	File::Spec::VMS

The module appropriate for the current OS is automatically loaded by
File::Spec. Since some modules (like VMS) make use of facilities available
only under that OS, it may not be possible to load all modules under all
operating systems.

Since File::Spec is object oriented, subroutines should not be called directly,
as in:

	File::Spec::catfile('a','b');

but rather as class methods:

	File::Spec->catfile('a','b');

For simple uses, L<File::Spec::Functions> provides convenient functional
forms of these methods.

=head1 METHODS

=over 2

=item canonpath

No physical check on the filesystem, but a logical cleanup of a
path.

    $cpath = File::Spec->canonpath( $path ) ;

=item catdir

Concatenate two or more directory names to form a complete path ending
with a directory. But remove the trailing slash from the resulting
string, because it doesn't look good, isn't necessary and confuses
OS2. Of course, if this is the root directory, don't cut off the
trailing slash :-)

    $path = File::Spec->catdir( @directories );

=item catfile

Concatenate one or more directory names and a filename to form a
complete path ending with a filename

    $path = File::Spec->catfile( @directories, $filename );

=item curdir

Returns a string representation of the current directory.

    $curdir = File::Spec->curdir();

=item devnull

Returns a string representation of the null device.

    $devnull = File::Spec->devnull();

=item rootdir

Returns a string representation of the root directory.

    $rootdir = File::Spec->rootdir();

=item tmpdir

Returns a string representation of the first writable directory from a
list of possible temporary directories.  Returns "" if no writable
temporary directories are found.  The list of directories checked
depends on the platform; e.g. File::Spec::Unix checks $ENV{TMPDIR} and
/tmp.

    $tmpdir = File::Spec->tmpdir();

=item updir

Returns a string representation of the parent directory.

    $updir = File::Spec->updir();

=item no_upwards

Given a list of file names, strip out those that refer to a parent
directory. (Does not strip symlinks, only '.', '..', and equivalents.)

    @paths = File::Spec->no_upwards( @paths );

=item case_tolerant

Returns a true or false value indicating, respectively, that alphabetic
is not or is significant when comparing file specifications.

    $is_case_tolerant = File::Spec->case_tolerant();

=item file_name_is_absolute

Takes as argument a path and returns true if it is an absolute path.

    $is_absolute = File::Spec->file_name_is_absolute( $path );

This does not consult the local filesystem on Unix, Win32, OS/2, or
Mac OS (Classic).  It does consult the working environment for VMS
(see L<File::Spec::VMS/file_name_is_absolute>).

=item path

Takes no argument, returns the environment variable PATH as an array.

    @PATH = File::Spec->path();

=item join

join is the same as catfile.

=item splitpath

Splits a path in to volume, directory, and filename portions. On systems
with no concept of volume, returns undef for volume. 

    ($volume,$directories,$file) = File::Spec->splitpath( $path );
    ($volume,$directories,$file) = File::Spec->splitpath( $path, $no_file );

For systems with no syntax differentiating filenames from directories, 
assumes that the last file is a path unless $no_file is true or a 
trailing separator or /. or /.. is present. On Unix this means that $no_file
true makes this return ( '', $path, '' ).

The directory portion may or may not be returned with a trailing '/'.

The results can be passed to L</catpath()> to get back a path equivalent to
(usually identical to) the original path.

=item splitdir

The opposite of L</catdir()>.

    @dirs = File::Spec->splitdir( $directories );

$directories must be only the directory portion of the path on systems 
that have the concept of a volume or that have path syntax that differentiates
files from directories.

Unlike just splitting the directories on the separator, empty
directory names (C<''>) can be returned, because these are significant
on some OSs.

=item catpath()

Takes volume, directory and file portions and returns an entire path. Under
Unix, $volume is ignored, and directory and file are catenated.  A '/' is
inserted if need be.  On other OSs, $volume is significant.

    $full_path = File::Spec->catpath( $volume, $directory, $file );

=item abs2rel

Takes a destination path and an optional base path returns a relative path
from the base path to the destination path:

    $rel_path = File::Spec->abs2rel( $path ) ;
    $rel_path = File::Spec->abs2rel( $path, $base ) ;

If $base is not present or '', then L<cwd()|Cwd> is used. If $base is relative, 
then it is converted to absolute form using L</rel2abs()>. This means that it
is taken to be relative to L<cwd()|Cwd>.

On systems with the concept of a volume, this assumes that both paths 
are on the $destination volume, and ignores the $base volume. 

On systems that have a grammar that indicates filenames, this ignores the 
$base filename as well. Otherwise all path components are assumed to be
directories.

If $path is relative, it is converted to absolute form using L</rel2abs()>.
This means that it is taken to be relative to L<cwd()|Cwd>.

No checks against the filesystem are made.  On VMS, there is
interaction with the working environment, as logicals and
macros are expanded.

Based on code written by Shigio Yamaguchi.

=item rel2abs()

Converts a relative path to an absolute path. 

    $abs_path = File::Spec->rel2abs( $path ) ;
    $abs_path = File::Spec->rel2abs( $path, $base ) ;

If $base is not present or '', then L<cwd()|Cwd> is used. If $base is relative, 
then it is converted to absolute form using L</rel2abs()>. This means that it
is taken to be relative to L<cwd()|Cwd>.

On systems with the concept of a volume, this assumes that both paths 
are on the $base volume, and ignores the $path volume. 

On systems that have a grammar that indicates filenames, this ignores the 
$base filename as well. Otherwise all path components are assumed to be
directories.

If $path is absolute, it is cleaned up and returned using L</canonpath()>.

No checks against the filesystem are made.  On VMS, there is
interaction with the working environment, as logicals and
macros are expanded.

Based on code written by Shigio Yamaguchi.

=back

For further information, please see L<File::Spec::Unix>,
L<File::Spec::Mac>, L<File::Spec::OS2>, L<File::Spec::Win32>, or
L<File::Spec::VMS>.

=head1 SEE ALSO

L<File::Spec::Unix>, L<File::Spec::Mac>, L<File::Spec::OS2>,
L<File::Spec::Win32>, L<File::Spec::VMS>, L<File::Spec::Functions>,
L<ExtUtils::MakeMaker>

=head1 AUTHORS

Kenneth Albanowski <kjahds@kjahds.com>, Andy Dougherty
<doughera@lafcol.lafayette.edu>, Andreas KE<ouml>nig
<A.Koenig@franz.ww.TU-Berlin.DE>, Tim Bunce <Tim.Bunce@ig.co.uk.
VMS support by Charles Bailey <bailey@newman.upenn.edu>.
OS/2 support by Ilya Zakharevich <ilya@math.ohio-state.edu>.
Mac support by Paul Schinder <schinder@pobox.com>, and Thomas Wegner
<wegner_thomas@yahoo.com>.  abs2rel() and rel2abs() written by Shigio
Yamaguchi <shigio@tamacom.com>, modified by Barrie Slaymaker
<barries@slaysys.com>.  splitpath(), splitdir(), catpath() and
catdir() by Barrie Slaymaker.
