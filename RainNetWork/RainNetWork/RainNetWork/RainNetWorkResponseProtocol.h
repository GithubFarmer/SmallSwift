//
//  RainNetWorkResponseProtocol.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RainNetWorkRequest;
@class RainNetWorkResponse;

@protocol RainNetWorkResponseProtocol <NSObject>

@optional
/**
 请求成功的回调
 
 @param request 请求对象
 @param response 响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)request succedeByResponse:(RainNetWorkResponse *)response;

/**
 请求失败的回调
 
 @param request 请求对象
 @param response 响应对象
 */
- (void)netWorkRequest:(RainNetWorkRequest *)request failedeByResponse:(RainNetWorkResponse *)response;


/**
 请求进度的回调
 
 @param request 请求对象
 @param progress 进度
 */
- (void)netWorkRequest:(RainNetWorkRequest *)request requetingByProgress:(NSProgress *)progress;

@end
