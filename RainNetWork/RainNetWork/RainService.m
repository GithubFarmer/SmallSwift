//
//  RainService.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/18.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainService.h"

@implementation RainService

/** 设置接口的基础URL */
- (NSString *)serviveApiBaseUrlString{
    return @"http:12343.com";
}

/** 设置Acceptable-Content */
- (NSSet<NSString *> *)serviceResponseAcceptableContentTypes{
    return [NSSet setWithObjects:@"application/json", nil];
}

@end
