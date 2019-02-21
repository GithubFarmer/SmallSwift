//
//  NSDate+kExtend.h
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/13.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (kExtend)

//获取今天
+ (NSString *)today;

//获取星期几
- (NSString *)weekWithDateString:(NSString *)dateString;

//获取时间戳
- (NSTimeInterval)getTimestamp:(NSString *)dateString;

@end
