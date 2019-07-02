//
//  UILabel+XNLabel.m
//  XNUtils_Example
//
//  Created by Luigi on 2019/6/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "UILabel+XNLabel.h"

@implementation UILabel (XNLabel)
+ (UILabel *)initWithBackgroundColor:(UIColor *)backgroundColor TextAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)initWithText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor TextAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.backgroundColor = backgroundColor;
    label.textAlignment = textAlignment;
    return label;
}
@end
