//
//  SignInViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/21/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var surnameTextFiled: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setGestureForImage()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        SVProgressHUD.show()
        let user = UserModel(name: self.nameTextFiled.text!, surname: self.surnameTextFiled.text!, userName: self.userNameTextField.text!, email: self.emailTextField.text!)
        FireBaseHelper.sharedInstance.createUser(email: emailTextField.text!, password: passwordTextField.text!, parm: user.userToDictionary()) { (error) in
            if error == nil {
                // Move to next Screen
                SVProgressHUD.dismiss()
            } else {
                // Show pop up
                SVProgressHUD.dismiss()
            }
        }
    }
    
    // MARK - Delegate picker contorller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.contentMode = .scaleAspectFit
        userImage.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setGestureForImage(){
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage(_:)))
        userImage.addGestureRecognizer(gesture)
    }
    
    func popUpForImagePicker() {
        let picker = UIImagePickerController()
        let popUp = UIAlertController(title: "Choose image", message: "", preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.present(picker, animated: true, completion: nil)
        }
        popUp.addAction(photoLibraryAction)
        popUp.addAction(cameraAction)
        present(popUp, animated: true, completion: nil)
    }
    
    // MARK - Gesture action for image
    @objc func chooseImage(_ sender: UITapGestureRecognizer){
        popUpForImagePicker()
    }
    
}
