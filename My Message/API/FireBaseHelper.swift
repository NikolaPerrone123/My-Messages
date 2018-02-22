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
    
    func createUserInDB(userModel : UserModel, CompletionHandler:@escaping(_ error : Error?) -> Void) {
        let refDB = Database.database().reference(withPath: "users").child("2")
        refDB.setValue(userModel.userToDictionary()) { (error, ref) in
            if error == nil {
                print("User has been saved")
                CompletionHandler(error)
            } else {
                print("Can't save user\(String(describing: error))")
                CompletionHandler(error)
            }
        }
    }
    
    func getUserById(userId : String, CompletionHandler:@escaping(_ error : Error?, _ user : UserModel) -> Void) {
        let refDB = Database.database().reference(withPath: "users").child(userId)
        refDB.observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                let user = UserModel()
                user.initUserFormDictionary(dictionary: dictionary)
                CompletionHandler(nil, user)
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
    
    func downloadImage(imageId : String, CompletionHandler:@escaping(_ data : Data?, _ error : Error?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: userImagePath + imageId)
        
        // Download in memory with a maximum allowed size of 5MB (5 * 1024 * 1024 bytes)
        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil {
                print("Image has been taken")
                CompletionHandler(data, error)
            } else {
                print("erro can't download image\(String(describing: error))")
                CompletionHandler(nil, error)
            }
        }
    }
}
