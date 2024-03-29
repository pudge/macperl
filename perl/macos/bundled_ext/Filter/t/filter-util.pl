
use strict ;
use warnings;

use vars qw( $Perl $Inc);

sub readFile
{
    my ($filename) = @_ ;
    my ($string) = '' ;

    open (F, "<$filename") 
	or die "Cannot open $filename: $!\n" ;
    while (<F>)
      { $string .= $_ }
    close F ;
    $string ;
}

sub writeFile
{
    my($filename, @strings) = @_ ;
    open (F, ">$filename") 
	or die "Cannot open $filename: $!\n" ;
    binmode(F) if $filename =~ /bin$/i;
    foreach (@strings)
      { print F }
    close F or die "Could not close: $!" ;
}

sub ok
{
    my($number, $result, $note) = @_ ;
 
    $note = "" if ! defined $note ;
    if ($note) {
        $note = "# $note" if $note !~ /^\s*#/ ;
        $note =~ s/^\s*/ / ;
    }

    print "not " if !$result ;
    print "ok ${number}${note}\n";
}

$Inc = '' ;
foreach (@INC)
 { $Inc .= "\"-I$_\" " }

$Perl = '' ;
$Perl = ($ENV{'FULLPERL'} or $^X or 'perl') ;

$Perl = "$Perl -MMac::err=unix" if $^O eq 'MacOS';
$Perl = "$Perl -w" ;

1;
