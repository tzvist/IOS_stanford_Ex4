// Created by Tzvi Straus.

#import <UIkit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView

/// \c PlayCards Rank.
@property (nonatomic) NSUInteger rank;

/// \c PlayCards suit.
@property (strong, nonatomic) NSString *suit;

/// Is the card facing up.
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
