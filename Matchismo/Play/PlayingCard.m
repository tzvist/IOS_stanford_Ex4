// Created by Tzvi Straus.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)suit {
  return (_suit) ?  _suit : @"?" ;
}

- (instancetype) initWithSuit:(NSString *)suit andRank:(NSUInteger)rank {
  assert(rank <= [PlayingCard maxRank]);
  assert([[PlayingCard validSuits] containsObject:suit]);
  if (self = [super init]) {
    _suit = suit;
    _rank = rank;
  }
  return self;
}

- (NSString *)contents {
  return [[PlayingCard rankStrings][ self.rank] stringByAppendingString: self.suit];
}

- (int)matchCard:(PlayingCard *)otherCard {
  if (otherCard.rank == self.rank) {
    return 4;
  }
  if ([otherCard.suit isEqualToString:self.suit]) {
    return 1;
  }
  return 0;
}

- (int)match:(NSArray *)otherCards {
  int score = 0;
  for (PlayingCard * otherCard in otherCards) {
    if(otherCard != self ) {
      score += [self matchCard:otherCard];
    }
  }
  return score;
}

+ (NSInteger)maxRank {
  return ([PlayingCard rankStrings].count-1);
}

+ (NSArray *)validSuits {
  return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
  return @[@"?",@"A",@"2",@"3",
           @"4",@"5",@"6",@"7",
           @"8",@"9",@"10",@"J",
           @"Q",@"K"];
}

@end

NS_ASSUME_NONNULL_END
