#!perl -w
use strict;

use File::Basename;
use Mac::Glue;
use Mac::AETE::App;
use Mac::AETE::Dialect;
use Mac::AETE::Format::Glue;

my $delete = MacPerl::Answer('Overwrite existing glues if they exist?',
    qw(OK No Cancel));
exit if $delete == 0;
$delete = 0 if $delete == 2;

foreach my $drop (@ARGV) {
    my($oldfh, $conv, $aeut, $aete, $output, $file, $dir);

    $drop = readlink $drop while -l $drop;

    # initialize
    ($file, $dir) = fileparse($drop, '');
    my $ask = MacPerl::Ask('What is the glue name?',
        Mac::AETE::Format::Glue::fixname($file));
    next if !$ask || $ask eq '';
    $output = $ENV{MACGLUEDIR} . $ask;

    next unless $aete = Mac::AETE::App->new($drop);
    $conv = Mac::AETE::Format::Glue->new($output, !$delete);

    $aete->set_format($conv);
    $aete->read();
    $aete->write();
    $conv->finish();
}
