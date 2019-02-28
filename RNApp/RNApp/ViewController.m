//
//  ViewController.m
//  RNApp
//
//  Created by 喻永权 on 2019/2/27.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "ViewController.h"

#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 80, 40);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"RNDemo" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
}

- (void)press{
    NSLog(@"RN start...........");
    //第一种获取url的方式
    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/ios.index.bundle?platform=ios"];
    //http://localhost:8081/ios.index.bundle?platform=ios
    NSLog(@"url:%@",url);
    
    
    //第二种获取url的方式
    NSURL *defaultUrl = [[RCTBundleURLProvider sharedSettings]jsBundleURLForBundleRoot:@"ios.index" fallbackResource:@"js"];
    //http://localhost:8081/ios.index.bundle?platform=ios&dev=true&minify=false
    NSLog(@"===>>%@",defaultUrl);
    
    RCTRootView *rootView = [[RCTRootView alloc]initWithBundleURL:defaultUrl moduleName:@"RNApp" initialProperties:nil launchOptions:nil];
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
