#!/usr/bin/perl -w
use Test::More;
use strict;

BEGIN { plan tests => 1 }

use Mac::Files;

SKIP: {
#	skip "Mac::Files", 1;
	ok(1);
}

__END__

print FindFolder(kOnSystemDisk, kSystemFolderType), "\n";
$info = FSpGetCatInfo("::Makefile.mk");
print $info->ioDrMdDat, "\n";
print $info->ioFlMdDat, "\n";
$finfo = $info->ioFlFndrInfo;
print $finfo->fdType, "\n";
