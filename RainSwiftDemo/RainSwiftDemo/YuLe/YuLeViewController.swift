//
//  YuLeViewController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

let Kwidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class YuLeViewController: UIViewController {
    
    //[unowned self] 相当于OC中__UnSafe__unretain
    fileprivate lazy var loadView : UIView = { [unowned self] in
        let view = UIView()
        view.frame = CGRect.init(origin: .zero, size: CGSize.init(width: Kwidth, height: kHeight - 64 - 49))
        let imageView = UIImageView.init(image: UIImage.init(named: "0tai_icon2-1"))
        imageView.center = view.center
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 13)
        title.textColor = UIColor.darkGray
        title.text = "在这里，你会找到最有趣的直播～～～"
        title.textAlignment = .center
        title.center = CGPoint.init(x: imageView.center.x, y: imageView.frame.maxY+10)
        title.bounds.size = CGSize.init(width: Kwidth, height: 20)
        view.addSubview(imageView)
        view.addSubview(title)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loadView)
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
