//
//  StartUpViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/25/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import SVProgressHUD

class StartUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Loading")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }

}
