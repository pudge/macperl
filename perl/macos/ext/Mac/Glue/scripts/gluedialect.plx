#!perl -w
use strict;

BEGIN { $Mac::Glue::CREATINGGLUES = 1 }

use Cwd;
use File::Basename;
use File::Spec::Functions;
use Mac::Files;
use Mac::Gestalt;
use Mac::Glue;
use Mac::AETE::App;
use Mac::AETE::Dialect;
use Mac::AETE::Format::Glue;

if (!@ARGV) {
    $ARGV[0] = catdir((Gestalt(gestaltSystemVersion) >= hex(800)
        ? FindFolder(kOnSystemDisk, 'Äscr')
        : catdir(FindFolder(kOnSystemDisk, kExtensionFolderType),
            'Scripting Additions')), 'Dialects');
}
die "Can't find Dialects folder\n" if !@ARGV;

if (@ARGV == 1) {
    die "Can't find Dialects folder: $ARGV[0] " .
        "(feel free to drag-and-drop the folder on this droplet)\n" if ! -e $ARGV[0];
    if (-d _) {
        chdir $ARGV[0] or die $!;
        opendir DIR, $ARGV[0] or die $!;
        @ARGV = readdir DIR;
    }
}

my $delete = MacPerl::Answer('Overwrite existing glues if they exist?',
    qw(OK No Cancel));
exit if $delete == 0;
$delete = 0 if $delete == 2;

foreach my $dlct (@ARGV) {
    next unless is_dialect($dlct);
    my $cwd = cwd();

    my($conv, $aeut, $output, $file, $dir);

    # initialize
    ($file, $dir) = fileparse($dlct, '');
    $file =~ s/\s+Dialect$//;
    $output = "$ENV{MACGLUEDIR}dialects:" .
        Mac::AETE::Format::Glue::fixname($file);

    $aeut = Mac::AETE::Dialect->new( catfile($cwd, $dlct) );
    $conv = Mac::AETE::Format::Glue->new($output, !$delete);

    $aeut->set_format($conv);
    $aeut->read();
    $aeut->write();
    $conv->finish();
}

sub is_dialect {
    my $dlct = shift;

    return unless -f $dlct;

    my($creator, $type) = MacPerl::GetFileInfo($dlct);
    return if !$type || !$creator || $creator ne 'ascr' ||
        ($type ne 'shlb' && $type ne 'dlct');

    return 1;
}
