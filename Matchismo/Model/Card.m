// Created by Tzvi Straus.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card

- (int)match:(NSArray *) otherCards {
  return 0;
}

-(id) copyWithZone: (NSZone*) zone {
  return self;
}

@end

NS_ASSUME_NONNULL_END
