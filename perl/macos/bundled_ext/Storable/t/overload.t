#!./perl

# $Id$
#
#  Copyright (c) 1995-2000, Raphael Manfredi
#  
#  You may redistribute only under the same terms as Perl 5, as specified
#  in the README file that comes with the distribution.
#  
# $Log$
# Revision 1.0.1.1  2001/02/17 12:27:22  ram
# patch8: added test for structures with indirect ref to overloaded
#
# Revision 1.0  2000/09/01 19:40:42  ram
# Baseline for first official release.
#

require 't/dump.pl';
sub ok;

use Storable qw(freeze thaw);

print "1..12\n";

package OVERLOADED;

use overload
	'""' => sub { $_[0][0] };

package main;

$a = bless [77], OVERLOADED;

$b = thaw freeze $a;
ok 1, ref $b eq 'OVERLOADED';
ok 2, "$b" eq "77";

$c = thaw freeze \$a;
ok 3, ref $c eq 'REF';
ok 4, ref $$c eq 'OVERLOADED';
ok 5, "$$c" eq "77";

$d = thaw freeze [$a, $a];
ok 6, "$d->[0]" eq "77";
$d->[0][0]++;
ok 7, "$d->[1]" eq "78";

package REF_TO_OVER;

sub make {
	my $self = bless {}, shift;
	my ($over) = @_;
	$self->{over} = $over;
	return $self;
}

package OVER;

use overload
	'+'		=> \&plus,
	'""'	=> sub { ref $_[0] };

sub plus {
	return 314;
}

sub make {
	my $self = bless {}, shift;
	my $ref = REF_TO_OVER->make($self);
	$self->{ref} = $ref;
	return $self;
}

package main;

$a = OVER->make();
$b = thaw freeze $a;

ok 8, ref $b eq 'OVER';
ok 9, $a + $a == 314;
ok 10, ref $b->{ref} eq 'REF_TO_OVER';
ok 11, "$b->{ref}->{over}" eq "$b";
ok 12, $b + $b == 314;

1;

