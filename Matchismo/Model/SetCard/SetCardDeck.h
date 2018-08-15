// Created by Tzvi Straus.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Object representing Deck of \c SetCard.
@interface SetCardDeck : Deck

/// initializes with a full Set deck (3^4 = 81 cards)
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
