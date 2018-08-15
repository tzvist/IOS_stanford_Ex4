// Created by Tzvi Straus.

#import <UIkit/UIkit.h>
#import "cardView.h"

NS_ASSUME_NONNULL_BEGIN

/// View for Playing card.
@interface PlayingCardView : UIView <CardView>

/// Seter for view Card properties.
- (void)setFeturesWithRank:(NSUInteger)rank suit:(NSString *)suit
isChosen:(BOOL)isChosen;

/// Is the card Chosen.
@property (nonatomic) BOOL isChosen;

@end

NS_ASSUME_NONNULL_END
