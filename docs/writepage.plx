#!/usr/bin/perl -w
use strict;
use vars qw(%data $group);

my($text, $file, $task_format);

$file		= shift;
$group		||= shift || 7940;  # macperl is 7940, slash is 4421
$task_format	= shift || "\t\t\t<li><a href=\"%s\">%s</a></li>\n";

require "get_stats.plx";

{
	local($/, *FILE);
	open FILE, "<" . $file or die "Cannot open $file for reading: $!";
	$text = <>;
	close FILE or die "Cannot close $file: $!";
}

if (exists $data{Bugs}) {
	fixnum(qw(Bugs open));
	fixnum(qw(Bugs total));
}

if (exists $data{Patches}) {
	fixnum(qw(Patches open));
	fixnum(qw(Patches total));
}

if (exists $data{CVS}) {
	fixnum(qw(CVS commit));
	fixnum(qw(CVS add));
}

if (exists $data{Tasks}{tasks}) {
	my $tasks;
	for (@{$data{Tasks}{tasks}}) {
		$_->{href} =~ s/&/&amp;/g;
		$tasks .= sprintf $task_format, @{$_}{qw(href task)};
	}
	$text =~ s/(\n\t+<!-- Tasks\|begin -->\n).*(\t+<!-- Tasks\|end -->)/$1$tasks$2/sg;
}

sub fixnum {
	my($k1, $k2) = @_;
	$text =~ s/(<!-- $k1\|$k2 -->)\d*/$1$data{$k1}{$k2}/g;

}

{
	local(*FILE);
	open FILE, ">" . $file or die "Cannot open $file for writing: $!";
	print $text;
	close FILE or warn "Cannot close $file: $!";
}

1;
