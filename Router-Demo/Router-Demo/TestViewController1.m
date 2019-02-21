//
//  TestViewController1.m
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "TestViewController1.h"
#import "NSDate+kExtend.h"

@interface TestViewController1 ()

@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    //得到今天
    NSString *today = [NSDate today];
    //得出今天是星期几
    NSString *weekName = [[[NSDate alloc]init] weekWithDateString:today];
    NSLog(@"==%@===today:%@",weekName,today);

    //第一种获取星期的方式
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"EEEE"];
    NSString *name = [df stringFromDate:now];
    NSLog(@"星期:%@",name);
    
    
    //第二种获取星期的方式
    //日历的算法
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:now];
    NSNumber *weekNumber = @([comps weekday] - 1);
    NSLog(@"comps:==%@  week:星期%@",comps,weekNumber);
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
