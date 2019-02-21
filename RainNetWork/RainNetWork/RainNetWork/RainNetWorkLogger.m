//
//  RainNetWorkLogger.m
//  RainNetWork
//
//  Created by 喻永权 on 2019/2/15.
//  Copyright © 2019年 喻永权. All rights reserved.
//

#import "RainNetWorkLogger.h"

@implementation RainNetWorkLogger

+ (void)logDebugRequestInfoWithURL:(NSString *)url httpMethod:(NSInteger)httpMethod params:(NSDictionary *)params reachabilityStatus:(NSInteger)reachabilityStatus{
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n***********************************\n*             Request              *\n******************************\n"];
    [logString appendFormat:@"URL:\t\t\t%@\n",url];
    [logString appendFormat:@"Method:\t\t\t%@\n",httpMethod == 0 ? @"POST" :@"GET"];
    [logString appendFormat:@"Params:\t\t\t%@\n",params.count ? params : @""];
    NSString *netReachability = nil;
    switch (reachabilityStatus) {
            case 2:
            netReachability = @"@WIFI";
            break;
            case 1:
            netReachability = @"2G/3G/4G";
            break;
            case 0:
            netReachability = @"NOT REACHABLE";
            break;
        default:
            netReachability = @"UNKNOWM";
            break;
    }
    [logString appendFormat:@"NET:\t\t\t\t%@",netReachability];
    [logString appendString:@"\n\n***********************************\n*             Request End             *\n******************************\n"];
    NSLog(@"%@",logString);
}

+ (void)logDebugResponseInfoWithSesssionDataTask:(NSURLSessionDataTask *)sessionDataTask responseObject:(id)response authentication:(BOOL)authentication error:(NSError *)error{
    NSMutableString *logString  = [NSMutableString stringWithString:@"\n\n***********************************\n*             Response              *\n******************************\n"];
    BOOL logError = error ? YES : NO;
    if(logError){
        [logString appendFormat:@"Error Domain:\t\t\t\t%@\n",error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t%ld\n",(long)error.code];
        [logString appendFormat:@"Error localized Description:\t\t\t%@\n",error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n",error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggedstion:\t%@\n\n",error.localizedRecoverySuggestion];
    }else{
        [logString appendFormat:@"Authentication:\t\t%@\n\n",authentication ? @"pass" : @"error"];
    }
    [logString appendFormat:@"Response:\t\t\t%@",response];
    if([(NSHTTPURLResponse *)sessionDataTask.response statusCode] != 200){
        [logString appendFormat:@"\n\nHTTP Header:\n\t%@",sessionDataTask.currentRequest.allHTTPHeaderFields];
        if(sessionDataTask.currentRequest.HTTPBody){
            [logString appendFormat:@"\n\nHTTP Body:\n\t%@",[[NSString alloc]initWithData:sessionDataTask.currentRequest.HTTPBody encoding:NSUTF8StringEncoding]];
        }
    }
    [logString appendFormat:@"\n\n***********************************\n*             Response  End           *\n******************************\n"];
    NSLog(@"%@",logString);
}

@end
