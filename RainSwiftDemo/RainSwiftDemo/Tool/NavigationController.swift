//
//  NavigationController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         UINavigationBar.appearance().setBackgroundImage(UIImage.init(named: "navigationbarBackgroundWhite"), for: UIBarMetrics.default)
        self.navigationBar.barTintColor = UIColor.green;
        self.interactivePopGestureRecognizer?.delegate = nil
        self.navigationBar.isTranslucent = false
    }
    
    //拦截push控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(self.viewControllers.count)
        
       
        
        if self.viewControllers.count < 1 {
            
        }else{
            //添加左边返回按钮
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = backBarButtonItem()
        }
        super.pushViewController(viewController, animated: true)
    }
    
    
    
    //设置返回按钮
    func backBarButtonItem() -> UIBarButtonItem {
        let backButton = UIButton()
        backButton.setImage(UIImage.init(named: "setting_back"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsets.zero
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return UIBarButtonItem.init(customView: backButton)
    }
    
    @objc func backAction() {
        self.popViewController(animated: true)
    }
    
    
}
