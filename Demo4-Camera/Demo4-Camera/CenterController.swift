//
//  CenterController.swift
//  Demo4-Camera
//
//  Created by 喻永权 on 2019/1/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class CenterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        UIApplication.shared.isStatusBarHidden = true
        // Do any additional setup after loading the view.
        let backImageView = UIImageView()
        backImageView.frame = view.frame
        view.addSubview(backImageView)
        backImageView.image = UIImage.init(named: "blue")
        self.showBlurEffect()
        showBlurEffectWithUIVibrancyEffect()
    }
    
    
    //MARK: 两种方式实现毛玻璃效果
    // UIBlurEffect 和 UIVisualEffectView两者配合使用
    func showBlurEffect() {
        //创建一个模糊效果 5种效果
        let blurEffect = UIBlurEffect(style:.dark)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        blurView.frame = CGRect.init(x: 0, y: 64, width: view.frame.width, height: 200)
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 50, width: view.frame.width, height: 80))
        label.text = "kill food is foolish people!"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        blurView.contentView.addSubview(label)
        view.addSubview(blurView)
    }
    
    //UIBlurEffect、UIVibrancyEffect 和 UIVisualEffectView
    func showBlurEffectWithUIVibrancyEffect() {
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        blurView.frame = CGRect.init(x: 0, y: 300, width: view.frame.width, height: 200)
        view.addSubview(blurView)
        
        //创建UIVibrancyEffect视图
        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView.init(effect: vibrancyEffect)
        vibrancyView.frame = blurView.bounds
        
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 50, width: view.frame.width, height: 80))
        label.text = "kill food is foolish people!"
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        vibrancyView.contentView.addSubview(label)
        blurView.contentView.addSubview(vibrancyView)
        view.addSubview(blurView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
