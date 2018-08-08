// Created by Tzvi Straus.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()

/// Array of cards in the deck.
@property (strong, nonatomic) NSMutableArray<Card *> *cards;

@end

@implementation Deck


- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  };
  return _cards;
}

- (void)addCard:(Card *)card {
  [self.cards addObject:card];
}

- (nullable Card *)drawRandomCard {
  if (!self.cards || self.cards.count == 0) {
    return nil;
  }
  unsigned index = arc4random() % self.cards.count;
  Card *randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  
  return randomCard;
}

@end

NS_ASSUME_NONNULL_END
