//
//  RainNetWorkResponse.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkResponse.h"
#import "RainNetWorkServiceProtocol.h"
#import "RainNetWorkConfig.h"

@interface RainNetWorkResponse()

/** 网络接口状态 */
@property (nonatomic, assign, readwrite) RainNetWorkStatus netWorkStatus;

/** 响应的全部数据 */
@property (nonatomic, copy, readwrite) id responseData;

/** 请求的tag值 */
@property (nonatomic, assign, readwrite) NSInteger requestTag;
/** 响应信息  */
@property (nonatomic, copy, readwrite) NSString *responseMessage;

/** 响应的具体数据 */
@property (nonatomic, copy, readwrite) id responseContentData;

/** 响应数据的code值 */
@property (nonatomic, assign, readwrite) NSInteger responseCode;

@property (nonatomic, assign) BOOL isCache;

@end

@implementation RainNetWorkResponse

- (instancetype)initWithResponseData:(id)responseData serviceIdentifierKey:(NSString *)serviceIdentifierKey requestTag:(NSInteger)requestTag networkStatus:(RainNetWorkStatus)networkStatus{
    self = [super init];
    if(self){
        _responseData = responseData;
        _requestTag = requestTag;
        _netWorkStatus = networkStatus;
        
        _responseCode = NSNotFound;
        switch (networkStatus) {
                case RainNetWorkStatusResponseDataSuccess:
                case RainNetWorkStatusDataIncorrect:
                case RainNetWorkStatusDataAuthenticationFail:{
                    NSObject<RainNetWorkServiceProtocol> *servieceObj = [[RainNetWorkConfig shareInstance] serviceObjectWithServiceIdentifier:serviceIdentifierKey];
                    if([responseData isKindOfClass:[NSDictionary class]]){
                        if([servieceObj respondsToSelector:@selector(responseCodeKey)]){
                            _responseCode = [responseData[[servieceObj responseCodeKey]] integerValue];
                        }
                        if([servieceObj respondsToSelector:@selector(responseMessageKey)]){
                            _responseMessage = responseData[[servieceObj responseMessageKey]];
                        }
                        if([servieceObj respondsToSelector:@selector(responseContentDataKey)]){
                            _responseContentData = responseData[[servieceObj responseContentDataKey]];
                        }
                    }
                    
                }
                break;
                
            default:
                _responseMessage = [self responseMessageByNetWorkStatus:networkStatus];
                break;
        }
        
    }
    return self;
}

- (NSString *)responseMessageByNetWorkStatus:(RainNetWorkStatus)netWorkStatus{
    /** 国际化与AFN相同，就此复用 */
    switch (netWorkStatus) {
            case RainNetWorkStatusNotReachale:
                return NSLocalizedStringFromTable(@"网络异常", @"AFNetworking", nil);
            case RainNetWorkStatusRequestParamIncorrect:
                return NSLocalizedStringFromTable(@"请求参数有误", @"AFNetworking", nil);
            case RainNetWorkStatusResponseFail:
                return NSLocalizedStringFromTable(@"系统异常", @"AFNetworking", nil);
        default:
            return nil;
    }
}

@end
