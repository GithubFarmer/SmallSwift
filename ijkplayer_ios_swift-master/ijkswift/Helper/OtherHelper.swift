//
//  OtherHelper.swift
//  ijkswift
//
//  Created by yuyongquan on 2019/6/11.
//  Copyright © 2019 YTTV. All rights reserved.
//

import UIKit

class OtherHelper: NSObject {

    //横竖屏幕切换
    func setNewOrientation(fullScreen: Bool){
        if fullScreen { // 横屏
            let resetOrientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }else{
            let resetOrientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
}
