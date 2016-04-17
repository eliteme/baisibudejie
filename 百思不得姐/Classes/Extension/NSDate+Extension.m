//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/17.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
   
    //日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self  options:0];
    
}
- (BOOL)isThisYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger newYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return newYear == selfYear;
    
    
}
- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}
- (BOOL)isYesterday {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
    
    
    return YES;
}
@end
