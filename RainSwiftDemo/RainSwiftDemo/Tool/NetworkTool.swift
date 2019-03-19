//
//  NetworkTool.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/6.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTool: NSObject {
    class func request(type:MethodType, urlString: String, paramaters:[String : Any]? = nil, finishedCallback:@escaping (_ result: Any) -> ()){
        //获取类型
        let method = (type == .GET ? HTTPMethod.get : HTTPMethod.post)
        //发送网络请求
        Alamofire.request(urlString, method: method, parameters: paramaters).responseJSON { (DataResponse) in
            //作为一个判断语句使用，作用类似于断句
            guard let result = DataResponse.result.value else {
                print(DataResponse.result.error)
                return
            }
            //回调结果
            finishedCallback(result)
        }
    }
}
