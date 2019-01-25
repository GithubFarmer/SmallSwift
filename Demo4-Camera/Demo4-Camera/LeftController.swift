//
//  LeftController.swift
//  Demo4-Camera
//
//  Created by 喻永权 on 2019/1/8.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit
import AVFoundation

class LeftController: UIViewController {

    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var cameraView = UIView()
    var tempImgeView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
//        view.backgroundColor = UIColor.yellow
//        let nameLabel = UILabel()
//        nameLabel.text = "leftController";
//        view.addSubview(nameLabel)
//        nameLabel.frame = CGRect.init(x: 20, y: 80, width: 200, height: 40)
        // Do any additional setup after loading the view.
        cameraView.frame = view.bounds
        tempImgeView.frame = view.bounds
        view.addSubview(cameraView)
        view.addSubview(tempImgeView)
    }
    
    //视图将要出现的时候
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        var error : NSError?
        var input : AVCaptureDeviceInput!
        
        //异常处理机制（和oc中不同，在oc中是直接复制给对象的指针）
        do {
            input = try AVCaptureDeviceInput.init(device: backCamera!)}
        catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        //如果没有错误并且输入的图像流是真
        if(error == nil && captureSession?.canAddInput(input) != nil){
            
            captureSession?.addInput(input)
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if(captureSession?.canAddOutput(stillImageOutput!) != nil){
                captureSession?.addOutput(stillImageOutput!)
                previewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession?.startRunning()
            }
        }
    }
    
    
    func didPressTakePhoto(){
        //打开摄像头输出图像流，异步输出
        if let videoConnection = stillImageOutput?.connection(with: AVMediaType.video) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) in
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider.init(data: imageData as! CFData)
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    self.tempImgeView.image = image
                    self.tempImgeView.isHidden = false
                }
            })
        }
    }
    
    //控制是否已经输出图片
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        if didTakePhoto == true {
            self.tempImgeView.isHidden = true
            didTakePhoto = false
        }else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
        }
    }
    
    
    
    //视图已经出现
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.frame
    }
    
    //点击触摸屏幕事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didPressTakeAnother()
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
