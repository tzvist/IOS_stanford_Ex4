// Created by Tzvi Straus.

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object represents a deck of \c Card.
@interface Deck : NSObject

/// Adds a \c Card to the end of the deck.
- (void)addCard:(Card *)card;

/// Returns (and pops) a random card from the deck.
- (nullable Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END

