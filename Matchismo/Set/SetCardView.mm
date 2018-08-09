// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.80

#pragma mark - Initialization

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}


#pragma mark - Drawing


- (void)drawRect:(CGRect)rect {
  UIBezierPath *margin = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:[self cornerRadius]];
  [margin addClip];
  
 
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGFloat hight = self.bounds.size.height;
  CGFloat diamondHight = hight/12.0;
  CGFloat diamondlenght = self.bounds.size.width * DEFAULT_FACE_CARD_SCALE_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(middle.x , middle.y +diamondHight/2 )];
  [path addLineToPoint:CGPointMake(middle.x + diamondlenght/2 , middle.y )];
  [path addLineToPoint:CGPointMake(middle.x , middle.y - diamondHight/2)];
  [path addLineToPoint:CGPointMake(middle.x - diamondlenght/2 , middle.y )];
  [path closePath];
  
  [path addClip];
  
  
  
  UIBezierPath *line = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(middle.x, 0)];
  [path moveToPoint:CGPointMake(middle.x, self.bounds.size.height)];
  
  


  
  
  

  [[UIColor greenColor] setFill];
  [[UIColor redColor] setStroke];
  [path fill];
  [path stroke];
}

- (void)pushContextAndRotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#define DEFAULT_CORNER_FONT_STANDARD_HEIGHT 180.0
#define DEFAULT_CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / DEFAULT_CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat) cornerRadius {
  return DEFAULT_CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
}

@end

NS_ASSUME_NONNULL_END
