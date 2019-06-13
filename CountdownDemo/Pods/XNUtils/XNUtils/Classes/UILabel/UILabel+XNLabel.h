//
//  UILabel+XNLabel.h
//  XNUtils_Example
//
//  Created by Luigi on 2019/6/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XNLabel)
+ (UILabel *)initWithBackgroundColor:(UIColor *)backgroundColor TextAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)initWithText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor TextAlignment:(NSTextAlignment)textAlignment;
@end

NS_ASSUME_NONNULL_END
