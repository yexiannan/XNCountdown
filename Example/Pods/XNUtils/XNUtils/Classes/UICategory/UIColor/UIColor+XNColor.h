//
//  UIColor+XNColor.h
//  XNUtils
//
//  Created by Luigi on 2019/5/31.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define COLOR_WHITE cHEXCOLOR(#ffffff)
#define COLOR_GARY_BG cHEXCOLOR(#f5f5f5)
#define COLOR_BLACK_2C cHEXCOLOR(#2c2c2c)
#define COLOR_BLACK_4C cHEXCOLOR(#4c4c4c)
#define COLOR_GARY_A1 cHEXCOLOR(#a1a1a1)
#define COLOR_GARY_E1 cHEXCOLOR(#e1e1e1)
#define COLOR_PLACEHOLDER cHEXCOLOR(#C7C7CD)

#define cHEXCOLOR(_hex_) [UIColor xnColorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#define cHEXACOLOR(_hex_,alpha) [UIColor xnColorWithHexString:((__bridge NSString *)CFSTR(#_hex_)) Alpha:alpha]

@interface UIColor (XNColor)
+ (instancetype)xnColorWithHexString:(NSString *)hexStr;
+ (instancetype)xnColorWithHexString:(NSString *)hexStr Alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
