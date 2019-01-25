//
//  RightController.swift
//  Demo4-Camera
//
//  Created by 喻永权 on 2019/1/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import CoreLocation

class RightController: UIViewController, CLLocationManagerDelegate {

    var positionLabel = UILabel()
    var positionButton = UIButton()
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        positionLabel.frame = CGRect.init(x: 30, y: 80, width: 200, height: 200)
        positionLabel.backgroundColor = UIColor.yellow
        positionLabel.numberOfLines = 0
        positionLabel.textAlignment = .center
        view.addSubview(positionLabel)
        
        positionButton.frame = CGRect.init(x: 40, y: view.frame.height - 100, width: view.frame.width - 80, height: 40)
        positionButton.layer.cornerRadius = 20
        positionButton.backgroundColor = UIColor.gray
        positionButton.setTitle("更新地址", for: UIControlState.normal)
        view.addSubview(positionButton)
        positionButton.addTarget(self, action: #selector(updateLocation), for: UIControlEvents.touchUpInside)
        
    }

    @objc func updateLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.positionLabel.text = "Error while updating location " + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMark, error) in
            if (error != nil){
                self.positionLabel.text = error!.localizedDescription
                return
            }
            
            if placeMark!.count > 0 {
                let pm = placeMark![0]
                self.displayPositionInfo(placeMark: pm)
            }else{
                self.positionLabel.text = "location error........"
            }
        }
    }
    
    func displayPositionInfo(placeMark : CLPlacemark?){
        
        if let containsPlaceMark = placeMark {
            locationManager.stopUpdatingLocation()
            //当前城市
            let locality = containsPlaceMark.locality != nil ? containsPlaceMark.locality : ""
            //省份
            let administrativeArea = (containsPlaceMark.administrativeArea != nil) ? containsPlaceMark.administrativeArea : ""
            //国家
            let country = (containsPlaceMark.country != nil) ? containsPlaceMark.country : ""
            self.positionLabel.text = country
            self.positionLabel.text?.append("\n" + administrativeArea! + " - " + locality!  )
        }
        
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
