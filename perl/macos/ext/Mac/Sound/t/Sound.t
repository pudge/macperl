#!/usr/bin/perl -w
use File::Spec::Functions;
use Test::More;
use strict;

BEGIN { plan tests => 14 }

use Mac::Resources;
use Mac::Sound;

SKIP: {
#	skip "Mac::Sound Beeps", 4;

	my $vol = GetDefaultOutputVolume();
	ok(defined($vol),			'get current volume');
	SysBeep(30);
	sleep(1); # allow user to hear

	ok(SetDefaultOutputVolume(2**32),	'set high volume');
	SysBeep(30);
	sleep(1);

	ok(SetDefaultOutputVolume(0),		'set low volume');
	SysBeep(30);
	sleep(1);

	ok(SetDefaultOutputVolume($vol),	'set default volume');
	SysBeep(30);
	sleep(1);
}


SKIP: {
#	skip "Mac::Sound Resource", 10;

	my $ofil = 'Scream.rsrc';
	my $otyp = soundListRsrc();
	my $oid  = 129;
	my $onam = 'Original';

	my $dir1 = catfile(curdir(), 't'); #, $ofil);
	my $dir2 = catfile(curdir(), 'Sound', 't'); #, $ofil);
	my $dir  = -e $ofil			? curdir()
		:  -e catfile($dir1, $ofil)	? $dir1
		:  -e catfile($dir2, $ofil)	? $dir2
		: '';

	# try to fix forks ... it's ok if we can't, we'll live
	if ($^O eq 'darwin') {
		my $ifil = $ofil;
		$ofil = 'Sound.rsrc';

		# already been here?
		unless (-e catfile($dir, $ofil)) {
			my $no = 0;
			if (open(my $df, '>', catfile($dir, $ofil))) {
			if (open(my $rf, '>', catfile($dir, $ofil, '..namedfork', 'rsrc'))) {
			if (open($df, '<', catfile($dir, $ifil))) {
				print $rf $_ while <$df>;
			}}}

			$ofil = $ifil unless -e catfile($dir, $ofil);
		}
	}

	my $file = catdir($dir, $ofil);

	my($res, $snd);
	$res = FSpOpenResFile($file, 0) if $file;

	if ($res) {
		ok($res,				'open resource file');
		is(CurResFile(), $res,			'check current resource file');

		is(Count1Resources($otyp), 1,		'count resources');
		ok($snd = GetResource($otyp, $oid),	'get resource');

		my($id, $type, $name) = GetResInfo($snd);
		is($type, $otyp,			'resource type');
		is($id, $oid,				'resource id');
		is($name, $onam,			'resource name');
	}

	else {
		ok(1, "Can't open $ofil") for 1..2;

		my $n = Count1Resources($otyp);
		ok($n,					"count resources: $n");
		ok($snd = GetIndResource($otyp, $n),	'get resource');

		my($id, $type, $name) = GetResInfo($snd);
		TODO: {
			local $TODO = "For some reason, it is not getting the type back"
				if $^O eq 'darwin';
			is($type, $otyp,		"resource type: $type");
		}
		ok($id,					"resource id: $id");

		ok(1, "Can't open $ofil");
	}

	ok(my $chan = SndNewChannel(0, 0),		'new sound channel');
	ok(SndPlay($chan, $snd, 0),			'play sound');
	ok(SndDisposeChannel($chan, 0),			'dispose sound');

	CloseResFile($res) if $res;
}

__END__
