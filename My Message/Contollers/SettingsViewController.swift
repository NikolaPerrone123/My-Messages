//
//  SettingsViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setViews(){
        Utilites.buttonWithRadius(button: signOutButton)
    }
    
    @IBAction func signOut(_ sender: Any) {
        FireBaseHelper.sharedInstance.signOut { (error) in
            if error == nil {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let vc = self.storyboard?.instantiateViewController(withIdentifier: loginVC)
                appDelegate.window?.rootViewController = vc
                appDelegate.window?.makeKeyAndVisible()
                Defaults.removeUserAuth()
            }
        }
        
    }
}
