// Created by Tzvi Straus.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object represents a playing card.
@interface SetCard : Card

- (instancetype)init NS_UNAVAILABLE;

/// Initializes a new Set Card with properties.
- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(NSUInteger)symbol
                       shading:(NSUInteger)shading
                         color:(NSUInteger)color
                         NS_DESIGNATED_INITIALIZER;

/// Number of options for each characteristics.
+ (NSUInteger)OptionsCount;

/// SetCard number.
@property (nonatomic, readonly) NSUInteger number;

/// SetCard symbol.
@property (nonatomic, readonly) NSUInteger symbol;

/// SetCard shading.
@property (nonatomic, readonly) NSUInteger shading;

/// SetCard color.
@property (nonatomic, readonly) NSUInteger color;

@end

NS_ASSUME_NONNULL_END
