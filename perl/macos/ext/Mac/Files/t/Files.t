#!/usr/bin/perl
use Test::More;
use strict;
use warnings;

use lib "../blib/arch";
use lib "../blib/lib";

BEGIN { plan tests => 52 }

use File::Basename;
use File::Spec::Functions qw(catdir catfile splitdir);
use Mac::Files;
use MacPerl 'MakePath';

my(@rm_files, @rm_dirs);

END {
	unlink @rm_files;
	rmdir for reverse @rm_dirs;
}

die "FSpDelete!!!\n";

SKIP: {
#	skip "Mac::Files", 51;

	# 0
	ok(my $dir = FindFolder(kOnSystemDisk, kDesktopFolderType),  "FindFolder");
	like($dir, qr/Desktop/,                                      "Check name");
	ok(-d $dir,                                                  "Is a folder");

	# 3
	my $dir1  = catdir($dir, "f" . ("o" x 30));
	my $file1 = catdir($dir1, "a");
	push @rm_dirs,  $dir1;
	push @rm_files, $file1;
	my($type, $creator, $creator1) = ('TEXT', 'R*ch', 'MPS ');


	ok(FSpDirCreate($dir1),                                      "FSpDirCreate");
	ok(-d $dir1,                                                 "dir exists");
	ok(FSpCreate($file1, $creator, $type),                       "FSpCreate");
	ok(-f $file1,                                                "file exists");

	# 7
	ok(my $ci    = FSpGetCatInfo($dir1),                         "FSpGetCatInfo");
	ok(my $file2 = FSMakeFSSpec($ci->ioVRefNum, $ci->ioDrDirID, "b"), "FSMakeFSSpec");
	push @rm_files, MakePath($file2);
	ok(FSpCreate($file2, $creator, $type),                       "FSpCreate");
	ok(-f MakePath($file2),                                      "file exists");

	# 11
	my @stat = stat $dir1;
	my $ntime = time + 3600;
	is($ci->ioDrMdDat, $stat[9],                                 "check ioDrMdDat");
	ok($ci->ioDrMdDat($ntime),                                   "set ioDrMdDat");
	ok(FSpSetCatInfo($dir1, $ci),                                "FSpSetCatInfo");
	ok($ci = FSpGetCatInfo($dir1),                               "FSpGetCatInfo");
	@stat = stat $dir1;
	is($ci->ioDrMdDat, $stat[9],                                 "check ioDrMdDat");
	is($ci->ioDrMdDat, $ntime,                                   "check ioDrMdDat");

	# 17
	ok(my $fi = FSpGetFInfo($file1),                             "FSpGetFInfo");
	is($fi->fdType, $type,                                       "check fdType");
	is($fi->fdCreator, $creator,                                 "check fdCreator");
	ok($fi->fdCreator($creator1),                                "set fdCreator");
	ok(FSpSetFInfo($file1, $fi),                                 "FSpSetFInfo");
	ok($fi = FSpGetFInfo($file1),                                "FSpGetFInfo");
	is($fi->fdCreator, $creator1,                                "check fdCreator");

	# 24
	ok($ci = FSpGetCatInfo($file1),                              "FSpGetCatInfo");
	is($ci->ioFlAttrib & kioFlAttribLocked, 0,                   "! kioFlAttribLocked");
	ok(FSpSetFLock($file1),                                      "FSpSetFLock");
	ok($ci = FSpGetCatInfo($file1),                              "FSpGetCatInfo");
	is($ci->ioFlAttrib & kioFlAttribLocked, 1,                   "kioFlAttribLocked");
	ok(FSpRstFLock($file1),                                      "FSpRstFLock");
	ok($ci = FSpGetCatInfo($file1),                              "FSpGetCatInfo");
	is($ci->ioFlAttrib & kioFlAttribLocked, 0,                   "! kioFlAttribLocked");

	# 32
	my $file3 = catfile($dir1, "c");
	push @rm_files, $file3;
	ok(FSpRename($file1, "c"),                                   "FSpRename");
	ok(-e $file3,                                                "file exists");

	# 34
	my $dir2  = catdir($dir1, "f" . ("o" x 30));
	my $file4 = catfile($dir2, "c");
	push @rm_dirs,  $dir2;
	push @rm_files, $file4;
	ok(FSpDirCreate($dir2),                                      "FSpDirCreate");
	ok(-d $dir2,                                                 "dir exists");
	ok(FSpCatMove($file3, $dir2),                                "FSpCatMove");
	ok(-f $file4,                                                "file exists");

	# 38
	ok(open(my $fh1, ">", MakePath($file2)),                     "open file");
	ok(open(my $fh2, "> $file4"),                                "open file");
	ok(print($fh1 "foo\n"),                                      "print value");
	ok(print($fh2 "bar\n"),                                      "print value");
	ok(close($fh1),                                              "close file");
	ok(close($fh2),                                              "close file");

	ok(FSpExchangeFiles($file2, $file4),                         "FSpExchangeFiles");

	# 45
	ok(open($fh1, "<", MakePath($file2)),                        "open file");
	ok(open($fh2, "< $file4"),                                   "open file");
	is(scalar <$fh1>, "bar\n",                                   "check value");
	is(scalar <$fh2>, "foo\n",                                   "check value");
	ok(close($fh1),                                              "close file");
	ok(close($fh2),                                              "close file");
}

SKIP: {
	skip "Mac::Files Volumes", 1;

	# UnmountVol
	# Eject
	# FlushVol
}

__END__
