// Created by Tzvi Straus.

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "Grid.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()


@property (strong, nonatomic) Grid *grid;


@end

@implementation SetCardGameViewController


- (instancetype)init {
  if (self = [super init]) {
////    self.cardView.number = 2;
////    self.cardView.shading = 1;
////    self.cardView.color = 0;
////    self.cardView.symbol = 1;
//    self.grid = [[Grid alloc] init];
//    self.grid.cellAspectRatio = 2.0/3.0;
//    //self.grid.
  }
  return self;
}

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
