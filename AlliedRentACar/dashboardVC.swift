//
//  dashboardVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/10/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit
class dashboardVC: UIViewController{

    @IBOutlet weak var unitnumber: UIBarButtonItem!
    
    @IBOutlet weak var passFrontImg: UIImageView!
    @IBOutlet weak var dashboardImg: UIImageView!
    @IBOutlet weak var driveFrontImg: UIImageView!
    @IBOutlet weak var morePicImg: UIImageView!
    @IBOutlet weak var rearImg: UIImageView!
    @IBOutlet weak var driveRearImg: UIImageView!
    @IBOutlet weak var passRearImg: UIImageView!
    @IBOutlet weak var frontImg: UIImageView!
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var dashboarView: UIView!
    @IBOutlet weak var passRearView: UIView!
    @IBOutlet weak var morePicView: UIView!
    @IBOutlet weak var passFrontView: UIView!
    @IBOutlet weak var rearView: UIView!
    @IBOutlet weak var driveRearView: UIView!
    @IBOutlet weak var driveFrontView: UIView!
    @IBOutlet weak var mainPicView: UIView!
    
    
    var currentImageView : UIImageView?
    var morePicdic : [UIImage] = []

    @IBOutlet weak var morePicCount: UILabel!
    
    var dic = AllDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
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
    
        
    // image click action
    @IBAction func imageClicked(_ sender: UITapGestureRecognizer) {
        switchUIImageView(number: sender.view!.tag)
        
        // perform Segue
        if dic.dashboardImageDic .contains((currentImageView?.image)!) {
            performSegue(withIdentifier: "showCameraVC", sender: nil)
        }else{
            performSegue(withIdentifier: "showPreviewVC", sender: nil)
        }
        
        
    }
    
    
    
    //switch between UIimageview
    func switchUIImageView(number:Int){
        switch number {
        case 1:
            currentImageView = dashboardImg
        case 2:
            currentImageView = frontImg
        case 3:
            currentImageView = passFrontImg
        case 4:
            currentImageView = passRearImg
        case 5:
            currentImageView = rearImg
        case 6:
            currentImageView = driveRearImg
        case 7:
            currentImageView = driveFrontImg
        case 8:
            currentImageView = morePicImg
        case 9:
            currentImageView = mainImg
            
        default:
            print("defult")
        }
        
        
    }
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCameraVC"{
        let nextVC = segue.destination as! cameraVC
        nextVC.tagNumber  = ((currentImageView?.tag)! - 1) //as loop dic from 0, so need -1
        nextVC.previousVC = self
            // main pic call cameraVC
            if nextVC.tagNumber >= 7 {
                nextVC.flag = 1
                if nextVC.tagNumber == 7 {
                    nextVC.morePicCount = morePicdic.count+1
                }
            }
        }
        if segue.identifier == "showPreviewVC"{
            let nextVC2 = segue.destination as! photoPreviewVC
            nextVC2.previewImage = currentImageView?.image
            nextVC2.previousVC = self
            nextVC2.tagNumber = ((currentImageView?.tag)! - 1)
            
        }

        
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

