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
use HTML::Entities;
use Template;
use URI;
use vars qw($VERSION);

($VERSION) = ' $Revision$ ' =~ /\$Revision:\s+([^\s]+)/;

use constant ALLOWED	=> 0;
use constant FUNCTION	=> 1;

# for Slash::Utility functions
use constant ATTRIBUTE	=> -2;
use constant LITERAL	=> -1;
use constant NOHTML	=> 0;
use constant PLAINTEXT	=> 1;
use constant HTML	=> 2;
use constant EXTRANS	=> 3;
use constant CODE	=> 4;

sub new {
	my($class, %args) = @_;
	return unless $class;
	my $self = bless {
		cgi	=> CGI->new,
		%args
	}, $class;
	$self->connect;
	return $self;
}

sub initdata {
	my($self) = @_;
	$self->{form} = $self->{cgi}->Vars;
	main::login($self);	# maybe put in Pudge::Web?
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
	require Template::Filters;

	my $strip_mode = sub {
		my($context, @args) = @_;
		return sub { strip_mode($_[0], @args) };
	};

	my $filters = Template::Filters->new({ FILTERS => {
		fixdate		=> \&fixdate,
		fixparam	=> \&fixparam,
		fixurl		=> \&fixurl,
		strip_attribute	=> \&strip_attribute,
		strip_code	=> \&strip_code,
		strip_extrans	=> \&strip_extrans,
		strip_html	=> \&strip_html,
		strip_literal	=> \&strip_literal,
		strip_nohtml	=> \&strip_nohtml,
		strip_plaintext	=> \&strip_plaintext,
		strip_mode	=> [ $strip_mode, 1 ]
	}});

	my %data = (
		TRIM		=> 1,
		INCLUDE_PATH	=> $self->{tt_path},
		LOAD_FILTERS	=> $filters
		    );
	$data{COMPILE_DIR}      =  $self->{ttc_path} if $self->{ttc_path};

	my $template = Template->new(%data);
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

	$self->{_template}->process($name, $data)
	    or print STDERR $self->{_template}->error;
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

sub get_dbarray {
	my($self, $st, @args) = @_;

	my $sql = $self->compose_select($st);
	my $sth = $self->get_sth($sql, @args);

	return $sth->fetchrow_array;
}

sub get_dbhash {
	my($self, $st, $id, @args) = @_;

	my $sql = $self->compose_select($st);
	my $sth = $self->get_sth($sql, @args);

	my $data = {};
	while (my $row = $sth->fetchrow_hashref) {
		$data->{$row->{$id}} = $row;
	}
	return $data;
}

sub get_dbhashdesc {
	my($self, $st, @args) = @_;

	my $sql = $self->compose_select($st);
	my $sth = $self->get_sth($sql, @args);

	my $data = {};
	while (my $row = $sth->fetchrow_arrayref) {
		$data->{$row->[0]} = $row->[1];
	}
	return $data;
}

sub compose_select {
	my($self, $args) = @_;
	use Carp;
	confess("DAMMIT") unless $args->[0];
	my $sql = "SELECT $args->[0]";
	$sql   .= " FROM $args->[1]"  if $args->[1];
	$sql   .= " WHERE $args->[2]" if $args->[2];
	$sql   .= " $args->[3]"       if $args->[3];
	return $sql;
}

sub DESTROY {
	my($self) = @_;
	$self->{dbh}->disconnect if $self->{dbh};
}


# extra functions from Slash::Utility

sub fixdate {
	my($date) = @_;
	$date =~ s{^(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)$}
		  {"$1-$2-$3 $4:$5:$6"}e;
	return $date;
}

sub stripByMode {
	my($str, $fmode, $no_white_fix) = @_;
	$fmode ||= NOHTML;
	$no_white_fix = defined($no_white_fix) ? $no_white_fix : $fmode == LITERAL;

	# insert whitespace into long words, convert <>& to HTML entities
	if ($fmode == LITERAL || $fmode == EXTRANS || $fmode == ATTRIBUTE || $fmode == CODE) {
		$str = breakHtml($str) unless $no_white_fix;
		# Encode all HTML tags
		$str =~ s/&/&amp;/g;
		$str =~ s/</&lt;/g;
		$str =~ s/>/&gt;/g;

	} elsif ($fmode == PLAINTEXT) {
		$str = stripBadHtml($str);
		$str = breakHtml($str) unless $no_white_fix;
	}

	# convert regular text to HTML-ized text, insert P, etc.
	if ($fmode == PLAINTEXT || $fmode == EXTRANS || $fmode == CODE) {
		$str =~ s|\n|<br />|gi;  # pp breaks
		$str =~ s|(?:<br />\s*){2,}<br />|<br /><br />|gi;
		# Preserve leading indents / spaces
		$str =~ s/\t/    /g;  # can mess up internal tabs, oh well

		if ($fmode == CODE) {
			$str =~ s{((?:  )+)(?: (\S))?} {
				("&nbsp; " x (length($1)/2)) .
				($2 ? "&nbsp;$2" : "")
			}eg;
			$str = '<code>' . $str . '</code>';

		} else {
			$str =~ s{<br />\n?( +)} {
				"<br />\n" . ("&nbsp; " x length($1))
			}ieg;
		}

	# strip out all HTML
	} elsif ($fmode == NOHTML) {
		$str =~ s/<.*?>//g;
		$str =~ s/<//g;
		$str =~ s/>//g;
		$str =~ s/&/&amp;/g;

	# convert HTML attribute to allowed text (just convert ")
	} elsif ($fmode == ATTRIBUTE) {
		$str =~ s/"/&#34;/g;

	# probably 'html'
	} else {
		$str = stripBadHtml($str);
		$str = breakHtml($str) unless $no_white_fix;
	}

	return $str;
}

sub strip_mode {
	my($string, $mode, @args) = @_;
	return if !$mode || $mode < 1;	# user-supplied modes > 0
	return stripByMode($string, $mode, @args);
}

sub strip_attribute	{ stripByMode($_[0], ATTRIBUTE,	@_[1 .. $#_]) }
sub strip_code		{ stripByMode($_[0], CODE,	@_[1 .. $#_]) }
sub strip_extrans	{ stripByMode($_[0], EXTRANS,	@_[1 .. $#_]) }
sub strip_html		{ stripByMode($_[0], HTML,	@_[1 .. $#_]) }
sub strip_literal	{ stripByMode($_[0], LITERAL,	@_[1 .. $#_]) }
sub strip_nohtml	{ stripByMode($_[0], NOHTML,	@_[1 .. $#_]) }
sub strip_plaintext	{ stripByMode($_[0], PLAINTEXT,	@_[1 .. $#_]) }

sub fixparam {
	fixurl($_[0], 1);
}

sub fixurl {
	my($url, $parameter) = @_;

	my $stripauth = 1;

	if ($parameter) {
		$url =~ s/([^$URI::unreserved])/$URI::Escape::escapes{$1}/oge;
		return $url;
	} else {
		$url =~ s/[" ]//g;
		# strip surrounding ' if exists
		$url =~ s/^'(.+?)'$/$1/g;
		# add '#' to allowed characters
		$url =~ s/([^$URI::uric#])/$URI::Escape::escapes{$1}/oge;

		if ($stripauth) {
			my $uri = new URI $url;
			if ($uri && $uri->can('host') && $uri->can('authority')) {
				# don't need to print the port if we
				# already have the correct port
				my $host = $uri->can('host_port') &&
					$uri->port != $uri->default_port
					? $uri->host_port
					: $uri->host;
				$uri->authority($host);
				$url = $uri->as_string;
			}
		}

		# we don't like SCRIPT a the beginning of a URL
		my $decoded_url = decode_entities($url);
		return $decoded_url =~ s|^\s*\w+script\b.*$||i ? undef : $url;
	}
}

sub approveTag {
	my($tag) = @_;

	$tag =~ s/^\s*?(.*)\s*?$/$1/; # trim leading and trailing spaces
	$tag =~ s/\bstyle\s*=(.*)$//i; # go away please

	# Take care of URL:foo and other HREFs
	if ($tag =~ /^URL:(.+)$/i) {
		my $url = fixurl($1);
		return qq!<A HREF="$url">$url</A>!;
	} elsif ($tag =~ /href\s*=(.+)$/i) {
		my $url = fixurl($1);
		return qq!<A HREF="$url">!;
	}

	# Validate all other tags
	my $approvedtags = [qw(B I P A LI OL UL EM BR TT STRONG BLOCKQUOTE DIV)];
	$tag =~ s|^(/?\w+)|\U$1|;
	foreach my $goodtag (@$approvedtags) {
		return "<$tag>" if $tag =~ /^$goodtag$/ || $tag =~ m|^/$goodtag$|;
	}
}

sub stripBadHtml {
	my($str) = @_;

	$str =~ s/<(?!.*?>)//gs;
	$str =~ s/<(.*?)>/approveTag($1)/sge;
	$str =~ s/></> </g;

	return $str;
}

{
	# this should be defined in vars table
	my %is_break_tag = map { uc, 1 } qw(HR P LI OL UL BR BLOCKQUOTE DIV);

	sub breakHtml {
		my($text, $mwl) = @_;
		my($new, $l, $c, $in_tag, $this_tag, $cwl);

		$mwl = $mwl || 50;
		$l = length $text;

		for (my $i = 0; $i < $l; $new .= $c, ++$i) {
			$c = substr($text, $i, 1);
			if ($c eq '<')		{ $in_tag = 1 }
			elsif ($c eq '>')	{
				$in_tag = 0;
				$this_tag =~ s{^/?(\S+).*}{\U$1};
				$cwl = 0 if $is_break_tag{$this_tag};
				$this_tag = '';
			}
			elsif ($in_tag)		{ $this_tag .= $c }
			elsif ($c =~ /\s/)	{ $cwl = 0 }
			elsif (++$cwl > $mwl)	{ $new .= ' '; $cwl = 1 }
		}

		return $new;
	}
}



1;

__END__

=head1 VERSION

$Id$
