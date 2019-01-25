//
//  VideoTableViewCell.swift
//  Demo4-Video
//
//  Created by 喻永权 on 2019/1/24.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

struct videoModel {
    let imageName : String
    let name : String
    let info : String
}

class VideoTableViewCell: UITableViewCell {

    //懒加载方式创建button,swift中叫做闭包
    lazy var playButton : UIButton = {
        let tempButton = UIButton()
        tempButton.setImage(UIImage.init(named: "playBtn"), for: UIControlState.normal)
        return tempButton
    }()
    lazy var nameLabel : UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "I LOVE VIDEO"
        tempLabel.textColor = UIColor.red
        return tempLabel
    }()
    lazy var backImageView  : UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.image = UIImage.init(named: "videoScreenshot01")
        return tempImageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.contentView.addSubview(self.backImageView)
        self.contentView.addSubview(self.playButton)
        self.contentView.addSubview(self.nameLabel)
        self.backImageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: 200)
        self.playButton.frame = CGRect.init(x: 0, y: 110, width: 80, height: 80)
        self.nameLabel.frame = CGRect.init(x: 150, y: 170, width: 100, height: 30)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
