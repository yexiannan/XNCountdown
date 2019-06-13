//
//  UIImage+XNImage.h
//  Caiyicai
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//获取Assets图片
#define IMG(imgName) [UIImage imageNamed:@#imgName]//只能直接输入图片名称无法传入字符串对象指针
#define IMGS(imgName) [UIImage imageNamed:imgName]//可传入字符串对象指针

@interface UIImage (XNImage)
/**
 *  颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  视图转图片
 */
+ (UIImage *)imageWithView:(UIView *)view;
/**
 *  Layer转图片
 */
+ (UIImage *)imageWithLayer:(CALayer *)layer;
/**
 *  图片转Data 原图size传nil或0
 */
+ (NSData *)imageToDataWithImage:(UIImage *)image MaxDataSizeKBytes:(float)size;
/**
 *  压缩图片
 */
+ (UIImage *)imageCompressWithImage:(UIImage *)image MaxDataSizeKBytes:(float)size;
/**
 *  生成指定大小的二维码图片
 */
+ (UIImage *)createCodeImageWithUrlString:(nonnull NSString *)urlString Size:(CGFloat)size;
/**
 *  生成带头像二维码图
 */
+ (UIImage *)imagewithBGImage:(UIImage *)bgImage addAvatarImage:(UIImage *)avatarImage ofTheSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
