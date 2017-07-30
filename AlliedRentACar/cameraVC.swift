//
//  cameraVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/13/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit
import AVFoundation

class cameraVC: UIViewController {
    
    @IBOutlet weak var camerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageOverlay: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var tagNumber : Int = 0 // current selected uiimage tag number
    var captureImage : UIImage?
    var previousVC = dashboardVC()
    var dic = AllDictionary()
    var finalImage : UIImage?
    var cameraView : cameraVC?
    var flag = 0 //to check if the viewController called by cameraVC(0) or photoPreviewVC and dashboard.mainPic(1) 
    var photoVC = photoPreviewVC()
    var morePicCount = 1
    
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer = AVCaptureVideoPreviewLayer()
    var photoOutput = AVCapturePhotoOutput()
    
    override func viewWillAppear(_ animated: Bool) {
        cancelButton.transform = cancelButton.transform.rotated(by: CGFloat(Double.pi/2))
        nameText.transform = nameText.transform.rotated(by: CGFloat(Double.pi/2))
        cameraButton.transform = cameraButton.transform.rotated(by: CGFloat(Double.pi/2))
        
        //set overlay image and text
        if tagNumber>=7 {//called from main pic taped,or more pic
            if tagNumber == 7{
                nameText.text = dic.nameTextDic[tagNumber]+"\(morePicCount)"//set more pic name
                
            }else{
                nameText.text = dic.nameTextDic[tagNumber]
            }
        }else{
            imageOverlay.image = dic.imageOverlayDic[tagNumber]
            nameText.text = dic.nameTextDic[tagNumber]
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial camera staff
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        runCaptureSession()

        // Do any additional setup after loading the view.
        if flag == 0 {
            if cameraView != nil {
                
                cameraView?.dismiss(animated: false, completion: nil)
            }

        }else{
            photoVC.dismiss(animated: false, completion: nil)
        }
        
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
   
    
    // initial camera staff
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    }
    // initial camera staff
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back)
        let devices = deviceDiscoverySession?.devices
        
        for device in devices!{
            if device.position == AVCaptureDevicePosition.back{
                captureDevice = device
            }
        }
    }
    // initial camera staff
    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecJPEG])], completionHandler: nil)
            captureSession.addOutput(photoOutput)
        } catch  {
            print(error)
        }
    }
    // initial camera staff
    func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
        previewLayer.frame = camerView.bounds
        camerView.layer.insertSublayer(previewLayer, at: 0)
    }
    // initial camera staff
    func runCaptureSession(){
        captureSession.startRunning()
    }

   //camera button action
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        cameraButton.transform=CGAffineTransform(scaleX: 1.1, y: 1.1)
        cameraButton.transform = cameraButton.transform.rotated(by: CGFloat(Double.pi/2))
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self as AVCapturePhotoCaptureDelegate)
    }
    
    
    @IBAction func cameraButtonRelease(_ sender: UIButton) {
        cameraButton.transform=CGAffineTransform(scaleX: 1, y: 1)
        cameraButton.transform = cameraButton.transform.rotated(by: CGFloat(Double.pi/2))
    }
    
    //cancel button action
    
    @IBAction func cancelPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    // present new VC
    func presentNextCameraVC(){
        if tagNumber >= 6 {
            dismiss(animated: true, completion: nil)
        }else{
            // get ref of next VC
            let viewController:cameraVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cameraStory") as UIViewController as! cameraVC
            //set next VC parameters
            viewController.tagNumber = tagNumber + 1
            viewController.previousVC = previousVC
            viewController.cameraView = self
            
            
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
//capture photos
extension cameraVC:AVCapturePhotoCaptureDelegate{
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        
        if let _ = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
            if let preImage = UIImage(data:dataImage){
                
                // rotate image to lanscape
                finalImage = UIImage(cgImage: (preImage.cgImage!), scale: CGFloat(1.0), orientation: .up)
                
                
                if flag == 0 {
                //set image
                previousVC.switchUIImageView(number: tagNumber+1)//change currentImageView by tag
                previousVC.currentImageView?.image = finalImage
                presentNextCameraVC()
                }else{
                    //set image
                    if tagNumber == 7 {
                        previousVC.morePicdic.append(finalImage!)
                        previousVC.morePicCount.text = "\(previousVC.morePicdic.count)"
                    }else{
                        previousVC.currentImageView?.image = finalImage
                    }
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
