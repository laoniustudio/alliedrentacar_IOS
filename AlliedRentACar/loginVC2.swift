//
//  loginVC2.swift
//  AlliedRentACar
//
//  Created by sun on 7/10/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class loginVC2: UIViewController {

    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var licenseButton: UITextField!
    @IBOutlet weak var contractButton: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set centerView style
        centerView.layer.shadowColor = UIColor.gray.cgColor
        centerView.layer.shadowRadius = 7
        centerView.layer.shadowOffset = CGSize.zero
        centerView.layer.shadowOpacity = 0.3
        
        //set button style
        licenseButton.layer.borderColor = UIColor.red.cgColor
    }

        
    override var prefersStatusBarHidden: Bool{
        return true
    }


    //lock orientation to portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
