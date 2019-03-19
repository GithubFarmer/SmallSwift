//
//  UIColor-Extension.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/6.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat){
        self.init(red: r / 225.0, green: g / 225.0, blue: b / 225.0, alpha: 1.0)
    }
    convenience init(count : CGFloat){
        self.init(red: count / 255.0 , green: count / 255.0, blue: count / 255.0, alpha: 1)
    }
    
    class func  randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
