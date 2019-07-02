//
//  UIFont+XNFont.h
//  Caiyicai
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define LFont(size) [UIFont lightFontWithAutoSize:size minSize:size MaxSize:size]
#define MFont(size) [UIFont mediumFontWithAutoSize:size minSize:size MaxSize:size]
#define RFont(size) [UIFont regularFontWithAutoSize:size minSize:size MaxSize:size]
#define BFont(size) [UIFont boldFontWithAutoSize:size minSize:size MaxSize:size]

#define ALFont(size,minSize,maxSize) [UIFont lightFontWithAutoSize:size minSize:minSize MaxSize:maxSize]
#define AMFont(size,minSize,maxSize) [UIFont mediumFontWithAutoSize:size minSize:minSize MaxSize:maxSize]
#define ARFont(size,minSize,maxSize) [UIFont regularFontWithAutoSize:size minSize:minSize MaxSize:maxSize]
#define ABFont(size,minSize,maxSize) [UIFont boldFontWithAutoSize:size minSize:minSize MaxSize:maxSize]

@interface UIFont (XNFont)
//以375*667的屏幕大小为基准 对字体进行缩放 maxSize为0时不做限制
+ (instancetype)lightFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize;
+ (instancetype)mediumFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize;
+ (instancetype)regularFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize;
+ (instancetype)boldFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize;

@end

NS_ASSUME_NONNULL_END
