//
//  UIFont+XNFont.m
//  Caiyicai
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "UIFont+XNFont.h"

@implementation UIFont (XNFont)

+ (instancetype)lightFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize{
    CGFloat scaleSize = [self calculateFontSizeWithSize:size minSize:minSize MaxSize:maxSize];
    if ([self deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:scaleSize];
    }
    return [UIFont fontWithName:@"PingFang-SC-Light" size:scaleSize];
}

+ (instancetype)mediumFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize {
    CGFloat scaleSize = [self calculateFontSizeWithSize:size minSize:minSize MaxSize:maxSize];
    if ([self deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:scaleSize];
    }
    return [UIFont fontWithName:@"PingFang-SC-Medium" size:scaleSize];
}

+ (instancetype)regularFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize {
    CGFloat scaleSize = [self calculateFontSizeWithSize:size minSize:minSize MaxSize:maxSize];
    if ([self deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue" size:scaleSize];
    }
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:scaleSize];
}

+ (instancetype)boldFontWithAutoSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize {
    CGFloat scaleSize = [self calculateFontSizeWithSize:size minSize:minSize MaxSize:maxSize];
    return [UIFont boldSystemFontOfSize:scaleSize];
}

+ (CGFloat)calculateFontSizeWithSize:(CGFloat)size minSize:(CGFloat)minSize MaxSize:(CGFloat)maxSize{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat scaleSize = size * floorf(screenWidth/375.0);
    
    if (maxSize > 0) { //是否有设置最大值
        
        if (minSize < maxSize) { //最大值和最小值区间的有效性判断
            
            if (size <= minSize) {
                scaleSize = minSize;
            }
            if (size >= maxSize) {
                scaleSize = maxSize;
            }
            
        } else {
             scaleSize = size;
        }
        
    } else {
        
        if (minSize > 0) { //是否有设置最小值
            
            if (size < minSize) {
                scaleSize = minSize;
            }
            
        } else {
            scaleSize = size;
        }
        
    }
    
    return scaleSize;
}

+ (NSUInteger) deviceSystemMajorVersion {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

@end
