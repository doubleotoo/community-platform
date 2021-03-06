#!/usr/bin/perl

use utf8::all;
use strict;
use warnings;

use FindBin;
use lib $FindBin::Dir . "/../lib"; 
use DDGC;

my $ddgc = DDGC->new;
my $schema = $ddgc->db;

my @languages = $schema->resultset('Language')->search;

print "\n";

for (@languages) {
	print '#'.$_->id.' '.$_->name_in_english.' ('.$_->locale.')'."\n";
}

print "\n";

my @tds = $schema->resultset('Token::Domain')->search;

for (@tds) {
	print 'Token-Domain: '.$_->key."\n";
	for ($_->token_domain_languages->search) {
		print $_->language->locale.' ';
	}
	print "\n";
	print "\n";
}

