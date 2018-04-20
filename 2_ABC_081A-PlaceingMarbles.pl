#!/usr/bin/env perl
use strict;
use warnings;

print scalar( my @arr = $ARGV[0] =~ m/1/g ) if $ARGV[0];
