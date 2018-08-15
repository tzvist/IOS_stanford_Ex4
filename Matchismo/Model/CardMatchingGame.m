// Created by Tzvi Straus.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

/// Represents current \c score.
@property (nonatomic, readwrite) NSInteger score;

/// List of cards to match.
@property (nonatomic, strong) NSMutableArray<Card *> *cards;

/// Queue conating currently chosen cards.
@property (nonatomic, strong) NSMutableArray<Card *> *chosenCardsQueue;

@property (nonatomic, strong, readwrite) NSString *lastResultDescription;

// A deck used draw cards from.
@property (nonatomic, strong) Deck *deck;

@end

@implementation CardMatchingGame

- (NSArray<Card *> *)addCards:(NSUInteger)cardCount {
  NSMutableArray<Card *> *newCards = [[NSMutableArray alloc] init];
  for (; 0 < cardCount; cardCount--) {
    Card *card = [self.deck drawRandomCard];
    if(card) {
      [self.cards addObject:card];
      [newCards addObject:card];
    }
  }
  return newCards;
}

- (NSArray<Card *> *)addThreeCards {
  return [self addCards:3];
}

- (instancetype)initWithCardCount:(NSUInteger)cardCount
                 usingDeck:(Deck *)deck
                 numCardMatchMode:(uint)numMode {
  assert(numMode >= 2);
  //assert(numMode <= cardCount);
  
  if (self = [super init]) {
    _deck = deck;
    self.numCardMatchMode = numMode;
    [self addCards:cardCount];
  }
  return self;
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)chosenCardsQueue {
  if (!_chosenCardsQueue) {
    _chosenCardsQueue = [[NSMutableArray alloc] init];
  }
  return _chosenCardsQueue;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  if (index >= [self.cards count]) {
    return nil;
  }
  return self.cards[index];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)popChosenCardsQueue {
  assert([self.chosenCardsQueue count] > 0);
  Card *unchoose = self.chosenCardsQueue[0];
  unchoose.chosen = NO;
  [self.chosenCardsQueue removeObjectAtIndex:0];
}

- (void)calcScoreMismatch {
  self.score -= MISMATCH_PENALTY;
  self.lastResultDescription = [[NSString alloc]
                                initWithFormat:
                                @"don't match! %d points penalty!",
                                MISMATCH_PENALTY];
}

- (void)calcScoreWithMatchScore:(uint)matchScore {
  uint addToScore = matchScore*MATCH_BONUS;
  self.score += addToScore;
  self.lastResultDescription = [[NSString alloc]
                                initWithFormat:
                                @"matched for %d points.",
                                addToScore ];
  
  for (Card * otherCard in self.chosenCardsQueue){
    otherCard.matched = YES;
  }
}

- (void)calScore:(uint)matchScore matchCount:(uint)matchCount {
  if (matchCount == 0) {
    [self calcScoreMismatch];
  } else {
    [self calcScoreWithMatchScore:matchScore];
  }
}

- (void)tryToMatch {
  uint matchCount = 0;
  uint matchScoreSum = 0;
  for (Card *card in [self.chosenCardsQueue reverseObjectEnumerator]) {
    assert(!card.isMatched);
    assert(card.isChosen);
    NSInteger matchScore = [card match:self.chosenCardsQueue];
    if (matchScore) {
      matchScoreSum += matchScore;
      matchCount += 1;
      card.matched = YES;
      [self.chosenCardsQueue removeObject:card];
    }
  }
  [self calScore:matchScoreSum matchCount:matchCount];
}

- (NSArray<Card *> *)chooseNewCard:(Card *)card {
  assert(![self.chosenCardsQueue containsObject:card]);
  self.score -= COST_TO_CHOOSE;
  card.chosen = YES;
  [self.chosenCardsQueue addObject:card];
  NSArray<Card *> *res = [self.chosenCardsQueue copy];
  
  if ([self.chosenCardsQueue count] < self.numCardMatchMode) {
    return nil;
  }
  
  [self tryToMatch];
  
  if ([self.chosenCardsQueue count] == self.numCardMatchMode) {
    [self popChosenCardsQueue];
    res = nil;
  } else {
    [self.cards removeObjectsInArray:res];
    [self.chosenCardsQueue removeAllObjects];
  }
  return res;
}

- (NSArray<Card *> *)unChooseCard:(Card *)card {
  card.chosen = NO;
  [self.chosenCardsQueue removeObject:card];
  return [self.chosenCardsQueue copy] ;
}

- (nullable NSArray<Card *> *)chooseCard:(Card *)card{
  assert(card);
  assert(!card.isMatched);
  assert([self.cards indexOfObject:card] != NSNotFound);
  self.lastResultDescription = @"";
  
  if (card.isChosen) {
    card.chosen = NO;
    [self.chosenCardsQueue removeObject:card];
    return nil;
  }
  return [self chooseNewCard:card];
}

- (NSUInteger)cardsCount {
  return self.cards.count;
}

- (NSArray<Card *> *)getCards {
  return self.cards;
}

@end

NS_ASSUME_NONNULL_END

