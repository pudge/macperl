#!/usr/bin/perl -w
use Test::More;
use strict;

BEGIN { plan tests => 34 }

use vars '$PAUSE';
use Mac::Files;
use Mac::Speech;

SKIP: {
#	skip "Mac::Speech", 34;

	my(@voicefiles, $voicedir, $voice, $desc, $channel, $desd);

	$voicedir = FindFolder(kOnSystemDisk, kVoicesFolderType);
	if (opendir(my $dh, $voicedir)) {
		@voicefiles = grep /\w/, readdir $dh;
		closedir $dh;
	}
	# this can fail if some voices don't load, or if there are
	# non-voice files installed in the directory
	cmp_ok(CountVoices(), '>=', scalar @voicefiles, 'count voices');

	# start with Cellos
	ok($voice   = $Mac::Speech::Voice{Cellos},	'load voice');
	ok($desc    = GetVoiceDescription($voice),	'get description');
	ok($channel = NewSpeechChannel($voice),	'new channel');

	is('Cellos',		$desc->name,		'check name');
	is(kNeuter,		$desc->gender,		'check gender');
	is(50,			$desc->age,		'check age');
	is($voice->creator,	$desc->voice->creator,	'check creator');
	is($voice->id,		$desc->voice->id,	'check id');

	# sing
	speak($channel, 'Do you like my Cello Voice?',	'sing');
	ok(SetSpeechPitch($channel, 1.2*GetSpeechPitch($channel)),
							'adjust pitch');
	speak($channel, 'Wanna take you higher',	'sing!');
	ok(DisposeSpeechChannel($channel),		'dispose channel');


	# try again with default voice
	ok($voice   = $Mac::Speech::Voice{undef},	'load default voice');
	ok($desc    = GetVoiceDescription($voice),	'get description');
	ok($desd    = GetVoiceDescription(),		'get description');
	ok($channel = NewSpeechChannel(),		'new channel');

	is($desc->name,		$desd->name,		'check name');
	is($desc->gender,	$desd->gender,		'check gender');
	is($desc->age,		$desd->age,		'check age');
	is($voice->creator,	$desd->voice->creator,	'check creator');
	is($voice->id,		$desd->voice->id,	'check id');

	speak($channel, $desc->comment,			'speak default comment');

	# other forms of Speak
	speak('Howdy',					'SpeakString');
	speak($channel, 'Bonjour',
		kNoEndingProsody + kNoSpeechInterrupt,
							'SpeakBuffer');
	speak($channel, 'Como?', kPreflightThenPause,	'SpeakBuffer (shhhh)');

	{
		local $PAUSE = 1;
		speak($channel, <<EOS,			'speak some long text');
$ENV{USER}, welcome, it is very good to see you using Mac Carbon.
Antidisestablishmentarianism is a long word you won't get to the end of.
No really, trust me, we'll never get here!
EOS

		while (SpeechBusy()) {
			sleep 1;

			ok(PauseSpeechAt($channel, kEndOfWord),
							'pause');
			sleep 4;

			ok(ContinueSpeech($channel),	'continue');
			sleep 1;

			ok(PauseSpeechAt($channel, kEndOfSentence),
							'pause!');
			sleep 6;

			ok(ContinueSpeech($channel),	'continue');
			sleep 2;

			ok(StopSpeechAt($channel, kImmediate),
							'stop it!');

			last;
		}
	}


	ok(TextToPhonemes($channel, 'Stop all the clocks disconnect the phone')
		=~ /^_st1AAp/, # _1AOl ~DAX _kl1AAks _d2IHskAXn1EHkt ~DAX _f1OWn',
							'phonemes');

	ok(DisposeSpeechChannel($channel),		'dispose channel');
}

sub speak {
	my $msg = pop;
	if (@_ == 2) {
		ok(SpeakText(@_), $msg);
	} elsif (@_ == 1) {
		ok(SpeakString(@_), $msg);
	} elsif (@_ == 3) {
		ok(SpeakBuffer(@_), $msg);
	} else {
		ok(0, 'Bad arguments to speak()');
	}

	unless ($PAUSE) {
		sleep 1 while SpeechBusy();
	}
}

__END__
