//
//  XNButton.h
//  XNUtils
//
//  Created by Luigi on 2019/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,XNButtonImagePosition) {
    XNButtonImagePosition_Left,
    XNButtonImagePosition_Right,
    XNButtonImagePosition_Top,
    XNButtonImagePosition_Bottom,
};

@interface UIButton (XNButton)
+ (UIButton *)newButtonWithBackgroundImage:(nullable UIImage *)image TitleNormalColor:(UIColor *)titleNormalColor Font:(UIFont *)font TitleNormal:(NSString *)titleNormal Taget:(nullable id)taget Action:(nullable SEL)action;

@end

@interface XNButton : UIButton
/**
 图片位置
 */
@property (nonatomic, assign) XNButtonImagePosition buttonImagePosition;
+ (XNButton *)newButtonWithBackgroundImage:(nullable UIImage *)image TitleNormalColor:(UIColor *)titleNormalColor Font:(UIFont *)font TitleNormal:(NSString *)titleNormal Taget:(nullable id)taget Action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
