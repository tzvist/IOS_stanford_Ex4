//  Created by Tzvi Straus.

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

/// Score lable.
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

/// View that holdes all the card views.
@property (weak, nonatomic) IBOutlet UIView *cardHolder;

/// Map card model to card view.
@property (strong, nonatomic) NSMutableDictionary<Card *, UIView<CardView> *> *cardToView;

/// Map card view to card model.
@property (strong, nonatomic) NSMutableDictionary<UIView<CardView> *, Card *> *viewToCard;

@end

@implementation CardGameViewController

- (void)setup {
  _game = [self createNewGame];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (void)viewDidLoad {
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter]
   addObserver:self selector:@selector(updateCardsLocation)
   name:UIDeviceOrientationDidChangeNotification
   object:[UIDevice currentDevice]];
}

- (void)viewWillAppear:(BOOL)animated {
  [self updateAllCardViews];
}

- (void)updateAllCardViews {
  [self removeAllCardViews];
  [self resetData];
  [self addCardViews:[self.game getCards]];
}

- (void)resetData {
  _cardToView = [[NSMutableDictionary alloc] init];
  _viewToCard = [[NSMutableDictionary alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self resetData];
  [self removeAllCardViews];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeAllCardViews {
  [self.cardHolder.subviews
   enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     [obj removeFromSuperview];
   }];
}

- (IBAction)redeal {
  [self setup];
  [self updateAllCardViews];
}

- (uint)calcCardMatchMode { // abstract method
  assert(NO);
}

- (Deck *)creatDeck { // abstract method
  assert(NO);
}

- (UIView<CardView> *)makeCardViewForCard:(Card *)card { // abstract method
  assert(NO);
}

- (CardMatchingGame *)createNewGame {
  Deck *deck = [self creatDeck];
  NSUInteger cardCount = 13;
  uint numCardMatchMode = [self calcCardMatchMode];
  
  return [[CardMatchingGame alloc] initWithCardCount:cardCount usingDeck:deck numCardMatchMode:numCardMatchMode];
}

- (void)touchCardButton:(UITapGestureRecognizer *)gestureRecognizer {
  UIView<CardView> *touchedCardView = (UIView<CardView> *)gestureRecognizer.view;
  Card *touchedCard = self.viewToCard[touchedCardView];
  NSArray<Card *> *matchingCards = [self.game chooseCard:touchedCard];
  
  
  [self.cardToView enumerateKeysAndObjectsUsingBlock:^(Card * _Nonnull key, UIView<CardView> * _Nonnull obj, BOOL * _Nonnull stop) {
    obj.isChosen = key.isChosen;
  }];
  
  for (Card *matched in matchingCards) {
    UIView<CardView> *matchedView = self.cardToView[matched];
    [UIView animateWithDuration:3.0 delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ matchedView.alpha = 0.0; }
                     completion:^(BOOL fin) { if (fin) [matchedView removeFromSuperview]; }];
    [self.cardToView removeObjectForKey:matched];
    [self.viewToCard removeObjectForKey:matchedView];
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (void)addCardViews:(NSArray *)cards {
  for (Card *card in cards) {
    UIView<CardView> *cardView = [self makeCardViewForCard:card];
    [self.cardToView setObject:cardView forKey:card];
    [self.viewToCard setObject:card forKey:cardView];
    [self.cardHolder addSubview:cardView];
    cardView.opaque = YES;
    [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:) ]];
  }
  [self updateCardsLocation];
}

- (void)updateCardsLocation {
  Grid *grid = [[Grid alloc] init];
  grid.size = self.cardHolder.frame.size;
  grid.minimumNumberOfCells = self.cardHolder.subviews.count;
  grid.cellAspectRatio = 2.0/3.0;
  NSUInteger row = 0, column = 0;
  for (UIView *cardView in self.cardHolder.subviews) {
    CGRect currFram = [grid frameOfCellAtRow:row inColumn:column];
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ [cardView setFrame:currFram]; }
                     completion:nil];
    column++;
    if ([grid columnCount] == column){
      column = 0;
      row++;
    }
  }
}


@end

NS_ASSUME_NONNULL_END
