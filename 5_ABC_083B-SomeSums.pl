#!/usr/bin/env perl
use strict;
use warnings;

my $res=0;
my ($N, $A, $B) = scalar(@ARGV) >=3 ? @ARGV : &generate_args;

sub generate_args {
    my $N = int( rand(10**4) + 1 );
    my $x = int( rand(36) +1 );
    my $y = int( rand(36) +1 );
    if ($x > $y) {
        &generate_args;
    } else {
        return ($N, $x, $y);
    }
}
print "$res\n" if $N<2;       # 1<=A<=Bなので、2以上でないと成り立たない
print "$res\n" if $N<=$B;     # Nが引数A,Bより大きくないと成り立たない

## main
#my @nums;
foreach my $i ( 1..$N ) {
    # 各桁の和が適正範囲内か
    if ( &isAvailableRange(&sum_somes( $i )) ) {
        $res += $i;
        #push(@nums, $i);
    }
}

printf("N=%d, A=%d, B=%d : Result=%d\n",$N, $A, $B, $res);
#print "$_\n" foreach @nums;

# 各桁の和
# 数値を文字列として各桁splitできるが、今回あくまで数値型として扱う
sub sum_somes {
    my $n = shift;
    my $sum=0;

    while($n>0) {
        $sum += $n % 10;
        $n    = int($n/10);
    }
    return $sum;
}
# 適正範囲内か
sub isAvailableRange {
    my $n = shift;

    if ($n >= $A && $n <= $B ) {
        return 1;
    } else {
        return 0;
    }
}

