//
//  UserModel.swift
//  My Message
//
//  Created by Nikola Popovic on 2/21/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import UIKit

class UserModel {
    var name : String!
    var surname : String!
    var userName : String!
    var email : String!
    var password : String!
    var image : UIImage!
    
    init(name : String, surname : String, userName : String, email : String) {
        self.name = name
        self.surname = surname
        self.userName = userName
        self.email = email
    }
    
    func userToDictionary() -> NSDictionary {
        let mutableDictionary = NSMutableDictionary()
        mutableDictionary.setValue(name, forKey: "name")
        mutableDictionary.setValue(surname, forKey: "surname")
        mutableDictionary.setValue(userName, forKey: "username")
        mutableDictionary.setValue(email, forKey: "email")
        return mutableDictionary.copy() as! NSDictionary
    }
}
