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
let kSafeAreaHeight : CGFloat = 34
//屏幕宽度小于400的时候，横屏导航的高度为32
let kNaviHeightOflessThan400 : CGFloat = 32
let kSafeHeightOfHorizon : CGFloat = 21
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
    
    
    // 输出日志
    func log(message: String, function: String, file : String, line : Int){
        print("Message\"\(message)\"(file:\(file),Function:\(function),Line:\(line))")
    }
    
    //RGB色值转UIColor
    func RGB (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat ) -> UIColor{
        return UIColor.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    //获取系统版本及版本判断
    func IOSVersion() -> Double {
        return (UIDevice.current.systemVersion as NSString).doubleValue
    }
    
    //是否大于iOS8.0
    func IS_IOS8() -> Bool{
        return IOSVersion() >= 8.0
    }
    
    //根据类名创建控制器
    func classFromString (className : String) -> UIViewController? {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        let name = "(\(appName!).\(className)"
        if let tmpClass = NSClassFromString(name) as? UIViewController.Type {
            return tmpClass.init()
        }else{
            return nil
        }
    }
    
    //判断字符串是否为空
    func kIsEmpty(string: String) -> Bool{
        if string.isEmpty || string == "" {
            return true
        }else{
            return false
        }
    }
    
    //文字大小设置
    func kFont(name: String, size: CGFloat) -> UIFont {
       if !kIsEmpty(string: name){
            return UIFont.init(name: name, size: size)!
       }else{
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    //屏幕的宽度
    func kIphone_Width() -> CGFloat{
        return UIScreen.main.bounds.width
    }
    
    //屏幕的高度
    func kIphone_Height() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
