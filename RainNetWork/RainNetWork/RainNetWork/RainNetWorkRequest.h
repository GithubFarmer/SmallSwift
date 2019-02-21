//
//  RainNetWorkRequest.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWorkAccessoryProtocol.h"
#import "RainNetWorkInterceptorProtocol.h"
#import "RainNetWorkRequestConfigProtocol.h"
#import "RainNetWorkResponseProtocol.h"
#import "RainNetWorkServiceProtocol.h"

@class RainNetWorkResponse;

/** 网络接口请求类 */
@interface RainNetWorkRequest : NSObject

/** 请求tag*/
@property (nonatomic, assign) NSInteger tag;

/** 请求载体 */
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

/** 请求配置协议 */
@property (nonatomic, weak, readonly) NSObject<RainNetWorkRequestConfigProtocol> *requestConfigProtocol;

/** 请求响应协议 */
@property (nonatomic, weak) id <RainNetWorkResponseProtocol> responseDelegate;

/** 请求拦截协议 */
@property (nonatomic, weak) id <RainNetWorkInterceptorProtocol> interceptorDelegate;

/** 请求插件协议 */
@property (nonatomic, weak) id <RainNetWorkAccessoryProtocol> accessoryDelegate;

/** 重载次数 */
@property (nonatomic, assign) NSUInteger retryCount;

/** 开始网络请求 */
- (void)startRequest;

/**
 停止请求

 @param status 网络状态
 */
- (void)stopRequestByStatus:(RainNetWorkStatus)status;

- (void)stopRequestByResponse:(RainNetWorkResponse *)response;

/**
 添加的插件对象

 @param accessory 必须在请求之前添加插件对象
 */
- (void)addNetWorkAccessoryObject:(id<RainNetWorkAccessoryProtocol>)accessory;

@end
