//
//  Defaults.swift
//  My Message
//
//  Created by Nikola Popovic on 2/25/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation

class Defaults {
    
     static func setEmailPassword(email : String, pass : String){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(email, forKeyPath: userEmail)
        userDefaults.setValue(pass, forKeyPath: userPassword)
    }
    
    static func removeUserAuth() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(nil, forKeyPath: userEmail)
        userDefaults.setValue(nil, forKeyPath: userPassword)
    }
    
    static func getEmail() -> String? {
        let userDefaults = UserDefaults.standard
        let emailDefaults = userDefaults.value(forKey: userEmail) as? String
        if let email = emailDefaults {
            return email
        } else {
            return nil
        }
    }
    
    static func getPassword() -> String? {
        let userDefaults = UserDefaults.standard
        let passDefaults = userDefaults.value(forKey: userPassword) as? String
        if let pass = passDefaults {
            return pass
        } else {
            return nil
        }
    }
    
}
