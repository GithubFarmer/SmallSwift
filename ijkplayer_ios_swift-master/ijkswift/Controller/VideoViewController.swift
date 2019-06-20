//
//  ViewController.swift
//  ijkswift
//
//  Created by 左权 on 2018/9/17.
//  Copyright © 2018年 YTTV. All rights reserved.
//

import UIKit
import SnapKit

class VideoViewController: UIViewController {
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*******************************************************/
        /**
        //点播流
        http://baobab.wandoujia.com/api/v1/playUrl?vid=2616&editionType=normal
        http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear2/prog_index.m3u8
        http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8
        //直播流
         http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8
         rtmp://live.hkstv.hk.lxdns.com/live/hks
         rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov
         */
        /*******************************************************/
        
        let playerView = VideoPlayerView.init(frame: self.view.bounds, strUrl: "http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8")
        playerView.mediaControl?.titleLabel.text = "正在播放：" + "http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8"
        playerView.mediaControl?.titleLabel.textColor = .white
        playerView.isLive = true
        self.view.addSubview(playerView)
        playerView.backgroundColor = UIColor.black
        playerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
//        ControlModel.sharedInstance.transformScreenBtn.addTarget(self, action: #selector(transformAction), for: .touchUpInside)
    }
    
    @objc func transformAction() {
//        self.present(FullVideoViewController(), animated: true, completion: nil)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        appDelegate.isAllOrientation = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        appDelegate.isAllOrientation = false
//        if UIApplication.shared.statusBarOrientation.isLandscape {
//            OtherHelper().setNewOrientation(fullScreen: false)
//        }
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        if appDelegate.isAllOrientation {
//            return .landscapeLeft
//        }else{
//            return .portrait
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

