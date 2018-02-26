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
    
    fileprivate var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        Utilites.buttonWithRadius(button: loginButton)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: homeVC)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        SVProgressHUD.show()
        let overly = Utilites.setOverly(view: self.view)
        Utilites.showOverly(isOverlay: true, view: overly)
        FireBaseHelper.sharedInstance.logIn(email: emailTextField.text!, password: passwordTextFiled.text!) { (error) in
            if error == nil {
                // Next page
                SVProgressHUD.dismiss()
                Utilites.showOverly(isOverlay: false, view: overly)
                Defaults.setEmailPassword(email: self.emailTextField.text!, pass: self.passwordTextFiled.text!)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: homeVC)
                self.navigationController?.pushViewController(vc!, animated: true)

            } else {
                // UIAlert error
                SVProgressHUD.dismiss()
                Utilites.showOverly(isOverlay: false, view: overly)
                Utilites.errorAlert(title: "Error", message: "Can not register now", controller: self)
                print("Error login\(String(describing: error))")
            }
        }
    }
    
}

