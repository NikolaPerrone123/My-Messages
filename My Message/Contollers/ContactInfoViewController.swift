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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    
    func setViews(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        statusTextView.layer.cornerRadius = 15
    }
}
