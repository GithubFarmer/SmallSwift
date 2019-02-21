//
//  RainNetWorkServiceProtocol.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/16.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWorkRequestConfigProtocol.h"

@class RainNetWorkRequest;
@protocol RainNetWorkServiceProtocol <NSObject>

@required
/** 设置接口的基础URL */
- (NSString *)serviveApiBaseUrlString;

/** 设置Acceptable-Content */
- (NSSet<NSString *> *)serviceResponseAcceptableContentTypes;


@optional
/** 接口请求序列化类型，默认RainRequestSerializerTypeJSON */
- (RainRequestSerializerType)serviceRequestSerializerType;

/** 接口响应序列化类型，默认RainResponseSerializerTypeJSON */
- (RainResponseSerializerType)serviceResponseSerializerType;

/**
 设置统一的请求头
 
 @return 请求头字典
 */
- (NSDictionary<NSString *, NSString *> *)serviceBaseHTTPRequestHeaders;

/**
 基本请求参数的设定
 
 @return 参数字典
 */
- (NSDictionary<NSString *, NSString *> *)serviceBaseParamSource;

/**
 响应数据的统一验证
 
 @param netWorkRequest 接口请求对象
 @param response 接口响应对象
 @return 是否验证
 */
- (BOOL)serviceBaseAuthenticationWithNetWorkRequest:(RainNetWorkRequest *)netWorkRequest response:(id)response;

/**
 请求失败之后的重试次数，最大设置为3次，默认0次
 
 @return 重试次数
 */
- (NSUInteger)serviceRequestRetryCountWhenFailure;

/**
 请求超时时间
 
 @return 服务的请求超时时间
 */
- (NSTimeInterval)serviceRequestTimeooutInterval;

/**
 响应数据提示信息的key
 
 @return message key
 */
- (NSString *)responseMessageKey;

/**
 响应数据code提示信息的key
 
 @return code key
 */
- (NSString *)responseCodeKey;


/**
 响应数据具体内容的key
 
 @return content key
 */
- (NSString *)responseContentDataKey;

@end
