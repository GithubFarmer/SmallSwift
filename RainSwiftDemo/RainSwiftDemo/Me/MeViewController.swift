//
//  MeViewController.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/3/7.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

//使用结构体构建数据
struct MeModel {
    let imageUrl : String
    let name : String
}

class MeViewController: UIViewController {

    
    lazy var tableView : UITableView = { [unowned self] in
        let table = UITableView.init(frame: CGRect.zero, style: .grouped)
        table.delegate = self as UITableViewDelegate
        table.backgroundColor = UIColor.clear
        table.tableFooterView = UIView()
        table.dataSource = self as UITableViewDataSource
        table.register(MeTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    var dataArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        let data = [MeModel.init(imageUrl: "LOGO", name: "点击登录"),
                    MeModel.init(imageUrl: "mine_zhubo", name: "我要当主播"),
                    MeModel.init(imageUrl: "mine_attentionIcon", name: "我的订阅"),
                    MeModel.init(imageUrl: "mine_histroyIcon", name: "观看历史"),
                    MeModel.init(imageUrl: "mine_message_icon", name: "私信"),
                    MeModel.init(imageUrl: "shake_icon", name: "摇一摇"),
                    MeModel.init(imageUrl: "mine_activityIcon", name: "活动中心"),
                    MeModel.init(imageUrl: "mine_remindIcon", name: "开播信息"),
                    MeModel.init(imageUrl: "mine_suggestIcon", name: "意见反馈")]
        dataArray.addObjects(from: data);
    }
    
    func setUpUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let image = UIImage.init(named: "mine_settingIcon2")
        let lightImage = UIImage.init(named: "mine_settingIcon2_press")
        navigationItem.rightBarButtonItem = Common.itemWithImage(image!, highLightIamge: lightImage!, target: self, action: #selector(settingAction))
    }
    
    @objc func settingAction() {
        let settingVC = OtherViewController()
        settingVC.view.backgroundColor = UIColor.white
        settingVC.title = "设置"
        navigationController?.pushViewController(settingVC, animated: true)
    }

}

extension MeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(OtherViewController(), animated: true)
    }
}

extension MeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 5
        }else{
            return 1;
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MeTableViewCell
     
//        let string = "https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg"
//        let imageUrl = URL.init(string: string)
//        cell?.imageView?.kf.setImage(with: imageUrl)
        if indexPath.section == 0 {
            cell.isFirst = true
        }else {
            cell.isFirst = false
        }
        switch indexPath.section {
        case 0:do {
            let mod = dataArray.firstObject as! MeModel
//            cell.imageView?.image = UIImage.init(named: mod.imageUrl)
//            cell.nameLabel.text = mod.name
            cell.model = mod
            }
            break
        case 1:do {
            let mod = dataArray[1] as! MeModel
//            cell.imageView?.image = UIImage.init(named: mod.imageUrl)
//            cell.nameLabel.text = mod.name
            cell.model = mod
            }
            break
        case 2:do {
            let mod = dataArray[2] as! MeModel
//            cell.imageView?.image = UIImage.init(named: mod.imageUrl)
//            cell.nameLabel.text = mod.name
            cell.model = mod
        }
            break
        case 3:do {
            let mod = dataArray[3] as! MeModel
//            cell.imageView?.image = UIImage.init(named: mod.imageUrl)
//            cell.nameLabel.text = mod.name
            cell.model = mod
        }
            break
        case 4:do {
            let mod = dataArray[indexPath.row + 4] as! MeModel
//            cell.imageView?.image = UIImage.init(named: mod.imageUrl)
//            cell.nameLabel.text = mod.name
            cell.model = mod
        }
        break
        default:do {
            }
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return 45
        }else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
