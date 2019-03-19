//
//  UIBarButtonItem-Extension.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/6.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    //便利构造器，定义一个创建UIBarButtonItem的简易方法
    convenience init(imageName : String, highlightedImage : String = "", size : CGSize = CGSize.zero, target: UIViewController, action: Selector){
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        if highlightedImage != "" {
            button.setImage(UIImage.init(named: highlightedImage), for: .highlighted)
        }
        if size != CGSize.zero {
            button.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.zero)
        }else{
            button.sizeToFit()
        }
        button.addTarget(target, action: action, for:.touchUpInside)
        self.init()
    }
}
