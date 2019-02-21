//
//  RainNetWorkAgent.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkAgent.h"
#import <AFNetworking/AFNetworking.h>
#import "RainNetWorkConfig.h"
#import "RainNetWorkRequest.h"
#import "RainNetWorkResponse.h"
#import "RainNetWorkLogger.h"
#import "RainNetWorkRequestConfigProtocol.h"

@interface RainNetWorkAgent()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableDictionary <NSString *, __kindof RainNetWorkRequest *> *requestDict;

@property (nonatomic, strong) NSMutableArray <NSString *> *historyCustomHeaderKeys;

@end

@implementation RainNetWorkAgent

+ (id)shareInstance{
    static RainNetWorkAgent *agent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [RainNetWorkAgent new];
    });
    return agent;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _requestDict = [NSMutableDictionary new];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager{
    if(_sessionManager == nil){
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 4;
        AFJSONResponseSerializer *jsonSerializer = [AFJSONResponseSerializer serializer];
        jsonSerializer.removesKeysWithNullValues = YES;
        _sessionManager.responseSerializer = jsonSerializer;
    }
    return _sessionManager;
}

#pragma mark -
#pragma mark - Getters
- (NSObject<RainNetWorkServiceProtocol> *)serviceObjectByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    NSString *serviceKey = [request.requestConfigProtocol serviceIdentifierKey];
    NSAssert(serviceKey.length, @"没有设置服务标示的key");
    NSObject<RainNetWorkServiceProtocol> *serviceObject = [[RainNetWorkConfig shareInstance] serviceObjectWithServiceIdentifier:serviceKey];
    return serviceObject;
}

- (NSString *)urlStringByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    NSString *detailUrl = @"";
    if([request.requestConfigProtocol respondsToSelector:@selector(requestMethodName)]){
        detailUrl = [request.requestConfigProtocol requestMethodName];
    }
    if([detailUrl hasPrefix:@"http"]){
        return detailUrl;
    }
    NSString *serviceUrlString = nil;
    serviceUrlString = [[self serviceObjectByRequest:request] serviveApiBaseUrlString];
    if([serviceUrlString hasPrefix:@"http"]){
        return [serviceUrlString stringByAppendingPathComponent:detailUrl];
    }else{
        NSLog(@"\n\n\n请设置正确的URL\n\n\n");
        return nil;
    }
}

- (NSDictionary *)requestParamByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    if([request.requestConfigProtocol respondsToSelector:@selector(requestParamDictionary)]){
        NSDictionary *paramDict = [request.requestConfigProtocol requestParamDictionary];
        if(paramDict != nil){
            [tempDict addEntriesFromDictionary:paramDict];
        }
    }
    if(![request.requestConfigProtocol respondsToSelector:@selector(useBaseRequestParamSource)] || [request.requestConfigProtocol useBaseRequestParamSource]){
        NSObject<RainNetWorkServiceProtocol> *serviceObject = [self serviceObjectByRequest:request];
        if([serviceObject respondsToSelector:@selector(serviceBaseParamSource)]){
            NSDictionary *baseRequestParamSource = [serviceObject serviceBaseParamSource];
            if(baseRequestParamSource != nil){
                [tempDict addEntriesFromDictionary:baseRequestParamSource];
            }
        }
    }
    if(tempDict.count == 0){
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:tempDict];
}

- (BOOL)isCorrectByRequestParams:(NSDictionary *)requestParams request:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    if([request.requestConfigProtocol respondsToSelector:@selector(isCorrectWithRequestParams:)]){
        return [request.requestConfigProtocol isCorrectWithRequestParams:requestParams];
    }
    return YES;
}

- (RainRequestHandleSameRequestType)handSameRequestTypeByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    if([request.requestConfigProtocol respondsToSelector:@selector(handleSameRequestType)]){
        return [request.requestConfigProtocol handleSameRequestType];
    }
    return RainRequestHandleSameRequestTypeCancelCurrent;
}

- (RainRequestMethod)requestMethodByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    if([request.requestConfigProtocol respondsToSelector:@selector(requestMethod)]){
        return [request.requestConfigProtocol requestMethod];
    }
    return RainRequestMethodPost;
}

- (NSURLRequestCachePolicy)cachePolicyByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    if([request.requestConfigProtocol respondsToSelector:@selector(cachePolicy)]){
        NSURLRequestCachePolicy cachePolicy = [request.requestConfigProtocol cachePolicy];
        if(cachePolicy == NSURLRequestUseProtocolCachePolicy){
            if([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
                return NSURLRequestReturnCacheDataDontLoad;
            }
            return NSURLRequestUseProtocolCachePolicy;
        }
        return cachePolicy;
    }
    return NSURLRequestReloadIgnoringCacheData;
}


#pragma mark -
#pragma mark - Setters
- (void)setSessionManagerRequestSerializerByRequestSerializerType:(RainRequestSerializerType)requestSerializerType{
    switch (requestSerializerType) {
            case RainRequestSerializerTypeHTTP:
            self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
            case RainRequestSerializerTypeJSON:
            if(![self.sessionManager.requestSerializer isKindOfClass:[AFJSONRequestSerializer class]]){
                self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            }
            break;
            case RainRequestSerializerTypePropertyList:
            if(![self.sessionManager.requestSerializer isKindOfClass:[AFPropertyListRequestSerializer class]]){
                self.sessionManager.requestSerializer = [AFPropertyListRequestSerializer serializer];
            }
            break;
        default:
            break;
    }
}

- (void)setSessionManagerResponseSerializerByResponseSerializerType:(RainResponseSerializerType)responseSerializerType{
    switch (responseSerializerType) {
            case RainResponseSerializerTypeHTTP:
            self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            case RainResponseSerializerTypeJSON:
            if(![self.sessionManager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]){
                self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            }
            break;
            case RainResponseSerializerTypeImage:
            if(![self.sessionManager.responseSerializer isKindOfClass:[AFImageResponseSerializer class]]){
                self.sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
            }
            break;
            case RainResponseSerializerTypeXMLParser:
            if(![self.sessionManager.responseSerializer isKindOfClass:[AFXMLParserResponseSerializer class]]){
                self.sessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            }
            break;
            case RainResponseSerializerTypePropertyList:
            if(![self.sessionManager.responseSerializer isKindOfClass:[AFPropertyListResponseSerializer class]]){
                self.sessionManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
            }
            break;
        default:
            break;
    }
}

- (void)setupSessionManagerRequestSerializerByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    //配置requestSerializerType
    NSObject <RainNetWorkServiceProtocol> *serviceObj = [self serviceObjectByRequest:request];
    RainRequestSerializerType requestSerializerType;
    if([request.requestConfigProtocol respondsToSelector:@selector(requestSerializerType)]){
        requestSerializerType = [request.requestConfigProtocol requestSerializerType];
    }else if ([serviceObj respondsToSelector:@selector(requestSerializerType)]){
        requestSerializerType = [serviceObj serviceRequestSerializerType];
    }else{
        requestSerializerType = RainRequestSerializerTypeHTTP;
    }
    [self setSessionManagerRequestSerializerByRequestSerializerType:requestSerializerType];
    
    //配置请求头
    if(self.historyCustomHeaderKeys.count){
        [self.historyCustomHeaderKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:obj];
        }];
        [self.historyCustomHeaderKeys removeAllObjects];
    }
    
    if(![request.requestConfigProtocol respondsToSelector:@selector(useBaseRequestHeaders)] || [request.requestConfigProtocol useBaseRequestHeaders]){
        if([serviceObj respondsToSelector:@selector(serviceBaseHTTPRequestHeaders)]){
            NSDictionary *requestHeaders = [serviceObj serviceBaseHTTPRequestHeaders];
            [requestHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }
    }
    
    if([request.requestConfigProtocol respondsToSelector:@selector(customHTTPRequestHeaders)]){
        NSDictionary *customRequestHeaders = [request.requestConfigProtocol customHTTPRequestHeaders];
        if(_historyCustomHeaderKeys == nil){
            _historyCustomHeaderKeys = [NSMutableArray new];
        }
        [self.historyCustomHeaderKeys addObjectsFromArray:customRequestHeaders.allKeys];
        [customRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[NSString class]]){
                [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }else if ([obj isKindOfClass:[NSNumber class]]){
                [self.sessionManager.requestSerializer setValue:[(NSNumber *)obj stringValue] forHTTPHeaderField:key];
            }else{
                [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:key];
            }
        }];
    }
    
    //配置请求超时时间
    NSTimeInterval timeoutInterval = 15.0f;
    if([request.requestConfigProtocol respondsToSelector:@selector(requestTimeoutInterval)]){
        timeoutInterval = [request.requestConfigProtocol requestTimeoutInterval];
    }else if ([serviceObj respondsToSelector:@selector(serviceRequestTimeooutInterval)]){
        timeoutInterval = [serviceObj serviceRequestTimeooutInterval];
    }
    self.sessionManager.requestSerializer.timeoutInterval = timeoutInterval;

    //配置responseSerializerType
    RainResponseSerializerType responseSerializer = RainResponseSerializerTypeHTTP;
    if([request.requestConfigProtocol respondsToSelector:@selector(responseSerializerType)]){
        responseSerializer = [request.requestConfigProtocol responseSerializerType];
    }else if ([serviceObj respondsToSelector:@selector(serviceResponseSerializerType)]){
        responseSerializer = [serviceObj serviceResponseSerializerType];
    }
    [self setSessionManagerResponseSerializerByResponseSerializerType:responseSerializer];
    
    if([request.requestConfigProtocol respondsToSelector:@selector(responseAcceptableContentTypes)] && [request.requestConfigProtocol responseAcceptableContentTypes]){
        self.sessionManager.responseSerializer.acceptableContentTypes = [request.requestConfigProtocol responseAcceptableContentTypes];
    }else{
        self.sessionManager.responseSerializer.acceptableContentTypes = [serviceObj serviceResponseAcceptableContentTypes];
    }
    
    //配置请求缓存策略
    self.sessionManager.requestSerializer.cachePolicy = [self cachePolicyByRequest:request];
    
}

- (AFConstuctingBlock)constructingBlockByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    if([request.requestConfigProtocol respondsToSelector:@selector(constructingBodyBlock)]){
        return [request.requestConfigProtocol constructingBodyBlock];
    }
    return nil;
}

- (NSUInteger)retryCountWhenFailureByRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    NSObject <RainNetWorkServiceProtocol> *serviceObj = [self serviceObjectByRequest:request];
    NSUInteger retryCount = 0;
    if([request.requestConfigProtocol respondsToSelector:@selector(requestRetryCountWhenFailure)]){
        retryCount = [request.requestConfigProtocol requestRetryCountWhenFailure];
    }else if ([request.requestConfigProtocol respondsToSelector:@selector(requestRetryCountWhenFailure)]){
        retryCount = [serviceObj serviceRequestRetryCountWhenFailure];
    }
    if(retryCount > 3){
        retryCount = 3;
    }
    return retryCount;
}


#pragma mark -
#pragma mark - 处理Request
- (void)addRequest:(__kindof RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *)request{
    //得到请求的url地址
    NSString *urlString = [self urlStringByRequest:request];
    //得到请求地址的参数
    NSDictionary *paramDict = [self requestParamByRequest:request];
    
    //检查参数配置
    if(![self isCorrectByRequestParams:paramDict request:request]){
        NSLog(@"参数配置有误！请查看isCorrectWithRequestParams：协议方法");
        RainNetWorkResponse *paramIncorrectResponse = [[RainNetWorkResponse alloc]initWithResponseData:nil serviceIdentifierKey:nil requestTag:request.tag networkStatus:RainNetWorkStatusRequestParamIncorrect];
        [request stopRequestByResponse:paramIncorrectResponse];
        if([request.responseDelegate respondsToSelector:@selector(netWorkRequest:failedeByResponse:)]){
            [request.responseDelegate netWorkRequest:request failedeByResponse:paramIncorrectResponse];
        }
        return;
    }
    
    RainRequestHandleSameRequestType handleSameRequestType = [self handSameRequestTypeByRequest:request];
    if(handleSameRequestType != RainRequestHandleSameRequestTypeBothContinue){
        //检查是否存在相同请求方法未完成，并根据协议接口决定是否结束之前的请求
        BOOL isContinuePerform = YES;
        for(RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *requestingObj in self.requestDict.allValues){
            if([[self urlStringByRequest:requestingObj] isEqualToString:urlString]){
                switch (handleSameRequestType) {
                        case RainRequestHandleSameRequestTypeCancelCurrent:
                        isContinuePerform = NO;
                        break;
                        case RainRequestHandleSameRequestTypeCancelPrevious:{
                            RainNetWorkResponse *cancellResponse = [[RainNetWorkResponse alloc]initWithResponseData:nil serviceIdentifierKey:nil requestTag:requestingObj.tag networkStatus:RainNetWorkStatusCancel];
                            [requestingObj stopRequestByResponse:cancellResponse];
                        }
                    default:
                        break;
                }
            }
        }
        
        if(isContinuePerform == NO){
            NSLog(@"\n\n------------有个相同的URL请求未完成，这个请求被取消了（可设置handleSameRequestType）---------------\n\n");
            RainNetWorkResponse *cancelResponse = [[RainNetWorkResponse alloc] initWithResponseData:nil serviceIdentifierKey:nil requestTag:request.tag networkStatus:RainNetWorkStatusCancel];
            [request stopRequestByResponse:cancelResponse];
            return;
        }
    }
    
    //是否打印输出日志
    if([request respondsToSelector:@selector(enableDebugLog)]){
        if([request enableDebugLog]){
            [RainNetWorkLogger logDebugRequestInfoWithURL:urlString httpMethod:[self requestMethodByRequest:request] params:paramDict reachabilityStatus:[[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]];
        }
    }else if ([RainNetWorkConfig shareInstance].enableDebug){
        [RainNetWorkLogger logDebugRequestInfoWithURL:urlString httpMethod:[self requestMethodByRequest:request] params:paramDict reachabilityStatus:[[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]];
    }
    [self setupSessionManagerRequestSerializerByRequest:request];
    
    __weak typeof (self) weakSelf = self;
    __block RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *blockRequest = request;
    switch ([self requestMethodByRequest:request]) {
            case RainRequestMethodGet:{
                request.sessionDataTask = [self.sessionManager GET:urlString parameters:paramDict progress:^(NSProgress * _Nonnull downloadProgress) {
                    [weakSelf handleRequestProgress:downloadProgress request:request];
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [weakSelf handleRequestSuccess:task responseObject:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [weakSelf handleRequestFailure:task error:error];
                }];
            }
            break;
            case RainRequestMethodPost:{
                AFConstuctingBlock constructBlock = [self constructingBlockByRequest:request];
                if(constructBlock){//上传图片
                    request.sessionDataTask = [self.sessionManager POST:urlString parameters:paramDict constructingBodyWithBlock:constructBlock progress:^(NSProgress * _Nonnull uploadProgress) {
                        [weakSelf handleRequestProgress:uploadProgress request:blockRequest];
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [weakSelf handleRequestSuccess:task responseObject:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [weakSelf handleRequestFailure:task error:error];
                    }];
                }else{
                    request.sessionDataTask = [self.sessionManager POST:urlString parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
                        [weakSelf handleRequestProgress:uploadProgress request:blockRequest];
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [weakSelf handleRequestSuccess:task responseObject:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [weakSelf handleRequestFailure:task error:error];
                    }];
                }
            }
            break;
        default:
            break;
    }
    [self addRequestObject:request];
}

- (void)removeRequest:(__kindof RainNetWorkRequest *)request{
    if(request.sessionDataTask == nil) return;
    [request.sessionDataTask cancel];
    NSString *taskKey = [self keyForSessionDataTask:request.sessionDataTask];
    @synchronized(self){
        [_requestDict removeObjectForKey:taskKey];
    }
}

#pragma mark -
#pragma mark - 处理响应结果
- (void)beforePerformFailWithResponse:(RainNetWorkResponse *)response request:(RainNetWorkRequest *)request{
    if([request.interceptorDelegate respondsToSelector:@selector(netWorkRequest:beforePerformFailWithResponse:)]){
        [request.interceptorDelegate netWorkRequest:request beforePerformFailWithResponse:response];
    }
}

- (void)afterPerformFailWithResponse:(RainNetWorkResponse *)response request:(RainNetWorkRequest *)request{
    if([request.interceptorDelegate respondsToSelector:@selector(afterPerformFailWithResponse:request:)]){
        [request.interceptorDelegate netWorkRequest:request afterPerformFailWithResponse:response];
    }
}

- (void)handleRequestProgress:(NSProgress *)progress request:(RainNetWorkRequest <RainNetWorkRequestConfigProtocol> *)request{
    //请求的进度监控协议代理
    if([request.responseDelegate respondsToSelector:@selector(netWorkRequest:requetingByProgress:)]){
        [request.responseDelegate netWorkRequest:request requetingByProgress:progress];
    }
}

- (void)handleRequestSuccess:(NSURLSessionDataTask *)sessionDataTask responseObject:(id)response{
    NSString *taskKey = [self keyForSessionDataTask:sessionDataTask];
    RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *request = _requestDict[taskKey];
    if(request == nil){
        NSLog(@"\n\n--------------请求实例被意外释放------------------\n\n");
        return;
    }
    
    //重试次数
    request.retryCount = 0;
    
    BOOL isAuthentication = YES;
    if(![request.requestConfigProtocol respondsToSelector:@selector(useBaseAuthentication)] || [request.requestConfigProtocol useBaseAuthentication]){
        NSObject<RainNetWorkServiceProtocol> *serviceObj = [self serviceObjectByRequest:request];
        if([serviceObj respondsToSelector:@selector(serviceBaseAuthenticationWithNetWorkRequest:response:)]){
            isAuthentication = [serviceObj serviceBaseAuthenticationWithNetWorkRequest:request response:response];
        }
    }
    
    if(isAuthentication && [request.requestConfigProtocol isCorrectWithResponseData:response]){
        RainNetWorkResponse *sucessResponse = [[RainNetWorkResponse alloc]initWithResponseData:response serviceIdentifierKey:[request serviceIdentifierKey] requestTag:request.tag networkStatus:RainNetWorkStatusResponseDataSuccess];
        [request stopRequestByResponse:sucessResponse];
        
        //在成功之前
        if([request.interceptorDelegate respondsToSelector:@selector(netWorkRequest:beforePerformSuccessWithResponse:)]){
            [request.interceptorDelegate netWorkRequest:request beforePerformSuccessWithResponse:response];
        }
        if([request.responseDelegate respondsToSelector:@selector(netWorkRequest:succedeByResponse:)]){
            [request.responseDelegate netWorkRequest:request succedeByResponse:response];
        }
        //在成功之后用
        if([request.interceptorDelegate respondsToSelector:@selector(netWorkRequest:afterPerformSuccessWithResponse:)]){
            [request.interceptorDelegate netWorkRequest:request afterPerformSuccessWithResponse:response];
        }
    }else{
        RainNetWorkStatus failSatatus = isAuthentication ? RainNetWorkStatusDataIncorrect : RainNetWorkStatusDataAuthenticationFail;
        RainNetWorkResponse *dataErrorResponse = [[RainNetWorkResponse alloc] initWithResponseData:response serviceIdentifierKey:[request serviceIdentifierKey] requestTag:request.tag networkStatus:failSatatus];
        [request stopRequestByResponse:dataErrorResponse];
        [self beforePerformFailWithResponse:dataErrorResponse request:request];
        if([request.responseDelegate respondsToSelector:@selector(netWorkRequest:failedeByResponse:)]){
            [request.responseDelegate netWorkRequest:request failedeByResponse:response];
        }
    }
    
    if([request respondsToSelector:@selector(enableDebug)]){
        if([request enableDebugLog]){
            [RainNetWorkLogger logDebugResponseInfoWithSesssionDataTask:sessionDataTask responseObject:response authentication:isAuthentication error:nil];
        }
    }else if ([RainNetWorkConfig shareInstance].enableDebug){
        [RainNetWorkLogger logDebugResponseInfoWithSesssionDataTask:sessionDataTask responseObject:response authentication:isAuthentication error:nil];
    }
}


- (void)handleRequestFailure:(NSURLSessionDataTask *)sessionDataTask error:(NSError *)error{
    NSString *taskKey = [self keyForSessionDataTask:sessionDataTask];
    RainNetWorkRequest<RainNetWorkRequestConfigProtocol> *request = _requestDict[taskKey];
    if(request == nil){
        NSLog(@"\n\n---------请求实例被意外释放------------\n\n");
        return;
    }
    
    //请求失败时重试
    NSUInteger retryCount = [self retryCountWhenFailureByRequest:request];
    if(request.retryCount < retryCount){
        [self removeRequest:request];
        request.retryCount++;
        [self performSelector:@selector(addRequest:) withObject:request afterDelay:2.0f];
    }
    
    //失败状态的矫正
    RainNetWorkStatus failStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable ? RainNetWorkStatusNotReachale : RainNetWorkStatusResponseFail;
    RainNetWorkResponse *failResponse = [[RainNetWorkResponse alloc]initWithResponseData:nil serviceIdentifierKey:[request serviceIdentifierKey] requestTag:request.tag networkStatus:failStatus];
    [self beforePerformFailWithResponse:failResponse request:request];
    if([request.responseDelegate respondsToSelector:@selector(netWorkRequest:failedeByResponse:)]){
        [request.responseDelegate netWorkRequest:request failedeByResponse:failResponse];
    }
    [self afterPerformFailWithResponse:failResponse request:request];
    
    //请求日志输出
    if([request respondsToSelector:@selector(enableDebugLog)]){
        if([request enableDebugLog]){
            [RainNetWorkLogger logDebugResponseInfoWithSesssionDataTask:sessionDataTask responseObject:nil authentication:NO error:error];
        }
    }else if ([RainNetWorkConfig shareInstance].enableDebug){
        [RainNetWorkLogger logDebugResponseInfoWithSesssionDataTask:sessionDataTask responseObject:nil authentication:NO error:error];
    }
}



#pragma mark -
#pragma mark - 请求处理
- (NSString *)keyForSessionDataTask:(NSURLSessionDataTask *)sessionDataTask{
    return [@(sessionDataTask.taskIdentifier) stringValue];
}

- (void)addRequestObject:(__kindof RainNetWorkRequest <RainNetWorkRequestConfigProtocol> *)request{
    if(request.sessionDataTask == nil) return;
    NSString *taskKey = [self keyForSessionDataTask:request.sessionDataTask];
    @synchronized(self){
        _requestDict[taskKey] = request;
    }
}
@end
