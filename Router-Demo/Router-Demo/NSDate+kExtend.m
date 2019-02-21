//
//  NSDate+kExtend.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/13.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "NSDate+kExtend.h"

@implementation NSDate (kExtend)

+ (NSString *)today{
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [[NSDate alloc]init];
    return [fm stringFromDate:now];
}

- (NSTimeInterval)getTimestamp:(NSString *)dateString{
    if(dateString.length <= 0){
        return 0;
    }
    NSString *newDateString = [dateString stringByAppendingString:@" 00:00:00"];
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateStyle = kCFDateFormatterShortStyle;
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    fm.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate *dateNow = [fm dateFromString:newDateString];
    return [dateNow timeIntervalSince1970];
}

//经过验证是错误的
- (NSString *)weekWithDateString:(NSString *)dateString{
    NSTimeInterval timesTamp = [self getTimestamp:dateString];
    NSInteger day = timesTamp / 84600;
    NSArray *array = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    return array[(day - 3) % 7];
}
@end
