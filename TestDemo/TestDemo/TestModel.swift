//
//  TestModel.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/6.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit

class TestModel: NSObject {

    var name = ""
    var imageColors = [UIColor]()
    var imageurlList = [String]()
    
    //构建单例
    class var instance : TestModel {
        struct Static {
            static let instant : TestModel = TestModel()
        }
        return Static.instant
    }

    convenience init(na: String , imageUrls: [String]) {
        self.init()
        name = na
        imageurlList = imageUrls
    }
}
