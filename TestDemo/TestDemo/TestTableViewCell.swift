//
//  TestTableViewCell.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/6.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit
import SnapKit

let ScreenW = UIScreen.main.bounds.width

class TestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var testModel = TestModel()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    
    var backView = RainPhotoContainerView.init()
    var layoutModel : TestCellLayout?
    
    
     init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model : TestModel) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.testModel = model
        self.setupUI(model: model)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
      self.contentView.addSubview(self.nameLabel)
      self.contentView.addSubview(self.backView)
    }
    
    func layoutUI(layout: TestCellLayout){
        layoutModel = layout
        let mod = layoutModel?.model
        self.nameLabel.text = mod?.name
        self.nameLabel.frame = CGRect(x: 10, y: 10, width: ScreenW-20, height: 40)
        
        if mod!.imageurlList.count > 0{
            backView.isHidden = false
//            backView.customWidth = ScreenW / 3 - 30
            backView.frame = CGRect(x: 10, y: 50, width: layout.picturesSize!.width, height: layout.picturesSize!.height)
            print(backView.frame )
            backView.setupPics(pics: mod!.imageurlList)
        }else{
            backView.isHidden = true
        }
    }
    
    func setupUI(model: TestModel){
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
        }
        let imageList = model.imageColors
        var num = 0
        var tempImv = UIImageView()
        let backView = UIView()
        self.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-5)
        }
        _ = backView.subviews.map({
            $0.removeFromSuperview()
        })
        for color in model.imageColors {
            
            let imageView = UIImageView()
            imageView.backgroundColor = color
            switch imageList.count{
            case 1:
                self.addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
                    make.left.equalTo(self.nameLabel)
                    make.height.width.equalTo(ScreenW/3)
                }
            case 2,3:
                self.addSubview(imageView)
                if num == 0 {
                    imageView.snp.makeConstraints { (make) in
                        make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
                        make.left.equalTo(self.nameLabel)
                        make.height.width.equalTo((ScreenW - 30)/3)
                    }
                }else{
                    imageView.snp.makeConstraints { (make) in
                        make.centerY.size.equalTo(tempImv)
                        make.left.equalTo(tempImv.snp.right).offset(10)
                    }
                }
            case 4,5,6:
                self.addSubview(imageView)
                if num == 0 {
                    imageView.snp.makeConstraints { (make) in
                        make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
                        make.left.equalTo(self.nameLabel)
                        make.height.width.equalTo((ScreenW - 30)/3)
                    }
                }else if (num == 3){
                    imageView.snp.makeConstraints { (make) in
                        make.top.equalTo(tempImv.snp.bottom).offset(10)
                        make.left.equalTo(self.nameLabel)
                        make.height.width.equalTo((ScreenW - 30)/3)
                    }
                }
                else{
                    imageView.snp.makeConstraints { (make) in
                        make.centerY.size.equalTo(tempImv)
                        make.left.equalTo(tempImv.snp.right).offset(10)
                    }
                }
            default:
                return
            }
            num = num + 1
            tempImv = imageView
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellHeightFromModel(model: TestModel) -> CGFloat{
        var height : CGFloat = 35
        if model.imageColors.count == 1 {
            height = height + ScreenW/3 + 10
        }else if model.imageColors.count > 1 && model.imageColors.count <= 3 {
            height = height + (ScreenW - 30)/3 + 10
        }else if model.imageColors.count > 3 {
            height = height + (ScreenW - 30)/3 * 2 + 20
        }
        return height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
