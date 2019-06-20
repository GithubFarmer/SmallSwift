//
//  TableTestViewController.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/6.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit
import SnapKit

class TableTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        return table
        
    }()
    
    let dataList = ["swift纯代码布局安全区","storybody中的安全区","多图片预览"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataList[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(SafeViewViewController(), animated: true)
        case 1:
            let safeAreaVC : UIViewController = UIStoryboard.init(name: "SafeArea", bundle: nil).instantiateViewController(withIdentifier: "SafeAreaViewController")
            self.navigationController?.pushViewController(safeAreaVC, animated: true)
        case 2:
            self.navigationController?.pushViewController(MorePicViewController(), animated: true)
        default:
            break
        }
    }

}
