//
//  TestViewController3.h
//  Router-Demo
//
//  Created by 喻永权 on 2019/2/12.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void(^btnClickBlock)(NSString *);

@interface TestViewController3 : UIViewController
@property (nonatomic, copy)btnClickBlock clicked;
@end
