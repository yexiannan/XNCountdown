//
//  UIView+XNView.h
//  Caiyicai
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger ,BadgePosition) {
    BadgePosition_TopLeft,
    BadgePosition_TopRight,
    BadgePosition_BottomLeft,
    BadgePosition_BottomRight,
};

@interface UIView (XNView)

/**
 *  添加子控件集合
 */
- (void)cl_AddSubviews:(NSArray<UIView *>*) subleViews;
/**
 *  切圆角
 */
+(void)changeLabelStyle:(UIView *)view WithRadii:(CGSize)size WithCorner:(UIRectCorner)corners;
#pragma mark - Badge
#warning Adding a badge using this category will create a tag of 15726


//notificationPath   通知路径数组 格式：@[@"aVC/bVC/cVC",@"mVC/nVC/cVC"]，当移除红点或count减少时，会遍历notificationPath中的路径并发送通知，如cVC红点移除时会发送key为@“aVC/bVC”和@"mVC/nVC“两条通知
@property (nonatomic, copy) NSArray <NSString *> *notificationPathArray;

/**
 *  count     红点数         设置为-1时只显示红点
 *  maxCount   最大红点数
 *  font        显示的字体     默认为[UIFont lightFontWithSize:7] 红点Lable的大小会根据设置的font做布局
 *  titleColor   字体颜色      默认为[UIColor whiteColor]
 *  badgeColor    红点背景色    默认为[UIColor redColor]
 *  icon           红点图片
 *  iconSize        红点图片大小
 *  badgePosition    红点位置     默认为BadgePosition_TopRight
 *  badgeOffset       偏移量      根据badgePosition计算偏移
 */

/**
 *  全参数设置角标
 */
- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount Font:(nullable UIFont *)font TextColor:(nullable UIColor *)textColor BadgeColor:(nullable UIColor *)badgeColor BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset;
/**
 *  全参数设置图片角标
 */
- (void)setBadgeWithIcon:(UIImage *)icon IconSize:(CGSize)iconSize BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset;
/**
 *  设置角标 并设置位置、偏移
 */
- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset;
/**
 *  设置角标
 */
- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount;
/**
 *  设置图片角标
 */
- (void)setBadgeWithIcon:(UIImage *)icon IconSize:(CGSize)iconSize;
/**
 *  清除角标
 */
- (void)clearBadge;
/**
 *  count为NSInteger转NSNumber count为改变量 0为全部清除 正数为增量 负数为减量
 */
- (void)clearBadgeAndSendNotificationWithCount:(nonnull NSNumber *)count;

/*
使用方法：使用设置角标方法并传入相关参数进行设置角标.
        清除角标时若无需发送通知直接调用clearBadge,
        否则调用clearBadgeAndSendNotificationWithCount:并传入count改变量,
        清除图片角标count传0即可.

*/

@end

NS_ASSUME_NONNULL_END
