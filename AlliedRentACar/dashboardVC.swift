//
//  dashboardVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/10/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class dashboardVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var unitnumber: UIBarButtonItem!
    
    @IBOutlet weak var passFrontImg: UIImageView!
    @IBOutlet weak var dashboardImg: UIImageView!
    @IBOutlet weak var driveFrontImg: UIImageView!
    @IBOutlet weak var morePicImg: UIImageView!
    @IBOutlet weak var rearImg: UIImageView!
    @IBOutlet weak var driveRearImg: UIImageView!
    @IBOutlet weak var passRearImg: UIImageView!
    @IBOutlet weak var frontImg: UIImageView!
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var dashboarView: UIView!
    @IBOutlet weak var passRearView: UIView!
    @IBOutlet weak var morePicView: UIView!
    @IBOutlet weak var passFrontView: UIView!
    @IBOutlet weak var rearView: UIView!
    @IBOutlet weak var driveRearView: UIView!
    @IBOutlet weak var driveFrontView: UIView!
    @IBOutlet weak var mainPicView: UIView!
    
    var imagePicker = UIImagePickerController()
    var currentImageView : UIImageView?
    var morePicdic : [UIImage] = []
    var imageOverlay : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the unit number color
        unitnumber.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .disabled)
        // for camera
        imagePicker.delegate = self
        
        // UIimageView add shadows
        addshadow(myView: frontView)
        addshadow(myView: dashboarView)
        addshadow(myView: driveFrontView)
        addshadow(myView: morePicView)
        addshadow(myView: rearView)
        addshadow(myView: driveRearView)
        addshadow(myView: passRearView)
        addshadow(myView: passFrontView)
        addshadow(myView: mainPicView)
        
        
        
    }
    //lock orientation to portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // image click action
    @IBAction func imageClicked(_ sender: UITapGestureRecognizer) {
                
        switch sender.view!.tag {
        case 1:
            currentImageView = dashboardImg
        case 2:
            currentImageView = frontImg
            imageOverlay = #imageLiteral(resourceName: "frontOverlay")
        case 3:
            currentImageView = passFrontImg
            imageOverlay = #imageLiteral(resourceName: "passFrontOverlay")
        case 4:
            currentImageView = passRearImg
            imageOverlay = #imageLiteral(resourceName: "passRearOverlay")
        case 5:
            currentImageView = rearImg
            imageOverlay = #imageLiteral(resourceName: "rearOverlay")
        case 6:
            currentImageView = driveRearImg
            imageOverlay = #imageLiteral(resourceName: "driveRearOverlay")
        case 7:
            currentImageView = driveFrontImg
            imageOverlay = #imageLiteral(resourceName: "driveFrontOverlay")
        case 8:
            currentImageView = morePicImg
            
        default:
            print("defult")
        }
        performSegue(withIdentifier: "showCameraVC", sender: nil)
        
        
    }
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! cameraVC
        nextVC.overlayImage  = imageOverlay
    }
    // imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPic = info[UIImagePickerControllerOriginalImage] as! UIImage
        if currentImageView == morePicImg{
            morePicdic.append(selectedPic)
        }else{
            currentImageView?.image = selectedPic
        }
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    // add shadow Func
    func addshadow(myView:UIView){
        
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowRadius = 5
        myView.layer.shadowOffset = CGSize.zero
        myView.layer.shadowOpacity = 0.3
    }
    
}

