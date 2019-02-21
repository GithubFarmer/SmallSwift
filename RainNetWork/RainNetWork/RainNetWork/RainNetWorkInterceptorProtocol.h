//
//  RainNetWorkInterceptorProtocol.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RainNetWorkRequest;
@class RainNetWorkResponse;

@protocol RainNetWorkInterceptorProtocol <NSObject>

@optional

/**
 请求成功之前调用

 @param netWorkRequest 网络接口请求对象
 @param netWorkResponse 网络接口响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)netWorkRequest beforePerformSuccessWithResponse:(RainNetWorkResponse *)netWorkResponse;

/**
 请求成功之后调用
 
 @param netWorkRequest 网络接口请求对象
 @param netWorkResponse 网络接口响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)netWorkRequest afterPerformSuccessWithResponse:(RainNetWorkResponse *)netWorkResponse;

/**
 请求失败之前调用
 
 @param netWorkRequest 网络接口请求对象
 @param netWorkResponse 网络接口响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)netWorkRequest beforePerformFailWithResponse:(RainNetWorkResponse *)netWorkResponse;

/**
 请求失败之后调用
 
 @param netWorkRequest 网络接口请求对象
 @param netWorkResponse 网络接口响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)netWorkRequest afterPerformFailWithResponse:(RainNetWorkResponse *)netWorkResponse;


@end
