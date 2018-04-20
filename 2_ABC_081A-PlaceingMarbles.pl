#!/usr/bin/env perl
use strict;
use warnings;

my $str = "101";

print scalar( my @arr = $str =~ m/1/g );
