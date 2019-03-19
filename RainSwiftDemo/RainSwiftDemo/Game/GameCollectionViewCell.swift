//
//  GameCollectionViewCell.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class GameCollectionViewCell: UICollectionViewCell {
    
   private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
   private lazy var subNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()
    
   private lazy var pictureImv: UIImageView = {
        let picture = UIImageView()
        return picture
    }()
    
     var model : GameModel? {
        didSet{
            guard let url = URL.init(string: model?.imageurl ?? "") else {return}
            nameLabel.text = model?.title
            subNameLabel.text = model?.subTitle
            pictureImv.kf.setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(pictureImv)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subNameLabel)
        pictureImv.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalToSuperview()
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-70)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.top.equalTo(pictureImv.snp.bottom).offset(3)
//            make.height.equalTo(20)
        }
        subNameLabel.snp.makeConstraints { (make) in
            make.leading.centerX.height.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
    }
    
}
