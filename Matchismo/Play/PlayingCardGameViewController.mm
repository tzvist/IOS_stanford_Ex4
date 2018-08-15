// Created by Tzvi Straus.

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (Deck *)creatDeck {
  return [[PlayingCardDeck alloc] init];
}

- (uint)calcCardMatchMode {
  return 2;
}

- (UIView<CardView> *)makeCardViewForCard:(Card *)card {
  assert([card isKindOfClass:[PlayingCard class]]);
  PlayingCard *playCard = (PlayingCard *)card;
  PlayingCardView *playCardView = [[PlayingCardView alloc] initWithFrame:{0, 0, 60, 90}];
  [playCardView setFeturesWithRank:playCard.rank suit:playCard.suit isChosen:playCard.isChosen ];
  return playCardView;
}

@end

NS_ASSUME_NONNULL_END
