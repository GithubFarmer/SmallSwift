//
//  TestRequest.h
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/18.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkRequest.h"

@interface TestRequest : RainNetWorkRequest<RainNetWorkRequestConfigProtocol>

@property (nonatomic, copy) NSString *name;

@end
