#!/usr/bin/env perl
use strict;
use warnings;

my $x = $ARGV[0] ? $ARGV[0] : 1 + int(rand(10000));
my $y = $ARGV[1] ? $ARGV[1] : 1 + int(rand(10000));

print $x*$y % 2 == 0 ? "Even" : "Odd";
