// Created by Tzvi Straus.

#import <UIkit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

/// \c SetCardView number.
@property (nonatomic) NSUInteger number;

/// \c SetCardView symbol.
@property (nonatomic) NSUInteger symbol;

/// \c SetCardView shading.
@property (nonatomic) NSUInteger shading;

/// \c SetCardView color.
@property (nonatomic) NSUInteger color;

@end

NS_ASSUME_NONNULL_END
