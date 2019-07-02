//
//  CALayer+XNLayer.m
//  Caiyicai
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "CALayer+XNLayer.h"

@implementation CALayer (XNLayer)

+ (CAGradientLayer *)GradientLayerWithBounds:(CGRect)bounds ColorArray:(nonnull NSArray<UIColor *> *)colors LocationArray:(nonnull NSArray<NSNumber *> *)locations GradientDirection:(GradientDirection)direction{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cgColors addObject:(__bridge id)obj.CGColor];
    }];
    gradientLayer.colors = cgColors;
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    CGPoint startPoint = CGPointMake(0, 0.5);
    CGPoint endPoint = CGPointMake(1, 0.5);
    
    switch (direction) {
        case GradientDirection_LeftToRight:
            startPoint = CGPointMake(0, 0.5);
            endPoint = CGPointMake(1, 0.5);
            break;
        case GradientDirection_TopToBottom:
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1);
            break;
        case GradientDirection_LeftTopToRightBottom:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(1, 1);
            break;
        case GradientDirection_LeftBottomToRightTop:
            startPoint = CGPointMake(1, 1);
            endPoint = CGPointMake(0, 0);
            break;
            
        default:
            break;
    }
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = locations;
    
    return gradientLayer;
}

@end
