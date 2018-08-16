// Created by Tzvi Straus.

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object represents a playing card.
@interface PlayingCard : Card

- (instancetype)init NS_UNAVAILABLE;

/// Initializes a new Playing Card with suit and rank.
- (instancetype)initWithSuit:(NSString *)suit andRank:(NSUInteger)rank NS_DESIGNATED_INITIALIZER;

/// Card contents.
@property (strong, nonatomic) NSString *contents;

/// Returns all valid suits for a \c PlayingCard object.
+ (NSArray *)validSuits;

/// Returns the max valid rank of a \c PlayingCard object.
+ (NSInteger)maxRank;

/// PlayingCard suit.
@property (nonatomic, readonly) NSString *suit;

/// PlayingCard rank.
@property (nonatomic, readonly) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END
