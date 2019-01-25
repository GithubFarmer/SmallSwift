//
//  ViewController.swift
//  Day1-Timer
//
//  Created by 喻永权 on 2019/1/2.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var timeLabel = UILabel()
    var pasueButton = UIButton()
    var startButton = UIButton()
    var currentTime = NSInteger()
    var isplay = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        setUpUI()
    }
    
    func x(view : UIView) -> CGFloat {
        return view.frame.origin.x
    }
    
    func y(view : UIView) -> CGFloat {
        return view.frame.origin.y
    }
    
    func width(view : UIView) -> CGFloat {
        return view.frame.size.width
    }
    
    func height(view : UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    func setUpUI() -> Void {
        
        timeLabel.frame = CGRect.init(x: 0, y: 0, width: width(view: self.view), height: 400)
        timeLabel.backgroundColor = UIColor.yellow
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.boldSystemFont(ofSize: 120)
        self.view.addSubview(timeLabel)
        
        
        let pushButton = UIButton()
        pushButton.frame = CGRect.init(x: 30, y: 40, width: 300, height: 50)
        pushButton.backgroundColor = UIColor.orange
        pushButton.setTitle("push next viewController", for: UIControlState.normal)
        self.view.addSubview(pushButton)
        pushButton.addTarget(self, action: #selector(presentAction), for: UIControlEvents.touchUpInside)
        
        
        
        //定位y坐标
        let Y = height(view: self.view) - height(view: timeLabel)
        
        pasueButton.frame = CGRect.init(x: 0, y: Y, width: width(view: self.view) / 2, height: height(view: self.view) - Y)
        pasueButton.backgroundColor = UIColor.red;
        pasueButton .setTitle("暂停", for: UIControlState.normal)
        self.view.addSubview(pasueButton)
        
        startButton.frame = CGRect.init(x: width(view: self.view) / 2, y: Y, width: width(view: self.view) / 2, height: height(view: self.view) - Y)
        startButton.backgroundColor = UIColor.blue;
        startButton .setTitle("开始", for: UIControlState.normal)
        self.view.addSubview(startButton)
        
        //点击事件
        pasueButton.addTarget(self, action: #selector(pauseClick(sender:)), for: UIControlEvents.touchUpInside)
        startButton.addTarget(self, action: #selector(startClick), for: UIControlEvents.touchUpInside)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
   
    }
    
    @objc func presentAction(){
        let nextVC = NextViewController()
        self.present(nextVC, animated: false, completion: nil);
    }
    
    @objc func timeAction() {
        currentTime += 1
        let string = String.init(format: "%d s", currentTime)
        let attrText = NSMutableAttributedString.init(string: string)
        let stringLength = string.count
        attrText .addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange.init(location: stringLength - 1, length: 1))
        attrText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 60), range: NSRange.init(location: stringLength - 1, length: 1))
        timeLabel.attributedText = attrText
    }
    
    @objc func pauseClick(sender : UIButton) -> Void {
        timer.invalidate()
        pasueButton.isEnabled = false
        startButton.isEnabled = true
        isplay = false
    }
    
    @objc func startClick() {
        if(isplay){
            return;
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        startButton.isEnabled = false
        pasueButton.isEnabled = true
        isplay = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

