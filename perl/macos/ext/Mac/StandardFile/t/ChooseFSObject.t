#! perl -w
use Mac::StandardFile;
use File::Spec;

# choose a folder or volume 
$path = ChooseFSObject( kGetFolder, File::Spec->rootdir );
if ($path) {
	print "path = $path \n";
} else {
	print "User canceled. \n";
}

# choose a file 
$path = ChooseFSObject( kGetFile );
if ($path) {
	print "path = $path \n";
} else {
	print "User canceled. \n";
}

