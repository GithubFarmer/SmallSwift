//
//  ViewController.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "ViewController.h"
#import "TestRequest.h"

@interface ViewController ()<RainNetWorkResponseProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestRequest *request = [[TestRequest alloc]init];
    request.responseDelegate = self;
    request.name = @"Love";
    [request startRequest];
}

- (void)netWorkRequest:(RainNetWorkRequest *)request succedeByResponse:(RainNetWorkResponse *)response{
    
}

- (void)netWorkRequest:(RainNetWorkRequest *)request failedeByResponse:(RainNetWorkResponse *)response{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
