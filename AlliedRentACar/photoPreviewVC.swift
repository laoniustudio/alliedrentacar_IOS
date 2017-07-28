//
//  photoPreviewVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/27/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class photoPreviewVC: UIViewController {

    @IBOutlet weak var retake: UIButton!
    @IBOutlet weak var captureImage: UIImageView!
    var previewImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show image
        captureImage.image = previewImage
        //retake.transform = retake.transform.rotated(by: CGFloat(Double.pi/2))
    }

    //lock orientation to landscapeRightDouble.p
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    //retake
    @IBAction func retakeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
