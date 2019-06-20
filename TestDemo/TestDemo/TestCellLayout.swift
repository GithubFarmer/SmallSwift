//
//  TestCellLayout.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/12.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit

let padding : CGFloat = 10


class TestCellLayout: NSObject {

    var model : TestModel?
    var height : CGFloat = 0
    var picturesSize : CGSize?
    
    convenience init(mod : TestModel) {
        self.init()
        model = mod
        resetLayout()
    }
    
    func resetLayout() {
        height = 50
        height = height + padding
        let imagesSize = RainPhotoContainerView.getContainerSizeWithPicPaths(paths: model!.imageurlList)
        picturesSize = imagesSize
        height = height + imagesSize.height
    }

}
