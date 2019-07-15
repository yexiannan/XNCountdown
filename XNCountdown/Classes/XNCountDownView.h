//
//  XNCountDownView.h
//  CountdownDemo
//  https://github.com/yexiannan/XNCountdown.git
//
//  Created by Luigi on 2019/6/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface XNCountDownView : UIView
/**
 * 普通倒计时
 */
- (instancetype)initWithFont:(UIFont *)font TextColor:(UIColor *)textColor TextBackgroundColor:(UIColor *)textBackgroundColor ViewBackgroundColor:(UIColor *)viewBackgroundColor;

/**
 * textLabel背景渐变倒计时
 */
- (instancetype)initWithFont:(UIFont *)font TextColor:(UIColor *)textColor ViewBackgroundColor:(UIColor *)viewBackgroundColor GradientDirection:(GradientDirection)direction BeginColor:(UIColor *)bColor EndColor:(UIColor *)eColor;

@property (nonatomic) CGSize viewSize;
@property (nonatomic, copy) NSDate *deadline;//截止时间
@property (nonatomic, assign) NSTimeInterval countTime;//倒计时时长
@end

NS_ASSUME_NONNULL_END
