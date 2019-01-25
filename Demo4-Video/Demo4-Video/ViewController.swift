//
//  ViewController.swift
//  Demo4-Video
//
//  Created by 喻永权 on 2019/1/24.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView = UITableView()
    var data = [
        videoModel(imageName:"emoji zone", name:"第一张图片", info:"AAAAAAA"),
        videoModel(imageName:"emoji zone", name:"第一次旅行", info:"AAAAAAA"),
        videoModel(imageName:"emoji zone", name:"第一次出门", info:"AAAAAAA"),
        videoModel.init(imageName: "emoji zone", name: "华山之巅", info:"5A级风景区")
    ]
    var playView = AVPlayer()
    var playController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.isStatusBarHidden = true
//        self.edgesForExtendedLayout = UIRectEdge.top
        tableView.frame  =  CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        self.view.addSubview(tableView)
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ddddddddd:播放视频")
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        let url = URL.init(fileURLWithPath: path!)
        playView = AVPlayer.init(url: url)
        playController.player = playView
        self.present(playController, animated: true) {
            self.playController.player?.play()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VideoTableViewCell
        let model = data[indexPath.row]
        cell.imageView?.image = UIImage.init(named: model.imageName)
        cell.nameLabel.text = model.name
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

