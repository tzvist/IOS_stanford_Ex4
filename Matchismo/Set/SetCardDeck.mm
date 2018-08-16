// Created by Tzvi Straus.

#import "SetCardDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSUInteger number = 0;
         number < [SetCard OptionsCount]; number++) {
      for (NSUInteger symbol = 0;
           symbol < [SetCard OptionsCount]; symbol++ ) {
        for (NSUInteger shading = 0;
             shading < [SetCard OptionsCount]; shading++ ) {
          for (NSUInteger color = 0;
               color < [SetCard OptionsCount]; color++ ) {
            Card * newCard = [[SetCard alloc] initWithNumber:number
                                                      symbol:symbol
                                                     shading:shading
                                                       color:color];
            [self addCard:newCard];
          }
        }
      }
    }
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
