=head1 NAME

Mac::Files - Macintosh Toolbox Interface to the File and Alias Manager

=head1 SYNOPSIS


=head1 DESCRIPTION

=cut

use strict;

package Mac::Files;

BEGIN {
	use Exporter   ();
	use DynaLoader ();
	
	use vars qw(@ISA @EXPORT);
	
	@ISA = qw(Exporter DynaLoader);
	@EXPORT = qw(
		FSpGetCatInfo
		FSpSetCatInfo
		FSMakeFSSpec
		FSpCreate
		FSpDirCreate
		FSpDelete
		FSpGetFInfo
		FSpSetFInfo
		FSpSetFLock
		FSpRstFLock
		FSpRename
		FSpCatMove
		FSpExchangeFiles
		NewAlias
		NewAliasRelative
		NewAliasMinimal
		NewAliasMinimalFromFullPath
		UpdateAlias
		UpdateAliasRelative
		ResolveAlias
		ResolveAliasRelative
		GetAliasInfo
		UnmountVol
		Eject
		FlushVol
		FindFolder
		kOnSystemDisk
		kCreateFolder
		kDontCreateFolder
		kSystemFolderType
		kDesktopFolderType
		kTrashFolderType
		kWhereToEmptyTrashFolderType
		kPrintMonitorDocsFolderType
		kStartupFolderType
		kShutdownFolderType
		kAppleMenuFolderType
		kControlPanelFolderType
		kExtensionFolderType
		kFontsFolderType
		kPreferencesFolderType
		kTemporaryFolderType
		asiZoneName
		asiServerName
		asiVolumeName
		asiAliasName
		asiParentName
	);
}

bootstrap Mac::Files;


=head2 Constants

=over 4

=item kOnSystemDisk

=item kCreateFolder

=item kDontCreateFolder

Constants for Folder Manager.

=cut
sub kOnSystemDisk ()               {     0x8000; }
sub kCreateFolder ()               {          1; }
sub kDontCreateFolder ()           {          0; }

=item kSystemFolderType

the system folder.

=cut
sub kSystemFolderType ()           {     'macs'; }

=item kDesktopFolderType

the desktop.

=cut
sub kDesktopFolderType ()          {     'desk'; }

=item kTrashFolderType

the trash.

=cut
sub kTrashFolderType ()            {     'trsh'; }
sub kWhereToEmptyTrashFolderType () {    'empt'; }
sub kPrintMonitorDocsFolderType () {     'prnt'; }

=item kStartupFolderType

the startup items folder.

=cut
sub kStartupFolderType ()          {     'strt'; }

=item kShutdownFolderType

the shutdown items folder.

=cut
sub kShutdownFolderType ()         {     'shdf'; }

=item kAppleMenuFolderType

the apple menu folder.

=cut
sub kAppleMenuFolderType ()        {     'amnu'; }

=item kControlPanelFolderType

the control panels folder.

=cut
sub kControlPanelFolderType ()     {     'ctrl'; }

=item kExtensionFolderType

the extensions folder.

=cut
sub kExtensionFolderType ()        {     'extn'; }

=item kFontsFolderType

the fonts folder.

=cut
sub kFontsFolderType ()            {     'font'; }

=item kPreferencesFolderType

the preferences folder.

=cut
sub kPreferencesFolderType ()      {     'pref'; }

=item kTemporaryFolderType

the temporary items folder.

=cut
sub kTemporaryFolderType ()        {     'temp'; }

=item asiZoneName

Return AppleTalk zone name from GetAliasInfo.

=cut
sub asiZoneName ()                 {         -3; }

=item asiServerName

Return AppleTalk server name from GetAliasInfo.

=cut
sub asiServerName ()               {         -2; }

=item asiVolumeName

Return volume name from GetAliasInfo.

=cut
sub asiVolumeName ()               {         -1; }

=item asiAliasName

Return last component of target file name from GetAliasInfo.

=cut
sub asiAliasName ()                {          0; }

=item asiParentName

Return name of enclosing folder from GetAliasInfo. This index value is 1.
Higher indices will return folder names higher up the hierarchy.

=cut
sub asiParentName ()               {          1; }

=back

=cut
# 
# Translate volume name or number
#
sub _VolumeID {
	my ($id) = @_;
	my ($name, $vRef);
	if ($id =~ /^[^:]+:$/) {
		($name, $vRef) = ($id, 0);
	} else {
		($name, $vRef) = ("", $id);
	}
	return ($name, $vRef);
}

sub UnmountVol 	{	_UnmountVol(&_VolumeID);	}
sub Eject		{	_Eject     (&_VolumeID);	}
sub FlushVol 	{	_FlushVol  (&_VolumeID);	}

=include Files.xs

=head1 AUTHOR

Matthias Ulrich Neeracher <neeri@iis.ee.ethz.ch>

=cut

1;

__END__
