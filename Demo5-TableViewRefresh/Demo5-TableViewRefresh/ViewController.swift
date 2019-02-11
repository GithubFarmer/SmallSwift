//
//  ViewController.swift
//  Demo5-TableViewRefresh
//
//  Created by 喻永权 on 2019/1/25.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var tableView = UITableView()
    var dataArray = [String]()
    let datas = ["11111","22222","33333","44444","55555","66666","77777","88888","99999"]
    let newDatas = ["aaaaa","bbbbb","ccccc","ddddd","eeeee","fffff","ggggg"]
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        dataArray = datas
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = self.refreshControl
        refreshControl.backgroundColor = UIColor.yellow
        refreshControl.attributedTitle = NSAttributedString.init(string: "Last update on \(Date())")
        refreshControl.addTarget(self, action: #selector(didRoadDatas), for: UIControlEvents.valueChanged)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        return cell
    }
    
    @objc func didRoadDatas(){
        self.dataArray.append(contentsOf: newDatas)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

