#!/usr/bin/perl -sw
# $Id$

use strict;
use Data::Dumper;
use LWP::Simple;
use vars qw(%data $group $print);
$print = 1;

$group ||= shift || 7940;  # macperl is 7940, slash is 4421
my $url = "http://sourceforge.net/export/projhtml.php?group_id=$group&mode=full&no_table=1";
my $text = get $url;
$text =~ s/\015?\012/\n/g;

my($in_tasks, $in_track);

for my $line (split /\n/, $text) {

	if ($in_tasks) {
		unless ($line) {
			$in_tasks = 0;
			next;
		}

		my %task;
		($task{task}) = $line =~ m{>([^<]+)</A>$};
		($task{href}) = $line =~ / HREF="([^"]+)">/;
		push @{$data{$_}{tasks}}, \%task;
		next;
	}

	unless ($in_track) {
		undef $_;
		($_) = $line =~ / ALT="([^"]+)" /;
		unless ($_) {
			($_) = $line =~ m|tracker/\?atid=.+?">(.+?)</A>|;
			$in_track = 1 if $_;
		}
		next unless $_;
		($data{$_}{href}) = $line =~ / href="([^"]+)">/i;
		next if $in_track;
	}

	if ($in_track) {
		(@{$data{$_}}{'items'}) =
			$line =~ m{\( <B>(\d+)</B> items\)};
		$in_track = 0;

	} elsif (/^Patches$/) {
		(@{$data{$_}}{'items'}) =
			$line =~ m{\( <B>(\d+)</B> items\)};
		$in_track = 0;

	} elsif (/^Feature Requests$/) {
		(@{$data{$_}}{'items'}) =
			$line =~ m{\( <B>(\d+)</B> items\)};
		$in_track = 0;

	} elsif (/^CVS$/) {
		(@{$data{$_}}{'commit', 'add'}) =
			$line =~ m{ \( <B>(\d+)</B> commits, <B>(\d+)</B> adds \)};

	} elsif (/^Tasks$/) {
		$in_tasks = 1;
		next;

	} elsif (/^Mail Lists$/) {
		($data{$_}{'lists'}) =
			$line =~ m{ \( <B>(\d+)</B> public lists \)};
	}

}

print Dumper \%data if $print;

1;
