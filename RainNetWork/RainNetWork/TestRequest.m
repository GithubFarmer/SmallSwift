//
//  TestRequest.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/18.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "TestRequest.h"

@implementation TestRequest
- (NSString *)serviceIdentifierKey{
    return @"com.wwwarehouse";
}
- (NSString *)requestMethodName{
    return @"http:baidu.com";
}
- (BOOL)isCorrectWithResponseData:(id)responseData{
    if([responseData[@"code"] integerValue] == 0){
        return YES;
    }
    return NO;
}

- (RainRequestSerializerType)requestSerializerType{
    return RainRequestSerializerTypeJSON;
}

- (RainResponseSerializerType)responseSerializerType{
    return RainResponseSerializerTypeJSON;
}

- (NSDictionary *)requestParamDictionary{
    return @{@"data":@{@"name":self.name}};
}

- (BOOL)enableDebugLog{
    return YES;
}
@end
