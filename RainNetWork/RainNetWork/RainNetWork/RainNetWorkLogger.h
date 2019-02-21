//
//  RainNetWorkLogger.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 接口日志打印输出类 */
@interface RainNetWorkLogger : NSObject


/**
 接口请求信息日志输出方法

 @param url 请求url
 @param httpMethod 请求方式
 @param params 请求参数
 @param reachabilityStatus 网络状态
 */
+ (void)logDebugRequestInfoWithURL:(NSString *)url httpMethod:(NSInteger)httpMethod
                            params:(NSDictionary *)params reachabilityStatus:(NSInteger)reachabilityStatus;


/**
 接口响应信息日志输出方法

 @param sessionDataTask 执行请求的sessionDataTask
 @param response 响应数据
 @param authentication 是否通过验证
 @param error error对象
 */
+ (void)logDebugResponseInfoWithSesssionDataTask:(NSURLSessionDataTask *)sessionDataTask
                                  responseObject:(id)response
                                  authentication:(BOOL)authentication
                                           error:(NSError *)error;

@end
