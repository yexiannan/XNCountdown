//
//  CALayer+XNLayer.h
//  Caiyicai
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger ,GradientDirection){//渐变方向
    GradientDirection_LeftToRight,
    GradientDirection_LeftTopToRightBottom,
    GradientDirection_LeftBottomToRightTop,
    GradientDirection_TopToBottom,
};

@interface CALayer (XNLayer)
/**
 绘制渐变色图层 bounds控件大小 colors渐变颜色数组 locations变更颜色位置数组 direction渐变方向
 */
+ (CAGradientLayer *)GradientLayerWithBounds:(CGRect)bounds ColorArray:(NSArray <UIColor *>*)colors LocationArray:(NSArray <NSNumber *>*)locations GradientDirection:(GradientDirection)direction;
@end

NS_ASSUME_NONNULL_END
