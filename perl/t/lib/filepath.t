#!./perl

BEGIN {
    chdir 't' if -d 't';
    unshift @INC, '../lib';
}

use File::Path;
use strict;

my $count = 0;
use warnings;

my @dirs = ('foo', 'foo/bar');
@dirs = (':foo', ':foo:bar') if $^O eq 'MacOS';

print "1..4\n";

# first check for stupid permissions second for full, so we clean up
# behind ourselves
for my $perm (0111,0777) {
    mkpath($dirs[1]);
#    chmod $perm, $dirs[0], $dirs[1];

    print "not " unless -d $dirs[0] && -d $dirs[1];
    print "ok ", ++$count, "\n";

    rmtree($dirs[0]);
    print "not " if -e $dirs[0];
    print "ok ", ++$count, "\n";
}
