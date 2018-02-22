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
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        Utilites.buttonWithRadius(button: loginButton)
        
        let user = UserModel(name: "Pear", surname: "Peric", userName: "Pera Peric", email: "pera@yahoo.com")
        FireBaseHelper.sharedInstance.createUserInDB(userModel: user) { (error) in
            if error == nil {
                
            } else {
                
            }
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        SVProgressHUD.show()
        FireBaseHelper.sharedInstance.logIn(email: emailTextField.text!, password: passwordTextFiled.text!) { (error) in
            if error == nil {
                // Next page
                SVProgressHUD.dismiss()
            
            } else {
                // UIAlert error
                SVProgressHUD.dismiss()
                Utilites.errorAlert(title: "Error", message: "Can not register now", controller: self)
                print("Error login\(String(describing: error))")
            }
        }
    }
    
}

