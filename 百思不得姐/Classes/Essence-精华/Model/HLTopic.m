//
//  HLTopic.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/16.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "HLTopic.h"

@implementation HLTopic

- (NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    formatter.dateFormat = @"yy-MM-dd HH-mm-ss";
    //帖子的创建时间
    NSDate *create = [formatter dateFromString:_create_time];
    
    //比较时间
    if (create.isThisYear) {
        if (create.isToday) {
            
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) { //时间差距大于一小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
                
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1 minute
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else { //1 minute > 时间差距
                return @"刚刚";
        
            }
        } else if (create.isYesterday) {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
            
        } else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    } else {
        
        return _create_time;
    }
    
    
}

@end
