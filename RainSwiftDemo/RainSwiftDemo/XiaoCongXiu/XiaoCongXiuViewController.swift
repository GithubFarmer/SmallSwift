//
//  XiaoCongXiuViewController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class XiaoCongXiuViewController: UIViewController, UICollectionViewDataSource , WaterFallDataSource{

    lazy var collectionView : UICollectionView = {
        let waterFall = WaterFallLayout.init()
        waterFall.dataSource = self as WaterFallDataSource
        waterFall.minimumLineSpacing = 5
        waterFall.minimumInteritemSpacing = 5
        waterFall.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: waterFall)
        view.dataSource = self as UICollectionViewDataSource
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        let num = Int(arc4random_uniform(5))
        cell.backgroundColor = [UIColor.red, UIColor.yellow, UIColor.blue, UIColor.gray, UIColor.orange][num]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func colsInWaterFall(_ waterFall: WaterFallLayout) -> Int {
        return 3
    }
    
    func itemHeightInWaterFall(_ waterFall: WaterFallLayout) -> CGFloat {
        let num = Int(arc4random_uniform(5))
        return [34,67,85,128,16,95][num]
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
