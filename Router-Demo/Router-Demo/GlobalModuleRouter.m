//
//  GlobalModuleRouter.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "GlobalModuleRouter.h"
#import "MGJRouter.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "TestViewController3.h"

@implementation GlobalModuleRouter

// 在load方法中自动注册，在主工程中不用写任何代码。
+ (void)load {
    
    [MGJRouter registerURLPattern:@"LWT://Test1/PushMainVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        TestViewController1 *vc = [[TestViewController1 alloc] init];
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    
    [MGJRouter registerURLPattern:@"LWT://Test2/PushMainVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        NSString *labelText = routerParameters[MGJRouterParameterUserInfo][@"text"];
        TestViewController2 *vc = [[TestViewController2 alloc] init];
        vc.labelText = labelText;
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    [MGJRouter registerURLPattern:@"LWT://Test3/PushMainVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        void(^block)(NSString *) = routerParameters[MGJRouterParameterUserInfo][@"block"];
        TestViewController3 *vc = [[TestViewController3 alloc] init];
        vc.clicked = block;
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    
    [MGJRouter registerURLPattern:@"LWT://Test2/getMainVC" toObjectHandler:^id(NSDictionary *routerParameters) {
        NSString *labelText = routerParameters[MGJRouterParameterUserInfo][@"text"];
        TestViewController2 *vc = [[TestViewController2 alloc] init];
        vc.labelText = labelText;
        return vc;
    }];
    
}


@end
