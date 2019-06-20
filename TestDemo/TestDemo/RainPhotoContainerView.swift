//
//  RainPhotoContainerView.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/12.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit

class RainPhotoContainerView: UIView {

    var picPaths = [String]()
    var customWidth : CGFloat = 0
    var imageArray = [UIImageView]()
    
    class var shareInstace : RainPhotoContainerView{
        struct Static {
            static let instant = RainPhotoContainerView.init()
        }
        return Static.instant
    }
    
    class func getContainerSizeWithPicPaths(paths : [String]) -> CGSize{
        if paths.count == 0 {
            return CGSize.zero
        }
        let itemW : CGFloat = paths.count == 1 ? 120 : 80;
        var itemH : CGFloat = 0
        if paths.count == 1 {
            itemH = itemW
        } else{
            itemH = itemW
        }
        var perRowItemCount = 0
        if paths.count < 4 {
            perRowItemCount = paths.count
        } else if paths.count == 4 {
            perRowItemCount = 2
        } else {
            perRowItemCount = 3
        }
        let margin : CGFloat = 5
        
        let w = CGFloat(perRowItemCount) * itemW + CGFloat(perRowItemCount - 1) * margin
        let ceilfNum = (CGFloat(paths.count) * 1.0 / CGFloat(perRowItemCount))
        let columnCount = ceil(Double(ceilfNum))
        let h = CGFloat(columnCount) * itemH + CGFloat(columnCount - 1) * margin
        return CGSize(width: w, height: h)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        var imvList = [UIImageView]()
        for num in 0 ..< 9 {
            let imv = UIImageView()
            imv.tag = 10 + num
//            imv.backgroundColor = .red
            imv.isUserInteractionEnabled = true
            imv.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(imvAction(tap:))))
            imvList.append(imv)
            self.addSubview(imv)
        }
        imageArray = imvList
    }
    
    //点击图片事件
    @objc func imvAction(tap : UITapGestureRecognizer)  {
        
    }
    
    
    func setupPics(pics:[String]) {
        picPaths = pics
        let i = pics.count
        for item in i ..< imageArray.count {
            let imv = self.imageArray[item]
            imv.isHidden = true
        }
        if picPaths.count == 0 {
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: 0, height: 0)
            return
        }
        
        let itemW : CGFloat = getItemWidth(pics: pics)
        var itemH : CGFloat = 0
        if picPaths.count == 1 {
            itemH = itemW
        }else{
            itemH = itemW
        }
        let perRowCount = perRowItemCount(pics: picPaths)
        let margin : CGFloat = 5
        for (index, _) in picPaths.enumerated() {
            let columnIndex = CGFloat(index % perRowCount)
            let rowIndex = CGFloat(index/perRowCount)
            let tempImv = self.imageArray[index]
            tempImv.isHidden = false
            tempImv.frame = CGRect.init(x: columnIndex*(itemW+margin), y: rowIndex*(itemH+margin), width: itemW, height: itemH)
            tempImv.backgroundColor = .blue
            print("tempImv.frame : \(tempImv.frame)")
        }
        let w = CGFloat(perRowCount) * itemW + CGFloat(perRowCount - 1) * margin
        let ceilfNum = (CGFloat(pics.count) * 1.0 / CGFloat(perRowCount))
        let columnCount = ceil(Double(ceilfNum))
        let h = CGFloat(columnCount) * itemH + CGFloat(columnCount - 1) * margin
        self.frame.size =  CGSize(width: w, height: h)
    }
    
    func getItemWidth(pics : [String]) -> CGFloat{
        if pics.count == 1{
            return 120
        }else{
            if customWidth != 0 {
                return customWidth
            }else{
                let w : CGFloat = ScreenW > 320 ? 80 : 70
                return w
            }
        }
    }
    
    func perRowItemCount(pics: [String]) -> Int {
        if pics.count < 4 {
            return pics.count
        }else if pics.count <= 4 {
            return 2
        }else{
            return 3
        }
    }

}
