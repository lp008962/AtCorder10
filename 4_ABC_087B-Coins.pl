#!/usr/bin/env perl
use strict;
use warnings;
use Benchmark qw/cmpthese/;


my $target = int(rand(400)+1)*50; # 50 < N < 20000
#my $target = 500;
my ($A, $B, $C) = &get_coins;

printf("Target=%d: 500=%d, 100=%d, 50=%d\n", $target, $A, $B, $C);

my $res=0;
my $total_calculations=0; # その時々で計算した時にカウントする
my $loop_times=0;
my $str_res;

cmpthese( 1000, {
 "BruteForce" => sub { &BruteForceSearch() },
 "Optimized"  => sub { &OptimizedCalc()    },
});



#printf("There is %d match patterns\n",  $res);
#printf("Loop: %d times\n", $loop_times);
#printf("Calculation: %d times\n",  $total_calculations);
#print $str_res;


sub get_coin () { return int(rand(51)) * 1; } # coin数をどーんと増やしたい時にいじる
sub get_coins() {
    my ($A, $B, $C) = (&get_coin, &get_coin, &get_coin);
    if ( $A+$B+$C > 0 ) {
        return ($A, $B, $C);
    } else {
        print "A+B+C was 0! Regenerate!\n";
        &get_coins;
    }
}

sub get_upper_limit() {
    my $x = shift;
    my $n = shift;
    
    my $max = $x/$n;
    $total_calculations++;

    return int($max);
}

sub BruteForceSearch() {
    for (my $a=0; $a<=$A; $a++) {
        for (my $b=0; $b<=$B; $b++) {
            for (my $c=0; $c<=$C; $c++) {
                $loop_times++;
                if (500*$a+100*$b+50*$c == $target) {
                    $res++;
                    #$str_res .= sprintf("Hit!:500=%d, 100=%d, 50=%d\n", $a, $b, $c);
                }
            }
        }
    }
}

sub OptimizedCalc() {
    my $max_A = &get_upper_limit($target, 500);
    my $max_B;
    my $needs_C;
    # 最大値を超えるものは切り捨てる
    $A = $max_A < $A ? $max_A : $A; $total_calculations++;

    # そもそも全部足しても足りなければ終了
    if (500*$A+100*$B+50*$C < $target) { print "Muri☆"; exit; };

    # 500円最大数＝全体の最小枚数からデクリメント
    for (my $a=$A; $a>=0; $a--) {
        # 500円がa枚のとき、100円の取り得る最大数
        my $max_B = &get_upper_limit($target-500*$a, 100);
        $max_B = $max_B < $B ? $max_B : $B; $total_calculations++;

        for (my $b=$max_B; $b>=0; $b--) {
            $loop_times++;
           # 500円と100円(中略)50円の必要量。
            $needs_C = &get_upper_limit($target-(500*$a+100*$b), 50);
           
            $total_calculations++; # ↓の判定をカウント
            # 必要量に満たない場合は終了
            if ($needs_C > $C) { last; }
            $res++; 
            #$str_res .= sprintf("Match! 500=%-3d 100=%-3d 50=%-3d\n", $a, $b, $needs_C);
        }
        
    }
}


