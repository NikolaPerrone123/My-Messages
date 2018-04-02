//
//  HomeViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setViews(){
        
    }
}
