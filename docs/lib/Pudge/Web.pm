# $Id$

package Pudge::Web;

=head1 NAME

Pudge::Web - Various functions available for Pudge's web stuff


=head1 SYNOPSIS

	use Pudge::Web;


=head1 DESCRIPTION

Foo.

=head1 EXPORTED FUNCTIONS

=cut

use strict;
use CGI;
use DBIx::Password;
use Template;
use vars qw($VERSION);

($VERSION) = ' $Revision$ ' =~ /\$Revision:\s+([^\s]+)/;

use constant ALLOWED	=> 0;
use constant FUNCTION	=> 1;

sub new {
	my($class, %args) = @_;
	return unless $class;
	return bless {
		cgi	=> CGI->new,
		%args
	}, $class; 
}

sub initdata {
	my($self) = @_;
	$self->{form} = $self->{cgi}->Vars;
	main::login();	# maybe put in Pudge::Web?
}

sub main {
	my($self) = @_;

	my $op = $self->{form}{op};
	if (!$op || !exists $self->{ops}{$op} || !$self->{ops}{$op}[ALLOWED]) {
		$op = 'default';
	}

	# dispatch of op
	$self->{ops}{$op}[FUNCTION]->($self);
	$self->footer();
}

sub header {
	my($self, $title) = @_;
	print $self->{cgi}->header($self->prep_cookie);
	$self->process('header', { title => $title });
}

sub footer {
	my($self) = @_;
	$self->process('menu');
	$self->process('footer');
}

sub error {
	my($self, $error) = @_;
	$self->header('Error');
	$self->process('error', { err => $error });
}

sub prep_cookie {
	my($self, $session) = @_;

	my $val = $self->{user}{id} && $self->{user}{pass}
		? "$self->{user}{id}:$self->{user}{pass}"
		: "";

	my %cookie = (
		-domain	=> $self->{cookie_domain},
		-name   => $self->{cookie_name},
		-path	=> $self->{cookie_path},
		-value	=> $val
	);
	
	$cookie{-expires} = '+6M' unless $session;

	return {
		-date		=> $self->{cgi}->expires(0, 'http'),
		-set_cookie	=> $self->{cgi}->cookie(%cookie)
	};
}

sub get_cookie {
	my($self) = @_;
	my $cookie = $self->{cgi}->cookie($self->{cookie_name});
	if ($cookie) {
		my($id, $pass) = split /:/, $cookie, 2;
		return($id, $pass);
	} else {
		return;
	}
}

sub template {
	my($self) = @_;
	my $template = Template->new(
		TRIM		=> 1,
		INCLUDE_PATH	=> $self->{tt_path}
	);
}

sub process {
	my($self, $name, $data) = @_;
	$self->{_template} ||= $self->template();

	$data = {
		env		=> { map { lc, $ENV{$_} } keys %ENV },
		user		=> $self->{user},
		form		=> $self->{form},
		constants	=> { %$self },
		ref $data ? %$data : ()
	};

	$self->{_template}->process($name, $data);
}

sub connect {
	my($self) = @_;
	$self->{dbh} ||= DBIx::Password->connect($self->{virtual_user});
}

sub get_sth {
	my($self, $sql, @params) = @_;
	my $sth = $self->{dbh}->prepare($sql);
	$sth->execute(@params);
	return $sth;
}

sub DESTROY {
	my($self) = @_;
	$self->{dbh}->disconnect if $self->{dbh};
}

1;

__END__

=head1 VERSION

$Id$
