//
//  RainNetWorkAgent.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RainNetWorkRequest;
@protocol RainNetWorkServiceProtocol;

@interface RainNetWorkAgent : NSObject

+ (id)shareInstance;

/** 添加请求到请求栈中 */
- (void)addRequest:(__kindof RainNetWorkRequest *)request;

/** 移除请求 */
- (void)removeRequest:(__kindof RainNetWorkRequest *)request;

@end
