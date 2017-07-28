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
    
    var overlayImage : UIImage?
    var previousText : String?
    var captureImage : UIImage?
    var previousVC = dashboardVC()
    
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer = AVCaptureVideoPreviewLayer()
    var photoOutput = AVCapturePhotoOutput()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //set overlay image and text
        if previousText == "Dashboard" ||  (previousText?.contains("More Pic"))!{
            imageOverlay.image = nil
        }else{
        imageOverlay.image = overlayImage
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
        nameText.text = previousText
        
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
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self as AVCapturePhotoCaptureDelegate)
    }
    
    
    @IBAction func cameraButtonRelease(_ sender: UIButton) {
        cameraButton.transform=CGAffineTransform(scaleX: 1, y: 1)
    }
    
    //cancel button action
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! photoPreviewVC
        nextVC.previewImage  = sender as? UIImage
    }
    
    }
//capture photos
extension cameraVC:AVCapturePhotoCaptureDelegate{
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let unwrappedError = error {
            print(unwrappedError.localizedDescription)
        }else{
        if let _ = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
            if let preImage = UIImage(data:dataImage){
                // rotate image to lanscape
                let finalImage = UIImage(cgImage: (preImage.cgImage!), scale: CGFloat(1.0), orientation: .up)
                //set image
                previousVC.currentImageView?.image = finalImage
                
                
            }
            }
        }
    }
}
