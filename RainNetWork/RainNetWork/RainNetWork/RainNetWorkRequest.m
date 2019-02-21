//
//  RainNetWorkRequest.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkRequest.h"
#import "RainNetWorkAgent.h"
#import "RainNetWorkResponse.h"

@interface RainNetWorkRequest()

@property (nonatomic, weak) id <RainNetWorkRequestConfigProtocol> requestConfigProtocol;
@property (nonatomic, strong) NSMutableArray *accessoryArray;

@end


@implementation RainNetWorkRequest

- (instancetype)init{
    self = [super init];
    if(self){
        if([self conformsToProtocol:@protocol(RainNetWorkRequestConfigProtocol)]){
            _requestConfigProtocol = (id <RainNetWorkRequestConfigProtocol>) self;
        }else{
            NSAssert(NO, @"子类必须实现RainNetWorkRequestConfigProtocol协议");
        }
    }
    return self;
}

- (void)startRequest{
    [self accessoryWillStart];
    //请求管理类添加请求
    [[RainNetWorkAgent shareInstance] addRequest:self];
    [self accessoryDidStart];
}

- (void)stopRequestByStatus:(RainNetWorkStatus)status{
    //请求管理类停止请求
    [[RainNetWorkAgent shareInstance] removeRequest:self];
    RainNetWorkResponse *cancelResponse = [[RainNetWorkResponse alloc]initWithResponseData:nil serviceIdentifierKey:nil requestTag:self.tag networkStatus:RainNetWorkStatusCancel];
    [self accessoryFinishByResponse:cancelResponse];
}

- (void)stopRequestByResponse:(RainNetWorkResponse *)response{
    //请求管理类停止请求
     [[RainNetWorkAgent shareInstance] removeRequest:self];
    [self accessoryFinishByResponse:response];
}

- (void)dealloc{
     [[RainNetWorkAgent shareInstance] removeRequest:self];
}

#pragma mark -
#pragma mark - 添加插件
- (void)addNetWorkAccessoryObject:(id<RainNetWorkAccessoryProtocol>)accessory{
    if(accessory == nil) return;
    if(_accessoryArray == nil){
        _accessoryArray = [NSMutableArray new];
    }
    [self.accessoryArray addObject:accessory];
}

- (void)accessoryWillStart{
    for(id<RainNetWorkAccessoryProtocol> accessory in self.accessoryArray){
        if([accessory respondsToSelector:@selector(netWorkRequestWillStart)]){
            [accessory netWorkRequestWillStart];
        }
    }
}

- (void)accessoryDidStart{
    for(id<RainNetWorkAccessoryProtocol> accessory in self.accessoryArray){
        if([accessory respondsToSelector:@selector(netWorkRequestDidStart)]){
            [accessory netWorkRequestDidStart];
        }
    }
}

- (void)accessoryFinishByResponse:(RainNetWorkResponse *)response{
    for(id<RainNetWorkAccessoryProtocol> accessory in self.accessoryArray){
        if([accessory respondsToSelector:@selector(networkRequestDidEndByResponse:)]){
            [accessory networkRequestDidEndByResponse:response];
        }
        if([accessory respondsToSelector:@selector(netWorkRequestByStatus:)]){
            [accessory netWorkRequestByStatus:response.netWorkStatus];
        }
    }
}



@end
