//
//  FireBaseHelper.swift
//  My Message
//
//  Created by Nikola Popovic on 2/21/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import Firebase

class FireBaseHelper {
    
    static let sharedInstance: FireBaseHelper = {
        let instance = FireBaseHelper()
        return instance
    }()
    
    func uploadImage(image: Data, imageName : String, CompletionHandler:@escaping(_ error : Error?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: userImagePath + imageName)
        let uplaodMetaData = StorageMetadata()
        uplaodMetaData.contentType = "image/jpeg"
        storageRef.putData(image, metadata: uplaodMetaData) { (metaData, error) in
            if error == nil {
                print("Image successfull uplaoded")
                CompletionHandler(error)
            } else {
                print("Image can't be uploaded\(String(describing: error))")
                CompletionHandler(error)
            }
        }
    }
    
    func createUser(email : String, password : String, parm : NSDictionary, CompletionHandler:@escaping(_ error : Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                print("Successfull registration")
                let userDB = Database.database().reference().child(userChild)
                userDB.childByAutoId().setValue(parm, withCompletionBlock: { (error, reference) in
                    if (error == nil){
                        print("User created")
                        CompletionHandler(error)
                    } else {
                        print("Can't create user\(String(describing: error))")
                        CompletionHandler(error)
                    }
                })
            } else {
                print("Error registration \(String(describing: error))")
                CompletionHandler(error)
            }
        }
    }
    
    func logIn(email : String, password : String, CompletionHandler:@escaping(_ error : Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil){
                CompletionHandler(error)
            } else {
                CompletionHandler(error)
            }
        }
    }
}
