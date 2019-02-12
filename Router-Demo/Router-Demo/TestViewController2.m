//
//  TestViewController2.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "TestViewController2.h"

@interface TestViewController2 ()

@end

@implementation TestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试2";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    label.text = self.labelText;
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
