//
//  ViewController.swift
//  Demo3-TableView
//
//  Created by 喻永权 on 2019/1/3.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var array = ["21天计划","微笑的面对生活😊","中国新青年报，我们伟大的祖国繁荣富强。","新的一年，我们许下美好的愿望，愿一世安好！！！","努力的过好每一天，朝着自己预定的目标前进，这就是一种进步，一种无声胜有声的前进，就算时间荒漠了青春，繁琐涂画了激情，我们依旧在前行的路上行走，这就是一种美好，一种守望。"]
    var tableView = UITableView()
    var color = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: 0, y: 44, width: view.frame.width, height: 44)
        titleLabel.text = "使用tableView展示可变的文字样式"
        titleLabel.backgroundColor = UIColor.red
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        tableView.frame = CGRect.init(x: 0, y: 88, width: view.frame.width, height: view.frame.height - 160)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableView)
        
        let changeButton = UIButton()
        changeButton.frame = CGRect.init(x: view.frame.width / 2 - 40, y: view.frame.height - 160, width: 80, height: 80);
        changeButton.layer.cornerRadius = 40
        changeButton.backgroundColor = UIColor.yellow;
        changeButton.setTitle("change", for: UIControlState.normal)
        changeButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        view.addSubview(changeButton)
        changeButton.addTarget(self, action: #selector(changeClick), for: UIControlEvents.touchUpInside)
    }
    
    @objc func changeClick(){
        let colorRed = CGFloat(arc4random_uniform(255)) / 225.0
        let colorGreen = CGFloat(arc4random_uniform(255)) / 225.0
        let colorBlue = CGFloat(arc4random_uniform(255)) / 225.0
        color = UIColor.init(red: colorRed, green: colorGreen, blue: colorBlue, alpha: 1)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.text = array[indexPath.row]
        cell?.textLabel?.textColor = color
        return cell!
    }
}


//MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

