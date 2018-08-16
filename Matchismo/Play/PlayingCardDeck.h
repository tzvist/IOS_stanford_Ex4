// Created by Tzvi Straus.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Object representing Deck of \c PlayingCard.
@interface PlayingCardDeck : Deck

/// initializes with a full deck (52 cards)
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
