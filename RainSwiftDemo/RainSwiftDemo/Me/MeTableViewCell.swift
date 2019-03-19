//
//  MeTableViewCell.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit

let kWidth = UIScreen.main.bounds.size.width

class MeTableViewCell: UITableViewCell {

    //懒加载创建控件
    lazy var photoImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = UIView.ContentMode.scaleToFill
        return imv
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var isFirst : Bool? {
    willSet {
        print("willSet:\(isFirst)")
    }
    didSet {
    print(isFirst)
        if isFirst ?? false {
            photoImageView.snp.updateConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 50, height: 50))
            }
            nameLabel.snp.updateConstraints { (make) in
                make.left.equalTo(photoImageView.snp_rightMargin).offset(kWidth - 170)
            }
            nameLabel.textColor = UIColor.green
            photoImageView.layer.cornerRadius = 25
             photoImageView.layer.masksToBounds = true

        } else{
            photoImageView.snp.updateConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 25, height: 25))
            }
            nameLabel.snp.updateConstraints { (make) in
                make.left.equalTo(photoImageView.snp_rightMargin).offset(15)
            }
            nameLabel.textColor = UIColor.black
            photoImageView.layer.cornerRadius = 0
        }
        
    }
    }
    
    var model : MeModel! {
        didSet{
            photoImageView.image = UIImage.init(named: model.imageUrl)
            nameLabel.text = model.name
        }
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        photoImageView.layer.borderColor = UIColor.red.cgColor
//        photoImageView.layer.borderWidth = 1
//        if isFirst == true {
//            photoImageView.layer.cornerRadius = 25
//            photoImageView.layer.masksToBounds = true
//        }else{
//            photoImageView.layer.cornerRadius = 15
//            photoImageView.layer.masksToBounds = true
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.contentView.addSubview(photoImageView)
        self.contentView.addSubview(nameLabel)
        photoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(photoImageView.snp_rightMargin).offset(15)
            make.centerY.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
