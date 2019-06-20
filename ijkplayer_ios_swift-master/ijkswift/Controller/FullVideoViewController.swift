//
//  FullVideoViewController.swift
//  ijkswift
//
//  Created by yuyongquan on 2019/6/11.
//  Copyright © 2019 YTTV. All rights reserved.
//

import UIKit

class FullVideoViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var playView : VideoPlayerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.isAllOrientation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appDelegate.isAllOrientation = false
        if UIApplication.shared.statusBarOrientation.isLandscape {
            OtherHelper().setNewOrientation(fullScreen: false)
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        if appDelegate.isAllOrientation {
            return .landscapeRight
        }else{
            return .portrait
        }
    }

    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
}
