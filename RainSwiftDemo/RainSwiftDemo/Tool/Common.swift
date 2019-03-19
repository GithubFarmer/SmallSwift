//
//  Common.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 49
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
class Common: NSObject {

    //创建一个barButtonItem
    class func itemWithImage(_ image : UIImage, highLightIamge : UIImage, target : UIViewController, action : Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(highLightIamge, for: .highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
    
}
