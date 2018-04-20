#!/usr/bin/env perl
use strict;
use warnings;

my $x = 1 + int(rand(10000));
my $y = 1 + int(rand(10000));

print $x*$y % 2 == 0 ? "Even" : "Odd";
