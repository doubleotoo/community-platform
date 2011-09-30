#!/usr/bin/perl

use utf8;

use FindBin;
use lib $FindBin::Dir . "/../lib"; 

use strict;

use File::Path qw( make_path remove_tree );

use DDGC::Config;
use SQL::Translator::Diff;
use File::Copy;

use Getopt::Long;

my $kill;

GetOptions (
	"kill"  => \$kill,
);

if (-d DDGC::Config::rootdir_path) {
	$kill ? remove_tree(DDGC::Config::rootdir_path) : die "environment exist, use --kill to kill it!"
}

DDGC::Config::rootdir();
DDGC::Config::filesdir();
DDGC::Config::cachedir();

copy(DDGC::Config::prosody_db_samplefile,DDGC::Config::rootdir) or die "Copy failed: $!";

eval {
	exec $FindBin::Dir . "/ddgc_db_autoupgrade.pl";
};

die $@ if $@;
