#!/usr/bin/perl -w
use File::Spec::Functions 'devnull';
use Test::More;
use strict;

BEGIN { plan tests => 10 }

use Mac::Memory;
use Mac::Notification;
use Mac::Processes;
use MacPerl 'DoAppleScript';

local *OLDERR;

SKIP: {
#	skip "Mac::Notification", 10;

	my($process, $name);
	if ($^O eq 'MacOS') {
		$name = 'MacPerl';
		$process = GetCurrentProcess();
	} else {
		# current process is "perl"!  We want the parent,
		# e.g., Terminal, as it is hard to put a non-application
		# process in the "background"
		my $current = $Process{ GetCurrentProcess() };
		my $parent  = $Process{ $current->processLauncher };

		# if no parent app, get Finder
		if (!$parent) {
			while (my($psn, $psi) = each %Process) {
				$parent = $psi, last if $psi->processName eq 'Finder';
			}
		}
		# we'll use perl if we have to, i suppose ...
		$current = $parent if $parent;

		$name      = $current->processName;
		$process   = $current->processNumber;
	}

	ok($process, 'process number');
	ok($name, 'process name');

	if (SameProcess($process, GetFrontProcess())) {
		ok(my $notification = NMRec->new(
			nmStr	=> "Switch $name to the background, please.  " .
				"I'll switch in 30 seconds if you don't."
		), 'create notification');

		close_stderr();
		ok(NMInstall($notification),	'install notification');
		open_stderr();

		my $count = 0;
		while (SameProcess($process, GetFrontProcess())) {
			sleep 1;
			if (++$count >= 30) {
				# fails if Finder is not running ... but we don't want to
				# wait around forever
				DoAppleScript('tell app "Finder" to activate');
				last;
			}
		}
		ok(NMRemove($notification),	'remove notification');
	} else {
		ok(1, "$name is in background") for 1..3;
	}

	ok(my $notification = NMRec->new(
		nmSound => Handle->new(-1),
		nmStr	=> "Please wait a few seconds, I will bring $name to the front.",
	), 'create notification');

	close_stderr();
	ok(NMInstall($notification),	'install notification');
	open_stderr();

	my $count = 0;
	until (SameProcess($process, GetFrontProcess())) {
		sleep 1;
		last if ++$count >= 5;
	}

	ok(my $lp = new LaunchParam(
		launchAppSpec		=> $Mac::Processes::Process{$process}->processAppSpec,
		launchControlFlags	=> launchContinue(),
	), 'create launch param');
	ok(LaunchApplication($lp),	'switching back');

	ok(NMRemove($notification),	'remove notification');
}



# Notification manager prints to STDERR
sub close_stderr {
	open OLDERR, ">&STDERR";
	close STDERR;
}

sub open_stderr {
	open STDERR, ">&OLDERR";
}

__END__

# notification with sound is broken.  can we fix it?  test for it?
# notification with app icon ... how to specify app icon, when "app"
# is perl?  any way?

#
# Notify with custom sound and application icon only. 
# Sample from pitchshifter's _www.pitchshifter.com_ used with 
# permission.
#
$file = -d 't' ? 't/Notification.rsrc' : 'Notification.rsrc';
($res = FSpOpenResFile($file, 0)) or die $^E;
$snd = GetResource("snd ", 128);
DoNotify(new NMRec(nmMark=>0, nmSound=>$snd));
CloseResFile($res);
