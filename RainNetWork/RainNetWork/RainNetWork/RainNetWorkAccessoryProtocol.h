//
//  RainNetWorkAccessoryProtocol.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWork.h"
#import "RainNetWorkResponse.h"

/** 请求插件协议 */
@protocol RainNetWorkAccessoryProtocol <NSObject>

@optional

/** 请求将要开始 */
- (void)netWorkRequestWillStart;

/** 请求已经开始 */
- (void)netWorkRequestDidStart;

/** 请求完成之后的状态 */
- (void)netWorkRequestByStatus:(RainNetWorkStatus)networkStatus;

/** 请求完成请求之后的数据回调 */
- (void)networkRequestDidEndByResponse:(RainNetWorkResponse *)response;

@end
