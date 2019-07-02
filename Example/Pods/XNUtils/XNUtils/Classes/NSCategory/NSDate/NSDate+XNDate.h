//
//  NSDate+XNDate.h
//  XNUtils
//
//  Created by Luigi on 2019/5/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTNSDateFormatterFactory.h"

NS_ASSUME_NONNULL_BEGIN

#define D_MINUTE    60
#define D_HOUR      3600
#define D_DAY       86400
#define D_WEEK      604800
#define D_YEAR      31556926

@interface NSDate (XNDate)
#pragma mark - 时间判断
/**
 是否为同一天
 */
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
/**
 是否为今天
 */
- (BOOL)isToday;
/**
 是否为明天
 */
- (BOOL)isTomorrow;
/**
 是否为昨天
 */
- (BOOL)isYesterday;

/**
 是否为同一周
 */
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;

/**
 是否是系统时间的本周
 */
- (BOOL)isThisWeek;
/**
 是否是系统时间的下周
 */
- (BOOL)isNextWeek;
/**
 是否是系统时间的上周
 */
- (BOOL)isLastWeek;

/**
 是否为同一月
 */
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
/**
 是否是系统时间的本月
 */
- (BOOL)isThisMonth;
/**
 是否是系统时间的下周
 */
- (BOOL)isNextMonth;
/**
 是否是系统时间的上周
 */
- (BOOL)isLastMonth;

/**
 是否为同一年
 */
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
/**
 是否是系统时间的本年
 */
- (BOOL)isThisYear;
/**
 是否是系统时间的明年
 */
- (BOOL)isNextYear;
/**
 是否是系统时间的去年
 */
- (BOOL)isLastYear;

/**
 是否为早先时候
 */
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
/**
 是否为晚先时候
 */
- (BOOL)isLaterThanDate:(NSDate *)aDate;
/**
 是否系统时间的为晚先时候
 */
- (BOOL)isInFuture;
/**
 是否为系统时间晚先时候
 */
- (BOOL)isInPast;

/**
 是否为工作日
 */
- (BOOL)isTypicallyWorkday;
/**
 是否为非工作日 周六日
 */
- (BOOL)isTypicallyWeekend;

#pragma mark - 获得一定时间差的时间
/**
 获得明天此时
 */
+ (NSDate *)dateTomorrow;
/**
 获得昨天此时
 */
+ (NSDate *)dateYesterday;
/**
 获得到现在几天的时间
 */
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
/**
 获得几天前的时间
 */
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
/**
 获得到当前几个小时的时间
 */
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
/**
 获得到当前时间几个小时之前的时间
 */
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
/**
 获得到当前几个分钟的时间
 */
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
/**
 获得到当前时间几分钟之前的时间
 */
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;
/**
 获取当前时间的几年后的时间
 */
- (NSDate *)dateByAddingYears:(NSInteger)dYears;
/**
 获取当前时间的几年前的时间
 */
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
/**
 获取当前时间的几个月后的时间
 */
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
/**
 获取当前时间的几个月前的时间
 */
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
/**
 获取当前时间的几天后的时间
 */
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
/**
 获取当前时间的几天前的时间
 */
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
/**
 获取当前时间的几个小时后的时间
 */
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
/**
 获取当前时间的几小时前的时间
 */
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
/**
 获取当前时间的几分钟后的时间
 */
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
/**
 获取当前时间的几分钟前的时间
 */
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;

#pragma mark - 获得一个时间段的开始结束时间
/**
 获取当前时间当天的开始时间
 */
- (NSDate *)dateAtStartOfDay;
/**
 获取当前时间当天的结束时间
 */
- (NSDate *)dateAtEndOfDay;
/**
 获取当前时间本小时的开始时间
 */
- (NSDate *)dateAtStartOfCurrentHour;
/**
 获取当前时间本小时的结束时间
 */
- (NSDate *)dateAtEndOfCurrentHour;
/**
 获取当前时间本本月的开始时间
 */
- (NSDate *)dateAtStartOfMonth;
/**
 获取当前时间本月的结束时间
 */
- (NSDate *)dateAtEndOfMonth;
/**
 获取当前时间本年的开始时间
 */
- (NSDate *)dateAtStartOfYear;
/**
 获取当前时间本年的结束间
 */
- (NSDate *)dateAtEndOfYear;

#pragma mark - 判断时间差
/*
 *  时间间隔天数
 */
- (NSInteger)daysBetween:(NSDate *)aDate;
/**
 获取到当前时间之后几秒
 */
- (NSInteger)secondsAfterDate:(NSDate*)aDate;
/**
 获取到当前时间之前几秒
 */
- (NSInteger)secondsBeforeDate:(NSDate*)aDate;
/**
 获取到当前时间之后几分钟
 */
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
/**
 获取到当前时间之前几分钟
 */
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
/**
 获取到当前时间之后几小时
 */
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
/**
 获取到当前时间之前几小时
 */
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
/**
 获取到当前时间之后几天
 */
- (NSInteger)daysAfterDate:(NSDate *)aDate;
/**
 获取到当前时间之前几天
 */
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
/**
 获取到当前时间的天数
 */
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;
#pragma mark - 用格式化字符串创建时间
/**
 字符串转NSDate  YYMMDDTHHmmss || YYMMDD
 */
+ (NSDate *)at_dateFromString:(NSString *)dateString;

+ (NSDate *)dateWithFormatStr:(NSString *)formatStr timeStr:(NSString *)timeStr;

/**
 用格式化字符串创建时间  "yyyy.MM.dd HH:mm:ss"
 */
+ (NSDate *)dateWithTimeStr:(NSString *)timeStr;
/**
 用格式化字符串创建时间  "yyyy-MM-dd HH:mm:ss"
 */
+ (NSDate *)dateWithTimeStr1:(NSString *)timeStr;

/**
 用格式化字符串创建时间  "yyyy.MM.dd HH:mm"
 */
+ (NSDate *)dateWithTimeStr2:(NSString *)timeStr;

/**
 用格式化字符串创建时间  "MM.dd HH:mm:ss"
 */
+ (NSDate *)dateWithTimeStr3:(NSString *)timeStr;

/**
 用格式化字符串创建时间  "MM.dd HH:mm"
 */
+ (NSDate *)dateWithTimeStr4:(NSString *)timeStr;
/**
 用格式化字符串创建时间  "yy.MM.dd HH:mm:ss"
 */
+ (NSDate *)dateWithTimeStr5:(NSString *)timeStr;

/**
 根据时间字符串转换为NSDate   格式字符串为@"yyyy-MM-dd"
 */
+(NSDate *)dateWithTimeStr6:(NSString*)timeStr;

#pragma mark - 获得格式化时间字符串
/**
 获取时间字符串  eg. 12-10-29 下午2:52
 */
@property(nonatomic, readonly) NSString *shortString;
/**
 获取时间字符串  eg. 12-10-29
 */
@property(nonatomic, readonly) NSString *shortDateString;
/**
 获取时间字符串  eg. 下午2:52
 */
@property(nonatomic, readonly) NSString *shortTimeString;
/**
 获取时间字符串  eg. 2012-10-29 下午2:51:43
 */
@property(nonatomic, readonly) NSString *mediumString;
/**
 获取时间字符串  eg. 2012-10-29
 */
@property(nonatomic, readonly) NSString *mediumDateString;
/**
 获取时间字符串  eg. 下午2:51:43
 */
@property(nonatomic, readonly) NSString *mediumTimeString;
/**
 获取时间字符串  eg. 2012年10月29日星期一 中国标准时间下午2时46分49秒
 */
@property(nonatomic, readonly) NSString *longString;
/**
 获取时间字符串  eg. 2012年10月29日星期一
 */
@property(nonatomic, readonly) NSString *longDateString;
/**
 获取时间字符串  eg.中国标准时间下午2时46分49秒
 */
@property(nonatomic, readonly) NSString *longTimeString;

/**
 按格式输出时间字符串
 
 @param dateStyle 日期类型
 @param timeStyle 时间类型
 
 kCFDateFormatterNoStyle = 0,       // 无输出
 kCFDateFormatterShortStyle = 1,    // 12-10-29 下午2:52
 kCFDateFormatterMediumStyle = 2,   // 2012-10-29 下午2:51:43
 kCFDateFormatterLongStyle = 3,     // 2012年10月29日 GMT+0800下午2时51分08秒
 kCFDateFormatterFullStyle = 4      // 2012年10月29日星期一 中国标准时间下午2时46分49秒
 
 @return 时间字符串
 */
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

/**
 根据格式输出时间字符串
 */
- (NSString *)stringWithFormat:(NSString *)format;



/**
 根据格式字符串和区域返回时间字符串
 
 
 @param format 格式字符串
 @param localeStr 区域语言字符串  eg. 中文 @"zh_CN"  美国英文 en_US
 */
- (NSString *)stringWithFormat:(NSString *)format localeStr:(NSLocale *)localeStr;

/**
 yyyy年MM月dd日
 */
- (NSString *)toYmdFormatString;
/**
 "yyyy-MM-dd"
 */
- (NSString *)toYmd2FormatString;
/**
 yyyy-MM-dd HH:mm:ss
 */
- (NSString *)toYmdHmsFormatString;
/**
 yyyy年MM月dd日 HH点:mm分
 */
- (NSString *)toYmdHmFormatString;
/**
 月日 时:分
 */
- (NSString *)toMdHmFormatString;
/**
 yyyy-MM-dd HH:m
 */
- (NSString *)toYmdHm2FormatString;

/**
 yyyy.MM.dd
 */
- (NSString *)toYmd1FormatString;
/**
 yyyy.MM.dd HH:mm
 */
- (NSString *)toYmdHm3FormatString;

/**
 yyyy.MM.dd HH:mm:ss
 */
- (NSString *)toYmdHms2FormatString;
/**
 MM.dd HH:mm:ss
 */
- (NSString *)toMdHmsFormatString;
/**
 MM.dd HH:mm
 */
- (NSString *)toMdHm1FormatString;

#pragma mark - 获得系统时间各单位数值
/**
 距离系统时间最近的小时数 eg. 3:12  return 3   3:45 return 4
 */
+ (NSInteger)nearestHour;
/**
 系统时间时间的小时数
 */
+ (NSInteger)hour;
/**
 系统时间时间的分钟数
 */
+ (NSInteger)minute;
/**
 当系统时间时间的秒数
 */
+ (NSInteger)seconds;
/**
 系统时间时间的天数
 */
+ (NSInteger)day;
/**
 系统时间时间的月数
 */
+ (NSInteger)month;
/**
 系统时间月的第几周
 */
+ (NSInteger)week;
/**
 系统时间时间星期几    ps. 星期日为本星期第一天  为1
 */
+ (NSInteger)weekday;
/**
 系统时间星期几时本月的第几个星期几
 */
+ (NSInteger)nthWeekday;
/**
 系统时间的年数
 */
+ (NSInteger)year;
#pragma mark - 当前时间各单位数值
/**
 距离最近的小时数  eg. 3:12  return 3   3:45 return 4
 */
@property(readonly) NSInteger nearestHour;
/**
 当前时间的小时数
 */
@property(readonly) NSInteger hour;
/**
 当前时间的分钟数
 */
@property(readonly) NSInteger minute;
/**
 当前时间的秒数
 */
@property(readonly) NSInteger seconds;
/**
 当前时间的天数
 */
@property(readonly) NSInteger day;
/**
 当前时间的月数
 */
@property(readonly) NSInteger month;
/**
 当前月的第几周
 */
@property(readonly) NSInteger week;
/**
 当前时间星期几    ps. 星期日为本星期第一天  为1
 */
@property(readonly) NSInteger weekday;
/**
 当前星期几时本月的第几个星期几
 */
@property(readonly) NSInteger nthWeekday;
/**
 当前时间的年数
 */
@property(readonly) NSInteger year;
#pragma mark - 获得时间戳
/**
 系统时间时间戳  单位 秒
 */
+ (long long)systemTimeStampSeconds;

/**
 系统时间时间戳  单位 毫秒
 */
+ (long long)systemTimeStamp;

/**
 系统时间时间戳  单位 秒
 */
+ (NSString *)systemTimeStampSecondStr;

/**
 系统时间时间戳  单位 毫秒
 */
+ (NSString *)systemTimeStampStr;

/**
 系统时间时间戳  单位 秒
 */
+ (NSDecimalNumber *)systemTimeStampSecondNumber;

/**
 系统时间时间戳  单位 毫秒
 */
+ (NSDecimalNumber *)systemTimeStampNumber;

/**
 时间戳  单位 秒
 */
- (long long)timeStampSeconds;

/**
 时间戳  单位 毫秒
 */
- (long long)timeStamp;

/**
 时间戳  单位 秒
 */
- (NSString *)timeStampSecondStr;

/**
 时间戳  单位 毫秒
 */
- (NSString *)timeStampStr;
/**
 时间戳  单位 毫秒
 */
- (NSDecimalNumber *)timeStampSecondNumber ;

/**
 时间戳  单位 毫秒
 */
- (NSDecimalNumber *)timeStampNumber;
#pragma mark - 用时间戳创建时间

/**
 使用时间戳创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStamp:(long long)timeStamp;
/**
 使用时间戳创建时间  秒
 */
+ (NSDate *)dateWithTimeStampSeconds:(long long)timeStampSeconds;
/**
 使用时间戳字符串创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStampStr:(NSString *)timeStampStr;
/**
 使用时间戳字符串创建时间  秒
 */
+ (NSDate *)dateWithTimeStampSecondsStr:(NSString *)timeStampStr;
/**
 使用大数据格式创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStampNumber:(NSDecimalNumber *)timeStamp;
/**
 使用大数据格式创建时间  秒
 */
+ (NSDate *)dateWithTimeStampNumberSeconds:(NSDecimalNumber *)timeStamp;

#pragma mark - other
/**
 获取当前时间NSDateComponents
 */
-(NSDateComponents *)getComponentsFromDate;

/**
 获取何年何月有几天
 
 @param years 年数
 @param month 月数
 @return 返回天数
 */
+ (NSInteger)dayCount:(NSInteger)years month:(NSInteger)month;

/**
 获取是上午或者下午字符串
 */
- (NSString *)time12hourString;

/**
 根据年月日创建时间    必须为正整数
 */
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 用生日时间计算年龄
 */
+ (NSInteger)calculateAgeWithdate:(NSDate *)date;

@end

@interface NSCalendar (XNCalender)

+ (instancetype)sharedCalendar;

@end

NS_ASSUME_NONNULL_END
