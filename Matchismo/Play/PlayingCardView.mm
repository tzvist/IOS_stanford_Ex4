// Created by Tzvi Straus.

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView()

/// \c PlayCards Rank.
@property (nonatomic) NSUInteger rank;

/// \c PlayCards suit.
@property (strong, nonatomic) NSString *suit;

@end

@implementation PlayingCardView

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

#pragma mark - Properties

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
  [self setNeedsDisplay];
}

- (void)setIsChosen:(BOOL)isChosen {
  _isChosen = isChosen;
  [self setNeedsDisplay];
}

- (NSString *)rankAsString {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  UIBezierPath *margin = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                            cornerRadius:[self cornerRadius]];
  [margin addClip];
  
  if (!self.isChosen) {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    return;
  }
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [self drawCorners];
  
  UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
  if (faceImage) {
    CGFloat scaleFactor = 1.0 - DEFAULT_FACE_CARD_SCALE_FACTOR;
    CGRect imageRect = CGRectInset(self.bounds,
                                self.bounds.size.width * scaleFactor,
                                self.bounds.size.height * scaleFactor);
    [faceImage drawInRect:imageRect];
    return;
  } else {
    [self drawPips];
  }
}

- (void)drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
  NSDictionary<NSAttributedStringKey,id> *attributes = @{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle };
  
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:attributes];
  
  CGRect textBounds;
  
  textBounds.origin = CGPointMake( [self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  
  [cornerText drawInRect:textBounds];
  
  [self pushContextAndRotateUpsideDown];
  [cornerText drawInRect:textBounds];
  [self popContext];
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

- (void)pushContextAndRotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270


- (void)drawPips {
  if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:PIP_VOFFSET2_PERCENTAGE
                    mirroredVertically:(self.rank != 7)];
  }
  if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET3_PERCENTAGE
                    mirroredVertically:YES];
  }
  if ((self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET1_PERCENTAGE
                    mirroredVertically:YES];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.012
#define ALMOST_ZERO 0.00000001
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset {
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont }];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                               middle.y-pipSize.height/2.0-voffset*self.bounds.size.height  );
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset * hoffset > ALMOST_ZERO) {
    pipOrigin.x = middle.x-pipSize.width/2.0+hoffset*self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically {
  [self drawPipsWithHorizontalOffset:hoffset
                      verticalOffset:voffset];
  if (mirroredVertically) {
    [self pushContextAndRotateUpsideDown];
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset];
    [self popContext];
  }
}

#pragma mark - other
-(id) copyWithZone:(NSZone *)zone {
  return self;
}

- (void)setFeturesWithRank:(NSUInteger)rank suit:(NSString *)suit
                  isChosen:(BOOL)isChosen{
  self.rank = rank;
  self.suit = suit;
  self.isChosen = isChosen;
}

@end

NS_ASSUME_NONNULL_END
