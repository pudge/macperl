#!/usr/bin/perl -sw

use lib "../perl/lib";
use strict;
use Digest::MD5 'md5_hex';
use File::Find;
use File::Spec::Functions;
use Pudge::Web;
use vars '$compile';

{
	my $dir = "/home/groups/m/ma/macperl";
	my($pw) = Pudge::Web->new(
		Id		=> '$Id$',
		virtual_user	=> "macperl",
#		ttc_path	=> catdir($dir, "ttc"),
		tt_path		=> [
			catdir($dir, qw(htdocs templates index)),
			catdir($dir, qw(htdocs templates)),
		],
	);

	main($pw);
}


sub main {
	my($pw) = @_;
	$pw->initdata();

	# possible value of "op" parameter in form
	$pw->{ops} = {
	    home	=> [ 1,			\&home	],
	    build	=> [ 1,			\&build	],

	    default	=> [ 1,			\&home	]
	};

	compile($pw) if $compile;

	$pw->main();
}

sub home {
	my($pw) = @_;
	$pw->header();
	$pw->process('index');
}

sub build {
	my($pw) = @_;
	$pw->header('Build Instructions', {
		base => 'http://dev.macperl.org/build.html'
	});
	$pw->process('build');
}

