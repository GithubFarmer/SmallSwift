//
//  ViewController.swift
//  Demo2-SnapKit
//
//  Created by 喻永权 on 2019/1/2.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit
//学习swift自动布局 使用Snapkit
class ViewController: UIViewController {

    var view1 = UIView()
    var annimationOne = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testView = UIView()
        testView.backgroundColor = UIColor.cyan
        view.addSubview(testView)
        testView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalTo(view)
        }
        
        view1.frame = CGRect.init(x: 60, y: 40, width: 300, height: 300)
        view1.backgroundColor = UIColor.black
        view.addSubview(view1)
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.red
        view1.addSubview(view2)
        
        view2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if annimationOne {
            moveAnnimationTwo()
            annimationOne = false
        } else {
            moveAnnimation()
            annimationOne = true
        }
    }
    
    //MARK: 利用SnapKit做动画
    func moveAnnimation() {
        view1.snp.remakeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(350)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-30)
        }
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5) {
            weakSelf?.view1.layoutIfNeeded()
        }
    }
    
    func moveAnnimationTwo(){
        view1.snp.remakeConstraints { (make) in
            make.width.height.equalTo(200)
            make.left.top.equalTo(40)
        }
        weak var weakSelf = self
        UIView.animate(withDuration: 0.6) {
            weakSelf?.view1.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

