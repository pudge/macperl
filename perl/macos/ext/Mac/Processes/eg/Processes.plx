Perl -Sx "{0}" {"Parameters"}; Exit {Status}

#!perl
#
# Processes.t - List all processes, then try to launch MacPerl
#

use Mac::Processes;
use Mac::MoreFiles(%Application);

printf "%-20s %-8s  %-8s\n", "Process Name", "PSN", "App Spec";

while (($psn, $pi) = each %Process) {
	printf "%-20s %08X %s\n", 
		$pi->processName, $pi->processNumber, $pi->processAppSpec;
}

my $app = $Application{McPL};
if (-e $app) {
	$Launch = new LaunchParam(
		launchControlFlags => launchContinue+launchNoFileFlags+launchDontSwitch,
		launchAppSpec      => $app
	);

	LaunchApplication($Launch) || die $^E+0;

	printf "Launched %X flags %X\n", $Launch->launchProcessSN, $Launch->launchControlFlags;
}
