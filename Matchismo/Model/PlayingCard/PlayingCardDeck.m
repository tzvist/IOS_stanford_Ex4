// Created by Tzvi Straus.

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard *newCard = [[PlayingCard alloc]
                                initWithSuit:suit andRank:rank];
        [self addCard:newCard];
      }
    }
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
