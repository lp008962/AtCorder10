#!/usr/bin/env perl
use strict;
use warnings;

# 第4問-Coinsでやっちゃったよ
my $N = $ARGV[0] ? $ARGV[0] : int( rand(2000) + 1 );
my $Y = $ARGV[1] ? $ARGV[1] : int( rand(2*10**4) ) * 1000; 

