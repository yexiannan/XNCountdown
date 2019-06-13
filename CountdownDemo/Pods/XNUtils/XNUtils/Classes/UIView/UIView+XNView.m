//
//  UIView+XNView.m
//  Caiyicai
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "UIView+XNView.h"
#import "XNMacro.h"

//key for associative methods during runtime
static char badgeNotificationPathArrayKey;
static char badgeCountKey;
static char badgeLabelKey;
static char badgeImageKey;

@interface UIView ()
@property (nonatomic, copy) NSNumber *badgeCount;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UIImageView *badgeImage;
@end

@implementation UIView (XNView)

+(void)changeLabelStyle:(UIView *)view WithRadii:(CGSize)size WithCorner:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)cl_AddSubviews:(NSArray<UIView *>*) subleViews {
    
    [subleViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}

#pragma mark - Set Badge

- (void)clearBadgeAndSendNotificationWithCount:(NSNumber *)count{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 15726) {
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
    
    if (![NSArray arrayIsNull:self.notificationPathArray]) {
        [self.notificationPathArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //截取NotificationName
            NSMutableArray *pathArray = [NSMutableArray arrayWithArray:[obj componentsSeparatedByString:@"/"]];
            [pathArray removeLastObject];
            NSString *pathString = [pathArray componentsJoinedByString:@"/"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:pathString object:nil userInfo:@{@"key":count}];
        }];
    }
}


- (void)clearBadge{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 15726) {
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
}

- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount Font:(UIFont *)font TextColor:(UIColor *)textColor BadgeColor:(UIColor *)badgeColor BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset{

    if (self.badgeCount) {
        NSInteger difference = count - [self.badgeCount integerValue];
        
        if (difference == 0) {
            [self clearBadge];
        }else{
            [self clearBadgeAndSendNotificationWithCount:[NSNumber numberWithInteger:difference]];
        }

    }else{
        [self clearBadge];
    }

    self.badgeCount = [NSNumber numberWithInteger:count];
    self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.badgeLabel.tag = 15726;
    self.badgeLabel.backgroundColor = [UIColor redColor];
    self.badgeLabel.textColor = textColor?textColor:[UIColor whiteColor];
    self.badgeLabel.font = font?font:MFont(10);
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    
    if (count == -1) {
        self.badgeLabel.text = @" ";
    }else{
        self.badgeLabel.text = count>maxCount?[NSString stringWithFormat:@"%ld+",(long)maxCount]:[NSString stringWithFormat:@"%ld",(long)count];
    }
    
    [self.badgeLabel sizeToFit];
    
    CGSize badgeSize = self.badgeLabel.size;
    badgeSize.width += (count == -1)?0:4;
    
    if(badgeSize.width < badgeSize.height) {
        badgeSize.width = badgeSize.height;
    }

    self.badgeLabel.frame = [self getBageRectWithBadgePosition:badgePosition BadgeSize:badgeSize BadgeOffset:badgeOffset];
    self.badgeLabel.layer.cornerRadius = CGRectGetHeight(self.badgeLabel.frame) / 2;
    self.badgeLabel.layer.masksToBounds = YES;
    
    [self addSubview:self.badgeLabel];
    [self bringSubviewToFront:self.badgeLabel];
}

- (void)setBadgeWithIcon:(UIImage *)icon IconSize:(CGSize)iconSize BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset{
    
    //图片非空判断
    if (![icon isKindOfClass:[UIImage class]]) return;
    //先移除之前的badge
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 15726) {
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
    
    self.badgeImage = [[UIImageView alloc] initWithImage:icon];
    self.badgeImage.tag = 15726;
    [self addSubview:self.badgeImage];
    self.badgeImage.frame = [self getBageRectWithBadgePosition:badgePosition BadgeSize:iconSize BadgeOffset:badgeOffset];
}

- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount BadgePosition:(BadgePosition)badgePosition BadgeOffset:(UIEdgeInsets)badgeOffset{
    [self setBadgeWithCount:count MaxCount:maxCount Font:nil TextColor:nil BadgeColor:nil BadgePosition:badgePosition BadgeOffset:badgeOffset];
}

- (void)setBadgeWithCount:(NSInteger)count MaxCount:(NSInteger)maxCount{
    [self setBadgeWithCount:count MaxCount:maxCount Font:nil TextColor:nil BadgeColor:nil BadgePosition:BadgePosition_TopRight BadgeOffset:UIEdgeInsetsZero];
}

- (void)setBadgeWithIcon:(UIImage *)icon IconSize:(CGSize)iconSize{
    [self setBadgeWithIcon:icon IconSize:iconSize BadgePosition:BadgePosition_TopRight BadgeOffset:UIEdgeInsetsZero];
}

- (CGRect)getBageRectWithBadgePosition:(BadgePosition)badgePosition BadgeSize:(CGSize)badgeSize BadgeOffset:(UIEdgeInsets)badgeOffset{
    
    //计算偏移后的位置与大小
    CGFloat topOffset = -badgeSize.height/2+badgeOffset.top;
    CGFloat leftOffset = -badgeSize.width/2+badgeOffset.left;
    CGFloat bottomOffset = badgeSize.height/2-badgeOffset.bottom;
    CGFloat rightOffset = badgeSize.width/2-badgeOffset.right;
    CGSize badgeSizeWithOffset = CGSizeMake(badgeSize.width-badgeOffset.top-badgeOffset.bottom, badgeSize.height-badgeOffset.left-badgeOffset.right);
    
    CGPoint badgePoint;
    
    switch (badgePosition) {
        case BadgePosition_TopLeft:{
            badgePoint = CGPointMake(leftOffset, topOffset);
        }
            break;
        case BadgePosition_TopRight:{
            badgePoint = CGPointMake(CGRectGetWidth(self.frame)-rightOffset, topOffset);
        }
            break;
        case BadgePosition_BottomLeft:{
            badgePoint = CGPointMake(leftOffset, CGRectGetHeight(self.frame)-bottomOffset);
        }
            break;
        case BadgePosition_BottomRight:{
            badgePoint = CGPointMake(CGRectGetWidth(self.frame)-rightOffset, CGRectGetHeight(self.frame)-bottomOffset);
        }
            break;
            
        default:
            break;
    }
    
    return CGRectMake(badgePoint.x, badgePoint.y, badgeSizeWithOffset.width, badgeSizeWithOffset.height);
}

#pragma mark -- setter/getter
- (NSArray *)notificationPathArray{
    return objc_getAssociatedObject(self, &badgeNotificationPathArrayKey);
}

- (void)setNotificationPathArray:(NSArray *)notificationPathArray{
    objc_setAssociatedObject(self, &badgeNotificationPathArrayKey, notificationPathArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)badgeCount{
    return objc_getAssociatedObject(self, &badgeCountKey);
}

- (void)setBadgeCount:(NSNumber *)badgeCount{
    objc_setAssociatedObject(self, &badgeCountKey, badgeCount, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILabel *)badgeLabel{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadgeLabel:(UILabel *)badgeLabel{
    objc_setAssociatedObject(self, &badgeLabelKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)badgeImage{
    return objc_getAssociatedObject(self, &badgeImageKey);
}

- (void)setBadgeImage:(UIImageView *)badgeImage{
    objc_setAssociatedObject(self, &badgeImageKey, badgeImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
