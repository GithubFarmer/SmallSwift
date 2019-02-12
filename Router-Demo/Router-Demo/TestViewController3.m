//
//  TestViewController3.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "TestViewController3.h"

@interface TestViewController3 ()

@end

@implementation TestViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试3";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(blocked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)blocked
{
    if (self.clicked){
        self.clicked(@"这个我也不太清楚");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
