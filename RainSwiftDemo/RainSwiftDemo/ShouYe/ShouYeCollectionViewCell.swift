//
//  ShouYeCollectionViewCell.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/4/17.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ShouYeCollectionViewCell: UICollectionViewCell {
    
    lazy var picture : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var label : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var model : ShouYeCellModel? {
        didSet{
            label.text = model?.name
//            guard let url = URL.init(string: model?.image ?? "" ) else { return}
            picture.image = UIImage.init(named: model?.image ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(picture)
        self.contentView.addSubview(label)
        picture.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.centerX.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(picture.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
    }
}
