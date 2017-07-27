//
//  ViewController.swift
//  AlliedRentACar
//
//  Created by sun on 7/6/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //lock orientation to portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    
    
    // hide status bar
    override var prefersStatusBarHidden: Bool{
        return true
    }


}

