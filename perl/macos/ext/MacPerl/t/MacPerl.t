#!/usr/bin/perl -w
use File::Spec::Functions;
use Test::More;
use strict;

BEGIN { plan tests => 10 }

use MacPerl ':all';

SKIP: {
#	skip "MacPerl", 10;

	my @volumes = Volumes();
	ok(@volumes, 'Volumes: ' . join(', ', @volumes));	

	# convert FSSpecs to paths
	my $exists = 1;
	my @paths;
	for (@volumes) {
		push @paths, my $path = MakePath($_);
		$exists = 0 unless -d $path;
	}
	ok($exists, 'MakePath: ' . join(', ', map { MakePath($_) } @paths));

	# go back!
	$_ = MakeFSSpec($_) for @paths;
	ok(eq_array(\@volumes, \@paths), 'MakeFSSpec');

	# AppleScript / Finder version; will fail if Finder is not
	# running or is unavailable
	(my $version = DoAppleScript(<<'EOS')) =~ s/^"(.+)"$/$1/;
tell application "Finder"
	get version
end tell
EOS

	my($finder, $mtype, $mcrea);
	# Mac OS X
	if ($^O eq 'darwin') {
		ok($version >= 10, "Finder v$version");
		$finder = '/System/Library/CoreServices/Finder';
		$mcrea = $mtype = "\0\0\0\0";
	}

	# Mac OS / Classic
	elsif ($^O eq 'MacOS') {
		if ($version >= 10) {
			ok(1, "Finder v$version (Classic)");
		} else {
			ok($version >=7, "Finder v$version");
		}
		$finder = MakePath($volumes[0]) . "System Folder:Finder";
		$mcrea = 'R*ch';
		$mtype = 'TEXT';
	}
	
	else {
		ok(0, "huh?");
	}

	# file info get/set
	my($crea, $type) = GetFileInfo($finder);
	is($crea, 'MACS', "creator of '$finder'");
	is($type, 'FNDR', "type of '$finder'");

	my $testfile = catfile(curdir(), "foo");
	unlink $testfile;
	if (open(my $fh, ">", $testfile)) {
		close $fh;
		($crea, $type) = GetFileInfo($testfile);
		# could fail under Mac OS if local GUSI resource changed
		# so new files are not R*ch/TEXT; we could read
		# the resource instead ... (and old versions of MacPerl
		# used MPS /TEXT)
		is($crea, $mcrea, "creator of '$testfile'");
		is($type, $mtype, "type of '$testfile'");

		SetFileInfo('McPL', 'TEXT', $testfile);
		($crea, $type) = GetFileInfo($testfile);
		is($crea, 'McPL', "creator of '$testfile'");
		is($type, 'TEXT', "type of '$testfile'");
	} else {
		ok(0, "No file '$testfile'") for 1..4;
	}
	unlink $testfile;
}

__END__