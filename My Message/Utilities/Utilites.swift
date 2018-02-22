//
//  Utilites.swift
//  My Message
//
//  Created by Nikola Popovic on 2/22/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import UIKit

class Utilites {
    
    static func errorAlert(title : String, message : String, controller : UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            controller.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func buttonWithRadius(button : UIButton){
        button.layer.cornerRadius = 15
    }
}
