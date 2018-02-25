//
//  ContactInfoViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var chatImage: UIImageView!
    
    public var user : UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        fillOutContent()
    }
    
    func setViews(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        statusTextView.layer.cornerRadius = 15
    }
    
    func fillOutContent() {
        contactImage.image = user.isUserHasImage ? user.image : #imageLiteral(resourceName: "user-128")
        nameTextField.text = user.name
        surnameTextField.text = user.surname
        emailTextField.text = user.email
    }
}
