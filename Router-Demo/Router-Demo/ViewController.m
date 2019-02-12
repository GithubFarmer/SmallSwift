//
//  ViewController.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "ViewController.h"
#import "MGJRouter.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(60, 70 + 80 * i , 80, 40);
        button.backgroundColor = [UIColor redColor];
        button.tag = 10 + i;
        [button setTitle:[NSString stringWithFormat:@"测试%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushTest:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)pushTest:(UIButton *)sender{
    switch (sender.tag) {
            case 10:{
                [self pushTest1ModuleAction:nil];
            }
            break;
            case 11:{
                [self pushTest2ModuleAction:nil];
            }
            break;
            case 12:{
                [self pushTest3ModuleAction:nil];
            }
            break;
            case 13:{
                [self objectTestAction:nil];
            }
            break;
            
        default:
            break;
    }
}

- (void)pushTest1ModuleAction:(id)sender {
    [MGJRouter openURL:@"LWT://Test1/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController,
                         }
            completion:nil];

}

- (void)pushTest2ModuleAction:(id)sender {
    [MGJRouter openURL:@"LWT://Test2/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController,
                         @"text": @"爱就像蓝天白云晴空万里",
                         }
            completion:nil];
}
- (void)pushTest3ModuleAction:(id)sender {
    [MGJRouter openURL:@"LWT://Test3/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController,
                         @"block":^(NSString * text){
                                    NSLog(@"%@",text);
                                },
                        }
            completion:nil];
}

- (void)objectTestAction:(id)sender {
    [self.navigationController pushViewController:[MGJRouter objectForURL:@"LWT://Test2/getMainVC" withUserInfo:@{@"text" : @"我知道我对你不仅仅是喜欢",}] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
