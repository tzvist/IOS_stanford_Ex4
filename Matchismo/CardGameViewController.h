// Created by Tzvi Straus.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class for game view controller.
/// must implement below methods.
@interface CardGameViewController : UIViewController

/// protected
- (Deck *)creatDeck;

/// protected
- (uint)calcCardMatchMode;

/// protected
- (void)updateButton:(UIButton *)cardButton withCard:(Card*)card;

/// protected
- (NSAttributedString *)cardConnten:(Card *)card;

@end

NS_ASSUME_NONNULL_END
