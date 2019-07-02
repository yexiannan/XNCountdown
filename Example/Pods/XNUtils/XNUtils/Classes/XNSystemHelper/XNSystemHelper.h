//
//  XNSystemHelper.h
//  XNUtils
//
//  Created by Luigi on 2019/7/2.
//
//用于快速获取手机系统信息

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @return 1.0.0, 1.1.0 ...
 */
extern NSString * app_version(void);

@interface XNSystemHelper : NSObject
+ (CGFloat)lineWidth;//系统分割线宽度
+ (NSString *)netWorkState;  //当前网络状态 目前WWAN 状态下不区分2G、3G等
+ (NSString *)bundleIdentifier; //获取应用程序包名
+ (NSString *)macAddress; //获取当前设备下的mac地址
+ (NSString*)deviceName;//设备名称
+ (NSString*)deviceType;//设备类型
+ (NSInteger)systemMajorVersion;//iOS 系统版本

@end

NS_ASSUME_NONNULL_END
