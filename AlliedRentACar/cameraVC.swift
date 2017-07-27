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
    
    var overlayImage : UIImage?
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer = AVCaptureVideoPreviewLayer()
    var photoOutput = AVCapturePhotoOutput()
    
    override func viewWillAppear(_ animated: Bool) {
        //set overlay image
        imageOverlay.image = overlayImage
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
        
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //lock orientation to landscapeRight
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
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
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        previewLayer.frame = camerView.frame
        camerView.layer.insertSublayer(previewLayer, at: 0)
    }
    // initial camera staff
    func runCaptureSession(){
        captureSession.startRunning()
    }

   //camera button action
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
         cameraButton.transform=CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    
    @IBAction func cameraButtonRelease(_ sender: UIButton) {
        cameraButton.transform=CGAffineTransform(scaleX: 1, y: 1)
    }
    
    //cancel button action
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
