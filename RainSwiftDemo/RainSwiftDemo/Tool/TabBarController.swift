//
//  TabBarController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController()
        // 设置tabBar字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for:.selected)
        tabBar.isTranslucent = false
    }
    
    //添加所有子控制器
    func addChildViewController() {
        setUpController("首页",image:"menu_homepage_nor",selectImage:"menu_homepage_sel",
                        controller:ShouYeViewController())
        setUpController("游戏", image: "menu_youxi_nor", selectImage: "menu_youxi_sel",
                        controller: GameViewController())
        setUpController("娱乐", image: "menu_yule_nor", selectImage: "menu_yule_sel",
                        controller: YuLeViewController())
        setUpController("小葱秀", image:"menu_goddess_nor", selectImage: "menu_goddess_sel",
                        controller: XiaoCongXiuViewController())
        setUpController("我", image: "menu_mine_nor", selectImage: "menu_mine_sel",
                        controller: MeViewController())
    }
    
    fileprivate func setUpController(_ title : String, image : String, selectImage : String, controller : UIViewController) {
        controller.tabBarItem.title = title
        controller.title = title
        controller.view.backgroundColor = UIColor.init(count: 244)
        controller.tabBarItem.image = UIImage.init(named: image)
        controller.tabBarItem.selectedImage = UIImage.init(named: selectImage)
        let navigationController = NavigationController.init(rootViewController: controller)
        addChild(navigationController)
    }
    
}
