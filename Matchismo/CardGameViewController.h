// Created by Tzvi Straus.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"
#import "CardView.h"

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


//--------------

/// protected
- (void)addCardViews:(NSArray *)cards;

- (UIView<CardView> *)makeCardViewForCard:(Card *)card;

/// protected
- (void)updateAllCardViews;

/// protected Models \c game.
@property (strong, nonatomic) CardMatchingGame *game;



@end

NS_ASSUME_NONNULL_END
