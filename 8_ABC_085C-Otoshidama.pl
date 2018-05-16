#!/usr/bin/env perl
use strict;
use warnings;

#【問題概要】
# 10000 円札と、5000 円札と、1000 円札が合計で N 枚あって、合計金額が Y 円であったという。
# このような条件を満たす各金額の札の枚数の組を 1 つ求めなさい。そのような状況が存在し得ない場合には -1 -1 -1 と出力しなさい。
#
#【制約】
#
# 1 <= N <= 2000
# 1000 <= Y <= 2 * 10^7
# N は整数
# Y は 1000 の倍数

my $loop=0;
my $N = $ARGV[0] ? $ARGV[0] : int( rand(2000) + 1);
my $Y = $ARGV[1] ? $ARGV[1] : int( rand(2*10**4)+1) * 1000; 

#print "問題: N=${N}枚 : Y=${Y}円\n";
my @result;
if ( &isCanResolve($N, $Y) ) {
    @result = &getBillCombinations($N, $Y);
} else {
    print "(-1 -1 -1)";
    exit;
}

END:
#return @result;
exit;

#printf("Loop: %d times\n", $loop);

sub isCanResolve {
    my $N = shift;
    my $Y = shift;

    if ( $Y > 10000*$N ) { 
        return 0; # Shortage
    } elsif ( $Y <  1000*$N ) {
        return 0; # Too much
    } else {
        return 1;
    }
}

sub getBillCombinations {
    my $N = shift;
    my $Y = shift;

    my ($yukichi, $int_y) = (10000, 0); # 一万円とその枚数
    my ($higuchi, $int_h) = ( 5000, 0); # 五(ry
    my ($noguchi, $int_n) = ( 1000, 0); # 千(ry
   
    # 近似値をざっくり出す
    my $max_y = int($Y / $yukichi);
    # 超過分をざっくり引く
    $max_y = $max_y - int( ($noguchi*($N-$max_y)) / $yukichi );

    # 近似値から本当の諭吉最大枚数を計算
    for (my $i = $max_y; $i>0; $i--) {
        $loop++;
        # 金額オーバーしなくなるまで
        if( $Y >= $yukichi*$i + $noguchi*($N-$i) ) {
            $int_y = $i;
            last;
        }
    }
    
    for (my $y = $int_y; $y>0; $y--) {
        for (my $h=0; $h<=$N-$y;$h++) {
            $loop++;
            my $n = $N-$y-$h;
            # 金額オーバー以降はインクリメント中止
            last if $Y < $yukichi*$y + $higuchi*$h + $noguchi*$n;

            if ($yukichi*$y + $higuchi*$h + $noguchi*$n == $Y) {
                printf("(%d, %d, %d)", $y,$h, $n);

                # 本当は配列を返せって問題ではなかろうか
                #return ($y,$h, $n);
                goto END;
            }
        }
        
    }

    # 組み合わせがなかった
    print "(-1 -1 -1)\n";
}
    

