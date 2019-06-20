//
//  MorePicViewController.swift
//  TestDemo
//
//  Created by yuyongquan on 2019/6/12.
//  Copyright © 2019 yuyongquan. All rights reserved.
//

import UIKit
import SnapKit

class MorePicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(TestTableViewCell.self, forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        return table
        
    }()
    
    var dataList = [TestCellLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
      let   data = [TestModel.init(na: "1", imageUrls: ["a","b","c"]),
                TestModel.init(na: "2", imageUrls: ["a"]),
                TestModel.init(na: "2", imageUrls: []),
                TestModel.init(na: "ew1", imageUrls: ["a","b","c","a","b","c"]),
                TestModel.init(na: "1eqrqrqerqreq", imageUrls: ["a","b","c","a","b","c","a","b","c"]),
                TestModel.init(na: "dkjalfhkajfhklafjavbckjadbvckladjdbdvdklabavkajvav", imageUrls: ["a","b","a","b"]),
                TestModel.init(na: "1fdbkjc发空间发大包大揽风百搭 v 里卡多方便面 v 扛不住 v 可促进中西部 v 累了就把 vi 老师 v 了净空法师 v", imageUrls: ["a","b","c","a","b"]),
                TestModel.init(na: "方便打卡减肥爸爸 v 将卡电饭煲 v 啊和人民你发的链接啊方便麻烦把空间被罚款减肥把咖啡角额壁蜂看见卡不断克服恐惧八妇女节红包 v 看到饭局包括地方百度空间阿拉比卡几率比卡 v 咖啡的 v 啊看 v啊v 卡 v 你发空间俺的饭卡困难", imageUrls: ["a","b","c","a"]),
                 ]
        for mod in data {
            let layout = TestCellLayout.init(mod: mod)
//            layout.model = mod
        
            dataList.append(layout)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TestTableViewCell
        cell.layoutUI(layout: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let layout = dataList[indexPath.row]
        return layout.height
    }
    
}
