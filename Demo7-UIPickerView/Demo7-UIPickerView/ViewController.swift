//
//  ViewController.swift
//  Demo7-UIPickerView
//
//  Created by 喻永权 on 2019/2/11.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView = UIPickerView()
    var goButton = UIButton()
    var textLabel = UILabel()
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
        for _ in 0...100{
            self.dataArray1.append((Int)(arc4random() % 10))
            self.dataArray2.append((Int)(arc4random() % 10))
            self.dataArray3.append((Int)(arc4random() % 10))
        }
        view.backgroundColor = UIColor.init(patternImage: UIImage.init(imageLiteralResourceName: "Hyperspace"))
        pickerView.frame = CGRect.init(x: 0, y: 100, width: view.frame.width, height: 200)
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        
        goButton.frame = CGRect.init(x: 20, y: 320, width: view.frame.width - 40, height: 40)
        goButton.setTitle("GO", for: UIControlState.normal)
        goButton.backgroundColor = UIColor.green
        goButton.layer.cornerRadius = 6
        goButton.addTarget(self, action: #selector(touchGoButtonEvent), for: UIControlEvents.touchUpInside)
        view.addSubview(goButton)
        
        textLabel.frame = CGRect.init(x: 50, y: 370, width: view.frame.width - 100, height: 30)
        textLabel.textAlignment = NSTextAlignment.center
        view.addSubview(textLabel)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.3, options:UIViewAnimationOptions.curveEaseOut, animations: {
            self.goButton.alpha = 1
        }, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickLabel = UILabel()
        if component == 0 {
            pickLabel.text  = imageArray[(Int)(dataArray1[row])]
        }else if component == 1 {
            pickLabel.text = imageArray[(Int)(dataArray2[row])]
        }else{
            pickLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        pickLabel.font = UIFont.init(name: "Apple Color Emoji", size: 80)
        pickLabel.textAlignment = .center
        return pickLabel
    }
    
    @objc func touchGoButtonEvent(){
        
        pickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random() % 90) + 3, inComponent: 2, animated: true)
        
        if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] &&
            dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)]){
            textLabel.text = "Bingo!"
        }else{
            textLabel.text = "Sad..."
        }
        
        //动画
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIViewAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

