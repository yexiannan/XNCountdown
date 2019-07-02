//
//  XNSystemHelper.m
//  XNUtils
//
//  Created by Luigi on 2019/7/2.
//

#import "XNSystemHelper.h"
#import "Reachability.h"
#import <sys/utsname.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

#define CGFLOAT_IS_EQUAL(a,b) (fabs((a) - (b)) < 0.00001)


NSString * app_version(void)
{
    static NSString * _appVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    });
    return _appVersion;
}

@implementation XNSystemHelper
+ (CGFloat)lineWidth {
    static CGFloat _lineWidth = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lineWidth = 1.f/[UIScreen mainScreen].scale;
    });
    
    return _lineWidth;
}

+ (NSString *)netWorkState{
    Reachability  *reach = [Reachability reachabilityForInternetConnection];
    NSInteger newState = [reach currentReachabilityStatus];
    switch (newState) {
        case 0:
            return @"无网络";
            break;
        case 1:
            return @"WiFi";
            break;
        case 2:
            return @"WWAN";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)bundleIdentifier {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
    
}

+ (NSString *)macAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
    
}

+ (NSString*)deviceName
{
    NSString * deviceType  = [self deviceType];
    NSArray *array = [deviceType componentsSeparatedByString:@" ("];
    NSString *deviceName = array[0];
    return deviceName;
}

+ (NSString*)deviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    //采用后台映射
    return platform;
}

+ (NSInteger)systemMajorVersion
{
    static NSUInteger systemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return systemMajorVersion;
}
@end
