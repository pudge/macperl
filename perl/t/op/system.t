#!perl

BEGIN {
    chdir 't' if -d 't';
    @INC = '../lib';
    # XXX this could be further munged to enable some parts on other
    # platforms
    unless ($^O =~ /^MSWin/) {
	print "1..0 # skipped: windows specific test\n";
	exit 0;
    }
}

use File::Path;
use File::Copy;
use Config;
use Cwd;
use strict;

$| = 1;

my $cwd = cwd();

my $testdir = "t e s t";
my $exename = "showav";
my $plxname = "showargv";
rmtree($testdir);
mkdir($testdir);

open(my $F, ">$testdir/$exename.c")
    or die "Can't create $testdir/$exename.c: $!";
print $F <<'EOT';
#include <stdio.h>
int
main(int ac, char **av)
{
    int i;
    for (i = 0; i < ac; i++)
	printf("[%s]", av[i]);
    printf("\n");
    return 0;
}
EOT

open($F, ">$testdir/$plxname.bat")
    or die "Can't create $testdir/$plxname.bat: $!";
print $F <<'EOT';
@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
EOT

print $F <<EOT;
"$^X" -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
"$^X" -x -S %0 %*
EOT
print $F <<'EOT';
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
print "[$_]" for ($0, @ARGV);
print "\n";
__END__
:endofperl
EOT

close $F;

# build the executable
chdir($testdir);
END {
    chdir($cwd);
    rmtree($testdir);
}
if (open(my $EIN, "$cwd/op/${exename}_exe.uu")) {
    print "# Unpacking $exename.exe\n";
    my $e;
    {
	local $/;
	$e = unpack "u", <$EIN>;
	close $EIN;
    }
    open my $EOUT, ">$exename.exe" or die "Can't write $exename.exe: $!";
    binmode $EOUT;
    print $EOUT $e;
    close $EOUT;
}
else {
    print "# Compiling $exename.c\n";
    if (system("$Config{cc} $Config{ccflags} $exename.c 2>&1 >nul") != 0) {
	print "# Could not compile $exename.c, status $?\n"
	     ."# Where is your C compiler?\n"
	     ."1..0 # skipped: can't build test executable\n";
    }
}
copy("$plxname.bat","$plxname.cmd");
chdir($cwd);

open my $T, "$^X -I../lib -w op/system_tests |"
    or die "Can't spawn op/system_tests: $!";
my $expect;
my $comment = "";
my $test = 0;
while (<$T>) {
    chomp;
    if (/^1\.\./) {
	print "$_\n";
    }
    elsif (/^#+\s(.*)$/) {
	$comment = $1;
    }
    elsif (/^</) {
	$expect = $_;
	$expect =~ tr/<>/[]/;
	$expect =~ s/\Q$plxname\E]/$plxname.bat]/;
    }
    else {
	if ($expect ne $_) {
	    print "# $comment\n" if $comment;
	    print "# want: $expect\n";
	    print "# got : $_\n";
	    print "not ";
	}
	++$test;
	print "ok $test\n";
    }
}
close $T;
