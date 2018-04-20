#!/usr/bin/env perl
use strict;
use warnings;

# N枚のカードがあります(1 <= N <= 100)
my $N = @ARGV ? shift @ARGV : 1 + int(rand(100));
my @cards = @ARGV ? @ARGV : &get_cards;
print "N=$N\n";

sub get_cards {
    my @buf;
    for (1..$N) { push(@buf, 1+int(rand(100))); }
    return @buf;
}
print "Cards: ";
print "$_ " foreach @cards;
print "\n";

@cards = sort { $a <=> $b } @cards;

# alice,bobは人、$alice++は不自然、その結果↓
my $alice = &Player::new();
my $bob   = &Player::new();

my $turn = 1;
while( scalar(@cards) > 0 ) {
    if ( $turn % 2 == 1 ) {
        $alice->draw(\@cards);
    } else {
        $bob->draw(\@cards);
    }

    $turn++;
    die "Infinite Loop!?" if $turn > $N+1;
}

printf("Alice : %d\n", $alice->score);
printf("Bob   : %d\n", $bob->score);
printf("SCORE : %d\n", $alice->score - $bob->score);


{
  package Player;

  sub new() {
     return bless { score => 0 };
  }

  sub score() {
      my $self = shift;
      return $self->{score};
  }

  sub draw() {
      my $self  = shift;
      my $cards = shift;  # ArrayRef for closure

      $self->{score} += pop(@{$cards});
  }

}

