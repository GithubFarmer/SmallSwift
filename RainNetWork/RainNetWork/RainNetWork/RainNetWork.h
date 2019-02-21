//
//  RainNetWork.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#ifndef RainNetWork_h
#define RainNetWork_h

typedef NS_ENUM(NSInteger, RainNetWorkStatus) {
    /** 请求被取消 */
    RainNetWorkStatusCancel,
    /** 网络不可到达 */
    RainNetWorkStatusNotReachale,
    /** 请求参数错误 */
    RainNetWorkStatusRequestParamIncorrect,
    /** 请求失败 */
    RainNetWorkStatusResponseFail,
    /** 请求返回的数据错误 */
    RainNetWorkStatusDataIncorrect,
    /** 请求返回的数据没有通过验证 */
    RainNetWorkStatusDataAuthenticationFail,
    /** 请求成功 */
    RainNetWorkStatusResponseDataSuccess
};

#endif /* RainNetWork_h */
