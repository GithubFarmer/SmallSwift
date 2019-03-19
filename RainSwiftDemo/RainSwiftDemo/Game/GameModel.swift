//
//  GameModel.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

//使用model构建数据
class GameModel: NSObject, NSCoding{
    var title : String = ""
    var subTitle : String = ""
    var imageurl : String = ""

    init (dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if(key == "title"){
            title = value as! String
        }else if (key == "subTitle"){
            subTitle = value as! String
        }else if (key == "imageurl"){
            imageurl = value as! String
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(subTitle, forKey: "subTitle")
        aCoder.encode(imageurl, forKey: "imageurl")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        title = (aDecoder.decodeObject(forKey: "title") as? String)!
        subTitle = (aDecoder.decodeObject(forKey: "subTitle") as? String)!
        imageurl = (aDecoder.decodeObject(forKey: "imageurl") as? String)!
    }
    override init() {
        super.init()
    }
}
