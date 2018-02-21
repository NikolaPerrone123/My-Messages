//
//  ViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/17/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func login(_ sender: Any) {
        SVProgressHUD.show()
        FireBaseHelper.sharedInstance.logIn(email: emailTextField.text!, password: passwordTextFiled.text!) { (error) in
            if error == nil {
                // Next page
                SVProgressHUD.dismiss()
            } else {
                // Pop Up for error
                SVProgressHUD.dismiss()
                print("Error login\(String(describing: error))")
            }
        }
    }
    
}

