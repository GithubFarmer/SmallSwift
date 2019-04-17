//
//  ShouYeViewController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit

struct ShouYeCellModel{
    let name: String
    let image : String
}

class ShouYeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize.init(width: kScreenW/5, height: kScreenW/5)
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.dataSource = (self as UICollectionViewDataSource)
        view.delegate = self as UICollectionViewDelegate
        view.isScrollEnabled = false
        view.register(ShouYeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
        }()
    var imageDatas = [ShouYeCellModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.addSubview(self.collectionView);
        imageDatas = [ShouYeCellModel.init(name: "排行榜", image: "mine_icon_hot"),
                      ShouYeCellModel.init(name: "申帖", image: "mine_icon_preview"),
                      ShouYeCellModel.init(name: "漫画", image: "mine_icon_manhua"),
                      ShouYeCellModel.init(name: "我的收藏", image: "mine_icon_activity"),
                      ShouYeCellModel.init(name: "附近", image: "mine_icon_nearby"),
                      ShouYeCellModel.init(name: "随机穿越", image: "mine_icon_random"),
                      ShouYeCellModel.init(name: "意见反馈", image: "mine_icon_feedback"),
                      ShouYeCellModel.init(name: "更多", image: "mine_icon_more")]
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(250)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = OtherViewController.init()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShouYeCollectionViewCell
        let model = imageDatas[indexPath.row] 
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDatas.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
