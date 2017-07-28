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
    var morePicCount = 1
    //for cameraVC
    var imageOverlay : UIImage!
    var nameText = ""
    
    
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
        switchUIImageView(sender)
    }
    
    //switch between UIimageview
    func switchUIImageView(_ sender: UITapGestureRecognizer){
        switch sender.view!.tag {
        case 1:
            currentImageView = dashboardImg
            nameText = "Dash board"
        case 2:
            currentImageView = frontImg
            imageOverlay = #imageLiteral(resourceName: "frontOverlay")
            nameText = "Front"
        case 3:
            currentImageView = passFrontImg
            imageOverlay = #imageLiteral(resourceName: "passFrontOverlay")
            nameText = "Pass Front"
        case 4:
            currentImageView = passRearImg
            imageOverlay = #imageLiteral(resourceName: "passRearOverlay")
            nameText = "Pass Rear"
        case 5:
            currentImageView = rearImg
            imageOverlay = #imageLiteral(resourceName: "rearOverlay")
            nameText = "Rear"
        case 6:
            currentImageView = driveRearImg
            imageOverlay = #imageLiteral(resourceName: "driveRearOverlay")
            nameText = "Drive Rear"
        case 7:
            currentImageView = driveFrontImg
            imageOverlay = #imageLiteral(resourceName: "driveFrontOverlay")
            nameText = "Drive Front"
        case 8:
            currentImageView = morePicImg
            nameText = "More Pic\(morePicCount)"
        default:
            print("defult")
        }
        myPerformSegue()
    }
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! cameraVC
        nextVC.overlayImage  = imageOverlay
        nextVC.previousText = nameText
        nextVC.previousVC = self
        
    }
    // perform Segue
    func myPerformSegue(){
        performSegue(withIdentifier: "showCameraVC", sender: nil)
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

