//
//  RainNetWorkRequestConfigProtocol.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RainNetWork.h"
#import <AFNetworking/AFURLRequestSerialization.h>

/** 网络请求方式 */
typedef NS_ENUM(NSInteger, RainRequestMethod) {
    /** post请求 */
    RainRequestMethodPost,
    /** get请求 */
    RainRequestMethodGet
};

/** 请求序列化类型 */
typedef NS_ENUM(NSInteger, RainRequestSerializerType) {
    /** http */
    RainRequestSerializerTypeHTTP,
    /** json */
    RainRequestSerializerTypeJSON,
    /** plist */
    RainRequestSerializerTypePropertyList
};

/** 响应数据序列化类型 */
typedef NS_ENUM(NSInteger, RainResponseSerializerType) {
    /** json */
    RainResponseSerializerTypeJSON,
    /** http */
    RainResponseSerializerTypeHTTP,
    /** xml */
    RainResponseSerializerTypeXMLParser,
    /** plist */
    RainResponseSerializerTypePropertyList,
    /** image */
    RainResponseSerializerTypeImage
};

typedef NS_ENUM(NSInteger, RainRequestHandleSameRequestType) {
    /** 取消当前的请求 */
    RainRequestHandleSameRequestTypeCancelCurrent,
    /** 取消已经启动的请求 */
    RainRequestHandleSameRequestTypeCancelPrevious,
    /** 两者同时进行 */
    RainRequestHandleSameRequestTypeBothContinue
};

/** 上传数据构造的block */
typedef void (^AFConstuctingBlock)(id<AFMultipartFormData> formData);

/** 接口请求配置协议 */
@protocol RainNetWorkRequestConfigProtocol <NSObject>

@required
/** 属于那个服务，设置key */
- (NSString *)serviceIdentifierKey;

/** 请求地址 */
- (NSString *)requestMethodName;

/**
 检查数据返回是否正确
 
 @param responseData 返回的完整数据
 @return 是否正确
 */
- (BOOL)isCorrectWithResponseData:(id)responseData;


@optional
/** 请求方式，默认为post请求 */
- (RainRequestMethod)requestMethod;

/** 请求参数字典 */
- (NSDictionary *)requestParamDictionary;

/** 定制缓存策略 */
- (NSURLRequestCachePolicy)cachePolicy;

/** 情趣失败之后的重试次数，默认为0 */
- (NSUInteger)requestRetryCountWhenFailure;

/** 请求超时时间 */
- (NSTimeInterval)requestTimeoutInterval;

/** 检查请求参数 */
- (BOOL)isCorrectWithRequestParams:(NSDictionary *)params;

/** 接口请求的数据类型 */
- (RainRequestSerializerType)requestSerializerType;

/** 服务端返回的数据类型 */
- (RainResponseSerializerType)responseSerializerType;

/** 响应接受内容的类型 */
- (NSSet <NSString *>*)responseAcceptableContentTypes;

/** 处理正在执行相同方法的请求（参数可能不同），默认取消将要启动的请求RainRequestHandleSameRequestTypeCancelCurrent */
- (RainRequestHandleSameRequestType)handleSameRequestType;

/** 当post的内容带有文件等富文本时使用 */
- (AFConstuctingBlock)constructingBodyBlock;

/** 是否使用baseHTTPRequestHeaders */
- (BOOL)useBaseRequestHeaders;

/** 是否使用基础参数 */
- (BOOL)useBaseRequestParamSource;

/** 定制请求头 */
- (NSDictionary *)customHTTPRequestHeaders;

/** 是否使用基础的请求验证 */
- (BOOL)useBaseAuthentication;

/** 是否输出log日志 */
- (BOOL)enableDebugLog;


@end
