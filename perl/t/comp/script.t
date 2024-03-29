#!./perl

# $RCSfile$$Revision$$Date$

print "1..3\n";

$PERL = ($^O eq 'MSWin32') ? '.\perl'
    : ($^O eq 'MacOS') ? $^X : './perl';
$x = `$PERL -le "print 'ok';"`;

if ($x eq "ok\n") {print "ok 1\n";} else {print "not ok 1\n";}

open(try,">Comp.script") || (die "Can't open temp file.");
print try 'print "ok\n";'; print try "\n";
close try;

$x = `$PERL Comp.script`;

if ($x eq "ok\n") {print "ok 2\n";} else {print "not ok 2\n";}

$x = `$PERL <Comp.script`;

if ($x eq "ok\n") {print "ok 3\n";} else {print "not ok 3\n";}

unlink 'Comp.script' || `/bin/rm -f Comp.script`;
