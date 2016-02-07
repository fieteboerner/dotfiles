#!/usr/bin/perl -w
#
use strict;
use warnings;
use Encode;

my $test = "hallo Welt";

print Encode::encode($test);



