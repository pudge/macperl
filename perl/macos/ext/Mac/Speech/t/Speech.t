#!/usr/bin/perl -w
use Test::More;
use strict;

BEGIN { plan tests => 8 }

use Mac::Files;
use Mac::Speech;

SKIP: {
#	skip "Mac::Speech", 8;

	my @voicefiles;
	my $voicedir = FindFolder(kOnSystemDisk, kVoicesFolderType);
	if (opendir(my $dh, $voicedir)) {
		@voicefiles = grep /\w/, readdir $dh;
		closedir $dh;
	}

	# this can fail if some voices don't load, or if there are
	# non-voice files installed in the directory
	cmp_ok(CountVoices(), '>=', scalar @voicefiles, 'count voices');

	ok(my $voice   = $Mac::Speech::Voice{Cello}, 	'load voice');
	ok(my $channel = NewSpeechChannel($voice),	'new channel');
	ok(SpeakText($channel, "Do you like my Cello Voice?"),
							'speak');
	sleep 1 while SpeechBusy();

	ok(SetSpeechPitch($channel, 1.2*GetSpeechPitch($channel)),
							'adjust pitch');
	ok(SpeakText($channel, "Wanna take you higher"),
							'speak!');
	sleep 1 while SpeechBusy();

	is(TextToPhonemes($channel, 'Stop all the clocks disconnect the phone'),
		'_st1AAp _1AOl ~DAX _kl1AAks _d2IHskAXn1EHkt ~DAX _f1OWn',
							'phonemes');

	ok(DisposeSpeechChannel($channel),		'dispose channel');
}

__END__
