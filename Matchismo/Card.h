// Created by Tzvi Straus.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object represents a card.
@interface Card <NSCopying>: NSObject

/// Card is chosen.
@property (nonatomic, getter=isChosen) BOOL chosen;

/// Card participates in a match.
@property (nonatomic, getter=isMatched) BOOL matched;

/// Returns score of matching self with a list of \c otherCards.
- (int)match:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
