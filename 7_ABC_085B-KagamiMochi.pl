#!/usr/bin/env perl
use strict;
use warnings;

#【問題概要】
# N 個の整数 d[0],d[1],…,d[N−1]d[0],d[1],…,d[N−1] が与えられます。
# この中に何種類の異なる値があるでしょうか？
# (原問題文をかなり意訳していますが、題意はこういうことです)#
#  ↑↑↑
# 入力例にはQってあるけど問題文にないのでスルー
my $N = $ARGV[0] ? shift @ARGV : 1 + int(rand(100));
my @d = $ARGV[0] ? @ARGV : &gen;
sub gen { my @buf; push( @buf, 1 + int(rand(100)) ) for 1..$N; return @buf; }

### main
my %hash;
foreach(@d) { 
    next if $hash{$_};
    $hash{$_}++; # 出現回数を知りたい場合。不要なら0でもいれとく
}
my $i = keys(%hash);
print $i;

