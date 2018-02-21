//
//  SignInViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/21/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var surnameTextFiled: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func SignIn(_ sender: Any) {
        let user = UserModel(name: self.nameTextFiled.text!, surname: self.surnameTextFiled.text!, userName: self.userNameTextField.text!, email: self.emailTextField.text!)
        FireBaseHelper.sharedInstance.signIn(email: emailTextField.text!, password: passwordTextField.text!, parm: user.userToDictionary()) { (error) in
            if error == nil {
                // Move to next Screen
            } else {
                // Show pop up
            }
        }
    }
    
}
