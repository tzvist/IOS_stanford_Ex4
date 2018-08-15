// Created by Tzvi Straus.

#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Object represents a card matching game.
@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes Deck with the given parameters.
///
/// @param cardCount num of cards in the game.
/// @param deck used to draw  random cards.
/// @param numMode the amount of cards in a match.
- (instancetype)initWithCardCount:(NSUInteger)cardCount
                        usingDeck:(Deck *)deck
                 numCardMatchMode:(uint)numMode
                 NS_DESIGNATED_INITIALIZER;

/// Represents choosing a \c card, in the game.
/// If a match is found Returns the matching cards else returns nil.
- (nullable NSArray<Card *> *)chooseCard:(Card *)card;

/// Returns card at \c index.
- (Card *)cardAtIndex:(NSUInteger) index;

/// number of \c Cards in game.
- (NSUInteger)cardsCount;

/// Adds \c 3 \c Cards to the game;
- (NSArray<Card *> *)addThreeCards;

/// return list of cards used in the ggame.
- (NSArray<Card *> *)getCards;

/// Represents current \c score.
@property (nonatomic, readonly) NSInteger score;

/// Represents number of cards to be matched in the game.
@property (nonatomic) uint numCardMatchMode;

/// Text description of the last result.
@property (nonatomic, readonly) NSString *lastResultDescription;

@end

NS_ASSUME_NONNULL_END
