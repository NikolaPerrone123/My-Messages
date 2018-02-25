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
    var isUserHasImage : Bool = false
    
    init() {
        self.name = ""
        self.surname = ""
        self.userName = ""
        self.email = ""
    }
    
    init(name : String, surname : String, userName : String, email : String, img: UIImage?, isUserHasImage : Bool) {
        self.name = name
        self.surname = surname
        self.userName = userName
        self.email = email
        self.image = img
        self.isUserHasImage = isUserHasImage
    }
    
    func userToDictionary() -> NSDictionary {
        let mutableDictionary = NSMutableDictionary()
        mutableDictionary.setValue(name, forKey: "name")
        mutableDictionary.setValue(surname, forKey: "surname")
        mutableDictionary.setValue(userName, forKey: "username")
        mutableDictionary.setValue(email, forKey: "email")
        mutableDictionary.setValue(isUserHasImage, forKey: "isUserHasImage")
        return mutableDictionary.copy() as! NSDictionary
    }
    
    func initUserFormDictionary(dictionary : NSDictionary) {
        self.name = dictionary.value(forKey: "name") as? String ?? ""
        self.surname = dictionary.value(forKey: "surname") as? String ?? ""
        self.userName = dictionary.value(forKey: "username") as? String ?? ""
        self.email = dictionary.value(forKey: "email") as? String ?? ""
        self.isUserHasImage = dictionary.value(forKey: "isUserHasImage") as? Bool ?? false
        print("surname: \(self.surname)" )
        print("name: \(self.name)" )
        print("email: \(self.email)" )
        print("username: \(self.userName)" )
        print("isUserHasImage: \(self.isUserHasImage)")
    }
}
