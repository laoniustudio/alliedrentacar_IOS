//
//  photoPreviewVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/27/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class photoPreviewVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var retake: UIButton!
    @IBOutlet weak var captureImage: UIImageView!
    var previewImage : UIImage?
    var previousVC = dashboardVC()
    var tagNumber = 0
    
    var dic = AllDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show image
        
        captureImage.image = previewImage
        captureImage.image = UIImage(cgImage: (captureImage.image?.cgImage!)!, scale: CGFloat(1.0), orientation: .right)
        retake.transform = retake.transform.rotated(by: CGFloat(Double.pi/2))
        cancelButton.transform = cancelButton.transform.rotated(by: CGFloat(Double.pi/2))
        
    }

    //lock orientation to landscapeRightDouble.p
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    //retake
    @IBAction func retakeButtonPressed(_ sender: Any) {
        // get ref of next VC
        let viewController:cameraVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cameraStory") as UIViewController as! cameraVC
        //set next VC parameters
        
        viewController.previousVC = previousVC
        viewController.flag = 1
        viewController.photoVC = self
        viewController.tagNumber = tagNumber
        
        self.present(viewController, animated: true, completion: nil)

    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    // hide status bar
    override var prefersStatusBarHidden: Bool{
        return true
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
