//
//  checkInVC.swift
//  AlliedRentACar
//
//  Created by sun on 7/30/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class checkInVC: UIViewController {

    @IBOutlet weak var noRadio: UIButton!
    @IBOutlet weak var yesRadio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func yesRadioButtonPressed(_ sender: Any) {
        yesRadio.setImage(#imageLiteral(resourceName: "radio-on-button"), for: .normal)
        noRadio.setImage(#imageLiteral(resourceName: "radio-off-button"), for: .normal)
    }
   
    @IBAction func noRadioButtonPressed(_ sender: Any) {
        noRadio.setImage(#imageLiteral(resourceName: "radio-on-button"), for: .normal)
        yesRadio.setImage(#imageLiteral(resourceName: "radio-off-button"), for: .normal)
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
