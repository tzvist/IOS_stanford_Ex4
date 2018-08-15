// Created by Tzvi Straus.

#import <UIkit/UIkit.h>
#import "cardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView <CardView>

/// \c PlayCards Rank.
@property (nonatomic) NSUInteger rank;

/// \c PlayCards suit.
@property (strong, nonatomic) NSString *suit;

/// Is the card Chosen.
@property (nonatomic) BOOL isChosen;
@end

NS_ASSUME_NONNULL_END
