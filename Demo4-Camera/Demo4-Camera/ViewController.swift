//
//  ViewController.swift
//  Demo4-Camera
//
//  Created by 喻永权 on 2019/1/4.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.isStatusBarHidden = true
        scrollView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize.init(width: view.frame.width * 3, height: view.frame.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        let leftVC = LeftController()
        let centerVC = CenterController()
        let rightVC = RightController()
        
        self.addChildViewController(leftVC)
        self.addChildViewController(centerVC)
        self.addChildViewController(rightVC)
        
        scrollView.addSubview(leftVC.view)
        scrollView.addSubview(centerVC.view)
        scrollView.addSubview(rightVC.view)
        
        //中间vc坐标
        var centerViewFrame : CGRect = centerVC.view.frame
        centerViewFrame.origin.x = view.frame.width
        centerVC.view.frame = centerViewFrame
        
        //右边vc坐标
        var rightViewFrame : CGRect = rightVC.view.frame
        rightViewFrame.origin.x = view.frame.width * 2
        rightVC.view.frame = rightViewFrame
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

