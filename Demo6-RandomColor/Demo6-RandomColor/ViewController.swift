//
//  ViewController.swift
//  Demo6-RandomColor
//
//  Created by 喻永权 on 2019/2/11.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    let gradientLayer = CAGradientLayer()
    
    var timer : Timer?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let playButton = UIButton.init(type: UIButtonType.custom)
        playButton.bounds = CGRect.init(x: 0, y: 0, width: 150, height: 150)
        playButton.center = view.center
        playButton.setImage(UIImage.init(named: "music play"), for: UIControlState.normal)
        playButton.addTarget(self, action: #selector(touchPlayButtonEvent), for: UIControlEvents.touchUpInside)
        view.addSubview(playButton)
        
    }
    
    @objc  func touchPlayButtonEvent(){
        let bgMusic = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer.init(contentsOf: bgMusic)
            //准备播放音乐
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch let audioError as NSError {
            print(audioError)
        }
        
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:#selector(randomColor), userInfo: nil, repeats: true)
        }
        
        //第一次界面渲染
        randomColor()
        
        //gradient color
        gradientLayer.frame = view.bounds
        let color1 = UIColor.init(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor.init(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor.init(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor.init(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        self.view.layer.addSublayer(gradientLayer)
        
    }
    
       @objc func randomColor(){
        
        let redValue = CGFloat.init(drand48())
        let blueValue = CGFloat.init(drand48())
        let greenValue = CGFloat.init(drand48())
        
        print("\(redValue) + \(greenValue) + \(blueValue)")
        self.view.backgroundColor = UIColor.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

