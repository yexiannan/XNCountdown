//
//  NSDate+XNDate.m
//  XNUtils
//
//  Created by Luigi on 2019/5/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "NSDate+XNDate.h"

NSString * const kDateFormatYYYYMMDD = @"yyyy-MM-dd";
NSString * const kDateFormatYYMMDDTHHmmss = @"yyyy-MM-dd'T'HH:mm:ss";

// Thanks, AshFurrow
static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (XNDate)
#pragma mark - 时间判断
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isToday {
    
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfMonth != components2.weekOfMonth) {
        return NO;
    }
    
    // Must have a time interval under 1 week. Thanks @aclark
    
    //JateXu-- adjust week from mon ===> sun
    //default is from sun ------ > sat.
    NSTimeInterval dist = [self timeIntervalSinceDate:aDate];
    
    if ((fabs(dist) < D_WEEK)) {
        // 1..7
        NSDate *firstDate = nil;
        NSDate *lastDate = nil;
        if (components1.weekday == 1) {
            
            firstDate = [self dateBySubtractingDays:6];
            lastDate = self;
        }
        else if (components1.weekday > 1 && components1.weekday <= 7) {
            
            firstDate = [self dateBySubtractingDays:components1.weekday - 2];
            lastDate = [self dateByAddingDays:8 - components1.weekday];
        }
        
        if ([aDate isEqualToDateIgnoringTime:firstDate]
            || [aDate isEqualToDateIgnoringTime:lastDate]) {
            
            return YES;
        }
        
        if ([aDate isEarlierThanDate:firstDate] || [aDate isLaterThanDate:lastDate]) {
            
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isThisWeek {
    
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)isSameMonthAsDate:(NSDate *)aDate {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)isThisMonth {
    
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)isLastMonth {
    
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL)isNextMonth {
    
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)isThisYear {
    
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear {
    
    NSDateComponents *components1 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar sharedCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate {
    
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
    
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)isInFuture {
    
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)isInPast {
    
    return ([self isEarlierThanDate:[NSDate date]]);
}

- (BOOL)isTypicallyWeekend {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7)) {
        
        return YES;
    }
    return NO;
}

- (BOOL)isTypicallyWorkday {
    
    return ![self isTypicallyWeekend];
}

#pragma mark - 获得一定时间差的时间

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days {
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days {
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateTomorrow {
    
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
    
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

// Thaks, rsjohnson
- (NSDate *)dateByAddingYears:(NSInteger)dYears {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)dYears {
    
    return [self dateByAddingYears:-dYears];
}

- (NSDate *)dateByAddingMonths:(NSInteger)dMonths {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths {
    
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)dateByAddingDays:(NSInteger)dDays {
    
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:dDays];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays {
    
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours {
    
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes {
    
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate {
    
    NSDateComponents *dTime = [[NSCalendar sharedCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - 获得一个时间段的开始结束时间
- (NSDate *)dateAtStartOfDay {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtStartOfCurrentHour {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtEndOfCurrentHour {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.minute = 59;
    components.second = 59;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtStartOfMonth {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}
- (NSDate *)dateAtEndOfMonth {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.month += 1;
    components.day = 0;
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtStartOfYear {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.month = 1;
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
    
}
- (NSDate *)dateAtEndOfYear {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    components.month = 12;
    components.day = 31;
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSCalendar sharedCalendar] dateFromComponents:components];
    
}

#pragma mark - 判断时间差
- (NSInteger)secondsAfterDate:(NSDate*)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)ti;
}
- (NSInteger)secondsBeforeDate:(NSDate*)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)ti;
}
- (NSInteger)minutesAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

/*
 *  时间间隔天数
 */
- (NSInteger)daysBetween:(NSDate *)aDate {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSDate *from = [NSDate at_dateFromString:[self stringWithFormat:kDateFormatYYYYMMDD]];
    NSDate *to = [NSDate at_dateFromString:[aDate stringWithFormat:kDateFormatYYYYMMDD]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:from toDate:to options:0];
    return labs([components day]) + 1;
}

#pragma mark - 用格式化字符串创建时间
/*
 *  字符串转NSDate
 */
+ (NSDate *)at_dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter;
    if (dateString.length > kDateFormatYYYYMMDD.length) {
        dateFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:kDateFormatYYMMDDTHHmmss];
    } else {
        dateFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:kDateFormatYYYYMMDD];
    }
    NSDate *date = [dateFormatter dateFromString:dateString];
    if (!date) {
        date = [NSDate date];
    }
    return date;
}

+ (NSDate *)dateWithFormatStr:(NSString *)formatStr timeStr:(NSString *)timeStr {
    
    NSDateFormatter *dateFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:formatStr];
    return [dateFormatter dateFromString:timeStr];
}

+ (NSDate *)dateWithTimeStr:(NSString *)timeStr {
    return [NSDate dateWithFormatStr:@"yyyy.MM.dd HH:mm:ss" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr1:(NSString *)timeStr {
    
    return [NSDate dateWithFormatStr:@"yyyy-MM-dd HH:mm:ss" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr2:(NSString *)timeStr {
    
    return [NSDate dateWithFormatStr:@"yyyy.MM.dd HH:mm" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr3:(NSString *)timeStr {
    
    return [NSDate dateWithFormatStr:@"MM.dd HH:mm:ss" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr4:(NSString *)timeStr {
    
    return [NSDate dateWithFormatStr:@"MM.dd HH:mm" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr5:(NSString *)timeStr {
    
    return [NSDate dateWithFormatStr:@"yy.MM.dd HH:mm:ss" timeStr:timeStr];
}

+ (NSDate *)dateWithTimeStr6:(NSString*)timeStr; {
    
    NSDateFormatter *inputFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    return inputDate;
}

#pragma mark - 获得格式化时间字符串
- (NSString *)shortString {
    
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortTimeString {
    
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortDateString {
    
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mediumString {
    
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumTimeString {
    
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumDateString {
    
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)longString {
    
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longTimeString {
    
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longDateString {
    
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    
    NSDateFormatter *formatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithDateStyle:dateStyle andTimeStyle:timeStyle];
    return [formatter stringFromDate:self];
}

/*
 *  根据传入的格式 返回时间字符串
 */
- (NSString *)stringWithFormat:(NSString *)format {
    if (!format) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:format];
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (NSString *)stringWithFormat: (NSString *)format localeStr:(NSString *)localeStr {
    
    NSDateFormatter *formatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:format andLocaleIdentifier:localeStr];
    
    return [formatter stringFromDate:self];
}

- (NSString *)toYmdFormatString {
    
    return [self stringWithFormat:@"yyyy年MM月dd日"];
}

- (NSString *)toMdHmFormatString {
    
    return [self stringWithFormat:@"M月dd日 HH:mm"];
}

- (NSString *)toYmd2FormatString {
    
    return [self stringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)toYmdHmsFormatString {
    
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)toYmdHmFormatString {
    
    return [self stringWithFormat:@"yyyy年MM月dd日 HH点:mm分"];
}

- (NSString *)toYmdHm2FormatString {
    
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)toYmd1FormatString {
    return [self stringWithFormat:@"yyyy.MM.dd"];
}

- (NSString *)toYmdHm3FormatString {
    
    return [self stringWithFormat:@"yyyy.MM.dd HH:mm"];
}

- (NSString *)toYmdHms2FormatString {
    
    return [self stringWithFormat:@"yyyy.MM.dd HH:mm:ss"];
}

- (NSString *)toMdHmsFormatString {
    
    return [self stringWithFormat:@"MM.dd HH:mm:ss"];
}

- (NSString *)toMdHm1FormatString {
    return [self stringWithFormat:@"MM.dd HH:mm"];
}

#pragma mark - 获得系统时间各单位数值
/**
 距离系统时间最近的小时数 eg. 3:12  return 3   3:45 return 4
 */
+ (NSInteger)nearestHour {
    
    return [NSDate date].nearestHour;
}
/**
 系统时间时间的小时数
 */
+ (NSInteger)hour {
    
    return [NSDate date].hour;
}
/**
 系统时间时间的分钟数
 */
+ (NSInteger)minute {
    
    return [NSDate date].minute;
}
/**
 当系统时间时间的秒数
 */
+ (NSInteger)seconds {
    
    return [NSDate date].seconds;
}
/**
 系统时间时间的天数
 */
+ (NSInteger)day {
    
    return [NSDate date].day;
}
/**
 系统时间时间的月数
 */
+ (NSInteger)month {
    
    return [NSDate date].month;
}
/**
 系统时间月的第几周
 */
+ (NSInteger)week {
    
    return [NSDate date].week;
}
/**
 系统时间时间星期几    ps. 星期日为本星期第一天  为1
 */
+ (NSInteger)weekday {
    
    return [NSDate date].weekday;
}
/**
 系统时间星期几时本月的第几个星期几
 */
+ (NSInteger)nthWeekday {
    
    return [NSDate date].nthWeekday;
}
/**
 系统时间的年数
 */
+ (NSInteger)year {
    
    return [NSDate date].year;
}

#pragma mark - 当前时间各单位数值
- (NSInteger)nearestHour {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)minute {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)seconds {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)day {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)month {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)week {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger)weekday {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

// e.g. 2nd Tuesday of the month is 2
- (NSInteger)nthWeekday {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)year {
    
    NSDateComponents *components = [[NSCalendar sharedCalendar] components:componentFlags fromDate:self];
    if (components.year < 2017) {
        return 2017;
    }
    return components.year;
}

#pragma mark - 获得时间戳
/**
 系统时间时间戳  单位 秒
 */
+ (long long)systemTimeStampSeconds {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    return (long long)timeInterval;
}

/**
 系统时间时间戳  单位 毫秒
 */
+ (long long)systemTimeStamp {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    return (long long)timeInterval;
}

/**
 系统时间时间戳  单位 秒
 */
+ (NSString *)systemTimeStampSecondStr {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lld",(long long)timeInterval];
}

/**
 系统时间时间戳  单位 毫秒
 */
+ (NSString *)systemTimeStampStr {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%lld",(long long)timeInterval];
}

/**
 系统时间时间戳  单位 秒
 */
+ (NSDecimalNumber *)systemTimeStampSecondNumber {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    return [[NSDecimalNumber alloc]initWithDouble:timeInterval];
}

/**
 系统时间时间戳  单位 毫秒
 */
+ (NSDecimalNumber *)systemTimeStampNumber {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [[NSDecimalNumber alloc]initWithDouble:timeInterval];
}

/**
 时间戳  单位 秒
 */
- (long long)timeStampSeconds {
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    return (long long)timeInterval;
}
/**
 时间戳  单位 毫秒
 */
- (long long)timeStamp {
    NSTimeInterval timeInterval = [self timeIntervalSince1970] * 1000;
    return (long long)timeInterval;
}


/**
 时间戳  单位 秒
 */
- (NSString *)timeStampSecondStr {
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lld",(long long)timeInterval];
}

/**
 时间戳  单位 毫秒
 */
- (NSString *)timeStampStr
{
    NSTimeInterval timeInterval = [self timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%lld",(long long)timeInterval];
}

#pragma mark - 用时间戳创建时间
/**
 系统时间时间戳  单位 秒
 */
- (NSDecimalNumber *)timeStampSecondNumber {
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    return [[NSDecimalNumber alloc]initWithDouble:timeInterval];
}

/**
 系统时间时间戳  单位 毫秒
 */
- (NSDecimalNumber *)timeStampNumber {
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970] * 1000;
    return [[NSDecimalNumber alloc]initWithDouble:timeInterval];
}
/**
 使用时间戳创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStamp:(long long)timeStamp {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000.0];
}
/**
 使用时间戳创建时间  秒
 */
+ (NSDate *)dateWithTimeStampSeconds:(long long)timeStampSeconds {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStampSeconds];
}
/**
 使用时间戳字符串创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStampStr:(NSString *)timeStampStr {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStampStr.longLongValue / 1000.0];
}
/**
 使用时间戳字符串创建时间  秒
 */
+ (NSDate *)dateWithTimeStampSecondsStr:(NSString *)timeStampStr {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStampStr.longLongValue];
}
/**
 使用大数据格式创建时间  毫秒
 */
+ (NSDate *)dateWithTimeStampNumber:(NSDecimalNumber *)timeStamp {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStamp.longLongValue / 1000.0];
}
/**
 使用大数据格式创建时间  秒
 */
+ (NSDate *)dateWithTimeStampNumberSeconds:(NSDecimalNumber *)timeStamp {
    
    return [NSDate dateWithTimeIntervalSince1970:timeStamp.longLongValue];
}

#pragma mark - other
-(NSDateComponents*)getComponentsFromDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear |NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps = [calendar components:unitFlags fromDate:self];
    
    return comps;
}

+ (NSInteger)dayCount:(NSInteger)years month:(NSInteger)month {
    NSInteger count = 0;
    if (2 == month) {
        if ((years % 4 == 0 && years % 100!=0) || years % 400 == 0) {//是闰年
            count = 29;
        } else {
            count = 28;
        }
        
    } else if (4 == month || 6 == month || 9 == month || 11 == month){
        count = 30;
    } else {
        count = 31;
    }
    return count;
}

- (NSString *)time12hourString {
    
    NSInteger hour = self.hour;
    NSInteger minute = self.minute;
    
    NSString *timeString = [NSString stringWithFormat:@"%@:%02ld", @(hour / 12 ? ((hour - 12) ? : 12) : (hour ? : 12)), (long)minute];
    
    NSString *symbolString = hour / 12 ? @"下午" : @"上午";
    
    return  [NSString stringWithFormat:@"%@%@", symbolString, timeString];
    
}
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;
    return date;
}
+ (NSInteger)calculateAgeWithdate:(NSDate*)date {
    
    NSDateComponents *components1 =
    [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 =
    [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                    fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) ||
        (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return iAge;
}

@end

@implementation NSCalendar (XNCalender)

+ (instancetype)sharedCalendar
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //取得当前用户的逻辑日历
        //currentCalendar取得的值会一直保持在cache中,第一次取得以后如果用户修改该系统日历设定，这个值也不会改变。
        //用autoupdatingCurrentCalendar，那么每次取得的值都会是当前系统设置的日历的值。
        instance = [NSCalendar currentCalendar];
//        instance = [NSCalendar autoupdatingCurrentCalendar];
    });
    return instance;
}

@end
