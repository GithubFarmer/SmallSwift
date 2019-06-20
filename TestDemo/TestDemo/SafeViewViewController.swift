//
//  SafeViewViewController.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/11.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit

class SafeViewViewController: UIViewController {

    var safeView = UIView()
    var safeBtn = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        initUI()
        layoutUI()
    }
    
    func initUI() {
        view.addSubview(safeView)
        safeView.addSubview(safeBtn)
        
        safeView.backgroundColor = .red
        safeBtn.backgroundColor = .blue
        safeBtn.addTarget(self, action: #selector(safeBtnAction), for: .touchUpInside)
    }
    
    func layoutUI() {
        safeView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            if #available(iOS 11.0, *){
                make.bottom.equalTo(self.view.snp.bottomMargin)
            }else{
                make.bottom.equalToSuperview()
            }
        }
        safeBtn.snp.makeConstraints { (make) in
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 50))
        }
    }
    
    @objc func safeBtnAction() {
        print("被点击了。。。。。。。。。。")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
