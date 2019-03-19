//
//  RainSelectedViewController.swift
//  Demo3-TableView
//
//  Created by 喻永权 on 2019/3/4.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

protocol RainProtocol {
    //定义属性：协议可以定义实例属性和类型属性（使用static）；协议在定义属性的时候，不指定属性的存储属性还是计算属性，只指定属性的名称和类型以及读写性，不能给协议属性设置默认值，因为默认值被看作是一种实现
    //定义方法：协议可以定义实例方法或类方法（使用static）；协议定义方法不能使用默认参数；在定义的实例方法会改变实例本身，需要在定义的方法名前使用mutating
//    static var personCount : Int {get}
//    var name : String {
//        get
//        set
//    }
    func play()
    mutating func changeNickName(newName:String)
}


typealias RainBlock = ((_ name: String, _ count : Int) -> Void)

class RainSelectedViewController: UIViewController{

    var delegate : RainProtocol?
    
    //使用block反响传值使用
    var myBlock: ((String) ->())?
    var block1: RainBlock?
    var data : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        data.flatMap{$0}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.play()
        self.delegate?.changeNickName(newName: "I Love You!")
        self.myBlock!("12345678910....")
        if block1 != nil {
            block1!("Bob",34)
        }
        self.dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
