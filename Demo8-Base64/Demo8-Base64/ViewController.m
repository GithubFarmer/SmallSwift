//
//  ViewController.m
//  Demo8-Base64
//
//  Created by 喻永权 on 2019/2/14.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *string = @"yuyongquan-love-tangguoguo";
    NSString *base64Encode = [GTMBase64 encodeBase64String:string];
    NSString *base64Decode = [GTMBase64 decodeBase64String:base64Encode];
    NSLog(@"\n ====string:%@ \n =====>base64Encode:%@ \n =====>base64Decode:%@",string,base64Encode,base64Decode);
    NSString *MD5_Base64 = [GTMBase64 md5_base64:string];
    NSLog(@"=====>MD5_Base64:%@",MD5_Base64);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
