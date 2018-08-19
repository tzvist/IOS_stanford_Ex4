// Created by Tzvi Straus.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()

/// \c SetCardView number.
@property (nonatomic) NSUInteger number;

/// \c SetCardView symbol.
@property (nonatomic) NSUInteger symbol;

/// \c SetCardView shading.
@property (nonatomic) NSUInteger shading;

/// \c SetCardView color.
@property (nonatomic) NSUInteger color;

@end

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

- (void)setFeturesWithNumber:(NSUInteger)number
                      symbol:(NSUInteger)symbol
                     shading:(NSUInteger)shading
                       color:(NSUInteger)color
                    isChosen:(BOOL)isChosen {
  self.number = number;
  self.symbol = symbol;
  self.shading = shading;
  self.color = color;
  self.isChosen = isChosen;
}

- (void)setIsChosen:(BOOL)isChosen {
  if (_isChosen == isChosen){
    return;
  }
  
  _isChosen = isChosen;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  [self saveContext];
  [self makeMargin];
  
  CGFloat symbolHight = self.bounds.size.height * DEFAULT_FACE_CARD_SCALE_FACTOR /3.3;
  CGFloat middleX =self.bounds.size.width/2;
  CGFloat middleY =self.bounds.size.height/2;
  
  if (0 == self.number || 2 == self.number) {
    [self drawSimbol:CGPointMake(middleX, middleY)];
  }
  
  if (1 == self.number || 2 == self.number) {
    [self drawSimbol:CGPointMake(middleX, middleY + symbolHight )];
    [self drawSimbol:CGPointMake(middleX, middleY - symbolHight )];
  }
  [self popContext];
}

#define SQUIGGLE_WIDTH 0.13
#define SQUIGGLE_HEIGHT 0.21
#define SQUIGGLE_FACTOR 1.0

- (UIBezierPath *)squiggleAtPointPath:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR ;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR ;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
          controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
          controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
               controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
          controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
          controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
  
  CGAffineTransform translat  = CGAffineTransformMakeTranslation( - point.x,  - point.y);
  CGAffineTransform rotation =  CGAffineTransformMakeRotation( M_PI * 0.5 );
  CGAffineTransform counter_translat = CGAffineTransformInvert(translat);
  CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformConcat(translat, rotation), counter_translat);
  [path applyTransform:transform];
  
  return path;
}

- (UIBezierPath *)diamondPath:(const CGPoint &)center {
  CGFloat diamondHight = self.bounds.size.height/12.0;
  CGFloat diamondLenght = self.bounds.size.width * DEFAULT_FACE_CARD_SCALE_FACTOR;
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(center.x , center.y +diamondHight/2 )];
  [path addLineToPoint:CGPointMake(center.x + diamondLenght/2 , center.y )];
  [path addLineToPoint:CGPointMake(center.x , center.y - diamondHight/2)];
  [path addLineToPoint:CGPointMake(center.x - diamondLenght/2 , center.y )];
  [path closePath];
  return path;
}

- (UIBezierPath *)ovalPath:(const CGPoint &)center {
  CGFloat ovalHight = self.bounds.size.height/12.0;
  CGFloat ovalLenght = self.bounds.size.width * DEFAULT_FACE_CARD_SCALE_FACTOR;
  return [UIBezierPath bezierPathWithOvalInRect: CGRectMake (center.x - ovalLenght/2, center.y - ovalHight/2, ovalLenght, ovalHight)];
}

- (void)makeMargin {
  UIBezierPath *margin = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:[self cornerRadius]];
  [margin addClip];
  if (self.isChosen){
    [[UIColor grayColor] setFill];
  } else {
    [[UIColor whiteColor] setFill];
  }
  UIRectFill(self.bounds);
}

- (void)shadeSolid:(UIBezierPath *)simbolPath {
  [self saveContext];
  [[self getMyColor] setFill];
  [simbolPath fill];
  [self popContext];
}

- (UIBezierPath *)symbolPath:(const CGPoint)center {
  switch (self.symbol) {
    case 0:
      return [self squiggleAtPointPath:center];
    case 1:
      return [self diamondPath:center];
    case 2:
      return [self ovalPath:center];
  }
  assert(FALSE);
}

- (void)drawSyimbol:(UIBezierPath *)mySimbol {
  [self saveContext];
  [[self getMyColor] setStroke];
  [mySimbol stroke];
  [self popContext];
}

- (void)drawShading:(UIBezierPath *)mySimbol {
  if (1 == self.shading) {
    [self shadeStrips:mySimbol];
  } else if (2 == self.shading) {
    [self shadeSolid:mySimbol];
  }
}

- (void)drawSimbol:(const CGPoint)center {
  UIBezierPath *symbolPath = [self symbolPath:center];
  [self drawSyimbol:symbolPath];
  [self drawShading:symbolPath];
}

- (UIColor *)getMyColor {
  return [self validColors][self.color];
}

- (NSArray<UIColor *>*)validColors {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}
- (void)shadeStrips:(UIBezierPath *)path {
  CGRect bounds = path.bounds;
  
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  for ( int x = 0; x < bounds.size.width; x += self.bounds.size.width/30 ) {
    [stripes moveToPoint:CGPointMake(bounds.origin.x + x, bounds.origin.y)];
    [stripes addLineToPoint:CGPointMake(bounds.origin.x + x, bounds.origin.y + bounds.size.height)];
  }
  [stripes setLineWidth:0.4];
  
  [self saveContext];
  [path addClip];
  [[self getMyColor] setStroke];
  [stripes stroke];
  [self popContext];
}

- (void)saveContext {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
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

#pragma mark - other

-(id) copyWithZone:(nullable NSZone *)zone {
  return self;
}

@end

NS_ASSUME_NONNULL_END
