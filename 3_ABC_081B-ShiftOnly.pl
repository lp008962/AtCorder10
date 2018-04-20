#!/usr/bin/env perl
use strict;
use warnings;

my $N  = $ARGV[0] ? shift @ARGV : 1 + int( rand(10) );

# 問題作成
my $nums = [];
if (@ARGV) { $nums = [@ARGV] } else { &gen };
sub gen { push(@{$nums}, &Ai()) for 1..$N }
# 普通の乱数だとほとんど回数0になってしまうので、2のべき乗にしている
sub Ai() { return 2 ** int( rand(32) ); }

# 問題の中身確認
foreach (@{$nums}) { print "$_ "; }

# すぬけ君の操作回数
my $sunuke_count=0;
&sunuke;

sub sunuke() {
    my $i=0; # 配列の添字
    foreach my $num (@{$nums}) {
        return if $num%2==1;  # 奇数があればbreak
        $nums->[$i] = $num/2; # 2で割る
        $i++; 
    } 
    $sunuke_count++; # breakしなければ回数++し、
    &sunuke();       # breakするまでワンモア
}

print "\nsunuke=$sunuke_count";

#printf("N=%d, sunuke=%d", $N, $sunuke_count);
