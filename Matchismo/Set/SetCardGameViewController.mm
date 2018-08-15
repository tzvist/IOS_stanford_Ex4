// Created by Tzvi Straus.

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "Grid.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardGameViewController

- (Deck *)creatDeck {
  return [[SetCardDeck alloc] init];
}

- (uint)calcCardMatchMode {
  return 3;
}

- (IBAction)addThreeCards:(id)sender {
  NSArray<Card *> *cards = [self.game addThreeCards];
  [self addCardViews:cards];
}

- (UIView<CardView> *)makeCardViewForCard:(Card *)card {
  assert([card isKindOfClass:[SetCard class]]);
  SetCard *setCard = (SetCard *)card;
  SetCardView *setCardView = [[SetCardView alloc] initWithFrame:{0, 0, 60, 90}];
  [setCardView setFeturesWithNumber:setCard.number symbol:setCard.symbol shading:setCard.shading color:setCard.color isChosen:setCard.isChosen];
  return setCardView;
}

@end

NS_ASSUME_NONNULL_END
