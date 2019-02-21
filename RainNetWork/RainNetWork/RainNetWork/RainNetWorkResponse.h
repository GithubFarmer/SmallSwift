//
//  RainNetWorkResponse.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWork.h"

@interface RainNetWorkResponse : NSObject

/** 网络接口状态 */
@property (nonatomic, assign, readonly) RainNetWorkStatus netWorkStatus;

/** 响应的全部数据 */
@property (nonatomic, copy, readonly) id responseData;

/** 请求的tag值 */
@property (nonatomic, assign, readonly) NSInteger requestTag;


/**
 初始化网络接口的响应对象

 @param responseData 响应的原始数据
 @param serviceIdentifierKey 服务配置对象的存储标示
 @param requestTag 接口的请求tag
 @param networkStatus 接口网络状态
 @return 响应对象
 */
- (instancetype)initWithResponseData:(id)responseData
                serviceIdentifierKey:(NSString *)serviceIdentifierKey
                          requestTag:(NSInteger)requestTag
                       networkStatus:(RainNetWorkStatus)networkStatus;

/** 响应信息  */
@property (nonatomic, copy, readonly) NSString *responseMessage;

/** 响应的具体数据 */
@property (nonatomic, copy, readonly) id responseContentData;

/** 响应数据的code值 */
@property (nonatomic, assign, readonly) NSInteger responseCode;

@end
