//  Created by Tzvi Straus.

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lastResultDescription;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

/// Models \c game
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSAttributedString *resultDescriptions;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [self createNewGame];
  }
  return _game;
}

- (uint)calcCardMatchMode { // abstract method
  assert(NO);
}

- (Deck *)creatDeck { // abstract method
  assert(NO);
}

- (void)updateButton:(UIButton *)cardButton withCard:(Card*)card { // abstract method
  assert(NO);
}

- (NSAttributedString *)cardConnten:(Card *)card {// abstract method
  assert(NO);
}

- (void)viewWillAppear:(BOOL)animated {
  if(!self.resultDescriptions) {
    self.resultDescriptions = [[NSAttributedString alloc] init];
  }
  [self updateUI];
}

- (IBAction)changeCardMatchMode {
  self.game.numCardMatchMode = [self calcCardMatchMode];
}

- (CardMatchingGame *)createNewGame {
  Deck *deck = [self creatDeck];
  NSUInteger cardCount = [self.cardBottuns count];
  uint numCardMatchMode = [self calcCardMatchMode];
  
  return [[CardMatchingGame alloc] initWithCardCount:cardCount usingDeck:deck numCardMatchMode:numCardMatchMode];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger cardButtonIndex = [self.cardBottuns  indexOfObject:sender];
  NSArray<Card *> *cards = [self.game chooseCardAtIndex:cardButtonIndex];
  [self updateUI];
  [self updateResultDescription:cards];
}

- (IBAction)redeal {
  _game = nil;
  self.resultDescriptions = [[NSAttributedString alloc] init];
  [self updateUI];
}

- (void) updateUI {
  for (NSUInteger cardButtonIndex = 0; cardButtonIndex < self.cardBottuns.count; cardButtonIndex++) {
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    UIButton *cardButton = self.cardBottuns[cardButtonIndex];
    [self updateButton:cardButton withCard:card];
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastResultDescription.text = @"";
}

- (void)updateResultDescription:(NSArray<Card *> *)cards {
  NSMutableAttributedString *description = [self cardsConntens:cards];
  self.lastResultDescription.text = @"";
  if (self.game.lastResultDescription) {
    NSMutableAttributedString *lastResultDescription = [[NSMutableAttributedString alloc] initWithString:self.game.lastResultDescription];
    [description appendAttributedString:lastResultDescription];
    [self.lastResultDescription setAttributedText:description];
    
    NSAttributedString *lineBreak = [[NSAttributedString alloc] initWithString:@"\n"];
    NSMutableAttributedString *newResults = self.resultDescriptions.mutableCopy;
    [newResults appendAttributedString:lineBreak];
    [newResults appendAttributedString:description];
    self.resultDescriptions = newResults;
  }
}

- (NSMutableAttributedString *)cardsConntens:(NSArray<Card *> *)cards {
  NSMutableAttributedString *cardNames = [[NSMutableAttributedString alloc] init];
  for (Card *card in cards) {
    [cardNames appendAttributedString:[self cardConnten:card]];
  }
  return cardNames;
}
@end

NS_ASSUME_NONNULL_END
