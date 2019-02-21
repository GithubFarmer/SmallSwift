//
//  RainNetWorkConfig.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkConfig.h"

@interface RainNetWorkConfig()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject<RainNetWorkServiceProtocol> *> *serviceDictionary;

@end

/** 网络接口配置类 */
@implementation RainNetWorkConfig

+ (instancetype)shareInstance{
    static RainNetWorkConfig *netWorkConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkConfig = [[RainNetWorkConfig alloc]init];
    });
    return netWorkConfig;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _enableDebug = NO;
    }
    return self;
}

-(NSMutableDictionary<NSString *,NSObject<RainNetWorkServiceProtocol> *> *)serviceDictionary{
    if(_serviceDictionary == nil){
        _serviceDictionary = [NSMutableDictionary new];
    }
    return _serviceDictionary;
}

- (NSObject<RainNetWorkServiceProtocol> *)serviceObjectWithServiceIdentifier:(NSString *)serviceIdentifier{
    if(self.serviceDictionary[serviceIdentifier] == nil){
        NSAssert(NO, @"无法找到 %@ 相匹配的服务对象",serviceIdentifier);
    }
    return self.serviceDictionary[serviceIdentifier];
}

- (void)registerServiceObject:(NSObject<RainNetWorkServiceProtocol> *)serviceObject serviceIdentifier:(NSString *)serviceIdentifier{
    if(serviceObject == nil) return;
    NSAssert([serviceObject conformsToProtocol:@protocol(RainNetWorkServiceProtocol)], @"你提供的service没有遵循RainNetWorkServiceProtocol");
    self.serviceDictionary[serviceIdentifier] = serviceObject;
}

@end
