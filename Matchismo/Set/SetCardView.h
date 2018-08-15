// Created by Tzvi Straus.

#import <UIkit/UIkit.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// View for Set card.
@interface SetCardView : UIView <CardView>

/// set faetures of thew \c SetCardView.
- (void)setFeturesWithNumber:(NSUInteger)number
                      symbol:(NSUInteger)symbol
                     shading:(NSUInteger)shading
                       color:(NSUInteger)color
                    isChosen:(BOOL)isChosen;

/// Is the card Chosen.
@property (nonatomic) BOOL isChosen;

@end

NS_ASSUME_NONNULL_END
