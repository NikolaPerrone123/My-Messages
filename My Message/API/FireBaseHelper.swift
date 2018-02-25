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
    

    // MARK - CREATE METHOD
    func createUser(email : String, password : String, userModel : UserModel, CompletionHandler:@escaping(_ error : Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                print("Successfull registration")
                let userDB = Database.database().reference().child(userTable)
                let userById = userDB.childByAutoId()
                userById.setValue(userModel.userToDictionary(), withCompletionBlock: { (error, reference) in
                    if (error == nil){
                        print("User created")
                        if (userModel.image != nil) {
                            self.uploadImage(image: UIImagePNGRepresentation(userModel.image)!, imageName: userModel.email, CompletionHandler: { (error) in
                                if (error == nil) {
                                    CompletionHandler(error)
                                    print("Created user and image saved")
                                }
                            })
                        } else {
                        CompletionHandler(error)
                        print("Created user but image not")
                        }
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
    
    
    // MARK - GET METHOD
    
    func getUsers(CompletionHandler:@escaping(_ error : Error?, _ users: [UserModel]?) -> Void) {
        let refDb = Database.database().reference(withPath: userTable)
        refDb.observe(.value, with: { (snapshot) in
            var arrayOfUser = [UserModel]()
            if let dictionary = snapshot.value as? NSDictionary {
                let keys = dictionary.allKeys
                for key in keys {
                    let dictionaryUser = dictionary.value(forKey: key as! String)
                    let userModel = UserModel()
                    userModel.initUserFormDictionary(dictionary: dictionaryUser as! NSDictionary)
                    arrayOfUser.append(userModel)
                }
                CompletionHandler(nil, arrayOfUser)
            }
        }) { (error) in
            CompletionHandler(error, nil)
        }
    }
    
    func getUserByEmail(email : String, CompletionHandler:@escaping(_ error : Error?, _ user : UserModel) -> Void) {
        let refDB = Database.database().reference(withPath: userTable)
        refDB.observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                let keys = dictionary.allKeys
                for oneKey in keys {
                    if let key = oneKey as? String {
                        let userDictionary = dictionary.value(forKey: key)
                        let user = UserModel()
                        user.initUserFormDictionary(dictionary: userDictionary as! NSDictionary)
                        if (user.email == email){
                            CompletionHandler(nil, user)
                        }
                    }
                }
            }
        }
    }
    
    func downloadImage(imageId : String, CompletionHandler:@escaping(_ image : UIImage?, _ error : Error?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: userImagePath + imageId)
        
        // Download in memory with a maximum allowed size of 20MB (10 * 1024 * 1024 bytes)
        storageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
            if error == nil {
                print("Image has been taken")
                let image = UIImage(data: data!, scale: 1.0)
                CompletionHandler(image , error)
            } else {
                print("erro can't download image\(String(describing: error))")
                CompletionHandler(nil, error)
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
