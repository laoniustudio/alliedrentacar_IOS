//
//  ViewController.swift
//  AlliedRentACar
//
//  Created by sun on 7/6/17.
//  Copyright © 2017 sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            }
    override func viewDidAppear(_ animated: Bool) {
            }
    // hide status bar
    override var prefersStatusBarHidden: Bool{
        return true
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
    }

}

