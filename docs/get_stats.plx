#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use LWP::Simple;

my $group = shift || 7940;  # macperl is 7940, slash is 4421
my $url = "http://sourceforge.net/export/projhtml.php?group_id=$group&mode=full&no_table=1";
my $text = get $url;
$text =~ s/\015?\012/\n/g;

my(%data, $in_tasks);

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

	undef $_;
	($_) = $line =~ / ALT="([^"]+)" /;
	next unless $_;

	($data{$_}{href}) = $line =~ / href="([^"]+)">/;

	if (/^Bugs$/) {
		(@{$data{$_}}{'open', 'closed'}) =
			$line =~ m{ \( <B>(\d+)</B> open bugs, <B>(\d+)</B> total \)};

	} elsif (/^Patches$/) {
		(@{$data{$_}}{'open', 'closed'}) =
			$line =~ m{ \( <B>(\d+)</B> open patches, <B>(\d+)</B> total \)};

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

print Dumper \%data;
