//
//  RainNetWorkConfig.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWorkServiceProtocol.h"

@interface RainNetWorkConfig : NSObject

/** 是否打开debug日志，默认关闭 */
@property (nonatomic, assign) BOOL enableDebug;

+ (instancetype)shareInstance;


/**
 获取网络接口不同服务配置对象

 @param serviceIdentifier 服务配置对象的存储标示
 @return 服务配置对象
 */
- (NSObject<RainNetWorkServiceProtocol> *)serviceObjectWithServiceIdentifier:(NSString *)serviceIdentifier;

/**
 设置网络接口所需的服务配置对象

 @param serviceObject 服务配置对象
 @param serviceIdentifier 服务配置对象的存储标示
 */
- (void)registerServiceObject:(NSObject<RainNetWorkServiceProtocol> *)serviceObject serviceIdentifier:(NSString *)serviceIdentifier;

@end
