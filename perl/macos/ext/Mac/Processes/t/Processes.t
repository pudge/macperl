#!/usr/bin/perl -w
use Test::More;
use strict;

BEGIN { plan tests => 1 }

use Mac::Processes;

SKIP: {
#	skip "Mac::Processes", 1;

# other process tests are in Notification.t
# we should check struct fields, too

	my $exists = 1;
	while (my($psn, $pi) = each %Mac::Processes::Process) {
		$exists = 0, last unless -e $pi->processAppSpec;
	}
	ok($exists, 'check process paths');

}

__END__
