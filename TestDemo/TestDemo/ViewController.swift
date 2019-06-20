//
//  ViewController.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/5/31.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        let imgView = UIImageView.init(image: UIImage.init(named: ""))
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 5.0
        imgView.layer.masksToBounds = true
        imgView.backgroundColor = .red
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapAction)))
        view.addSubview(imgView)
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue)
        
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(50)
            make.size.equalTo(CGSize.init(width: 70, height: 70))
        }
        
        let label = UILabel.init()
        label.text = "v 1.0"
        label.textAlignment = .center
        view.addSubview(label)
        
//        TestModel.instance.name
        
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(imgView.snp.bottom).offset(3)
        }
        
        
        let player = AVPlayer.init(url: URL.init(string: "http://baobab.wandoujia.com/api/v1/playUrl?vid=2616&editionType=normal")!)
        
        
        //播放视频流
//        let path = Bundle.main.path(forResource: "video.mp4", ofType: nil)
//        let url = URL(fileURLWithPath: path!)
//        let player = AVPlayer.init(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        playerVC.view.frame = CGRect(x: 0, y: 180, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-180)
        self.addChild(playerVC)
        self.view.addSubview(playerVC.view)
        player.play()
    
    
        
        
    }
    
    @objc func tapAction() {
        self.navigationController?.pushViewController(TableTestViewController(), animated: true)
    }

}

