//
//  DeviceTool.m
//  ijkswift
//
//  Created by yuyongquan on 2019/6/11.
//  Copyright © 2019 YTTV. All rights reserved.
//

#import "DeviceTool.h"

@implementation DeviceTool

+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]){
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        //从2开始是因为0，1被参数selector，target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
