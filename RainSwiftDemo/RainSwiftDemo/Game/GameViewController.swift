//
//  GameViewController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit

private let kSpacing :CGFloat = 5
private let kItemW = (kScreenW - 4 * kSpacing)  / 3
private let kItemH = kScreenW / 2

class GameViewController: UIViewController {

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = kSpacing
        layout.minimumInteritemSpacing = kSpacing
        layout.sectionInset = UIEdgeInsets.init(top: kSpacing, left: kSpacing, bottom: kSpacing, right: kSpacing)
        layout.itemSize = CGSize.init(width: kItemW, height: kItemH)
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.dataSource = (self as UICollectionViewDataSource)
        view.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
   lazy var data : [GameModel] = [GameModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        data = [
            GameModel.init(dict: ["title":"王大嫂","subTitle":"世界上最远的距离就是你站在我对面，我却不认识你","imageurl":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552031760039&di=6de22707a6e637b8b66c42d3539223e5&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F9213b07eca8065381320af069cdda144ac3482d8.jpg"]),
            GameModel.init(dict: ["title":"顾二娘","subTitle":"天长地久有时尽，此恨绵绵无绝期","imageurl":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552031871950&di=82c5b0664b49a9924070714595c41372&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ffcfaaf51f3deb48fbae1c6c0fa1f3a292df57827.jpg"]),
            GameModel.init(dict: ["title":"貂蝉妹妹","subTitle":"一顾倾人城，再顾倾人国","imageurl":"https://dpic.tiankong.com/p7/br/QJ6676994451.jpg?x-oss-process=style/670ws"]),
            GameModel.init(dict: ["title":"李白","subTitle":"举杯邀明月，对影成三人","imageurl":"https://dpic.tiankong.com/03/7j/QJ6860747024.jpg?x-oss-process=style/670ws"])]
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell
        let index = Int(arc4random_uniform(4))
        print(index)
        cell.model = data[index]
        return cell
    }
}
