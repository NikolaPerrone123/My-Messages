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
    @IBOutlet weak var signUpButton: UIButton!
    
    fileprivate var imageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setGestureForImage()
       Utilites.buttonWithRadius(button: signUpButton)
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
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImage.contentMode = .scaleAspectFit
            userImage.image = chosenImage
            imageData = UIImageJPEGRepresentation(userImage.image!, 0.8)!
            uplaodImage()
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK - UITapGestureRecognizer for image
    func setGestureForImage(){
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage(_:)))
        userImage.addGestureRecognizer(gesture)
    }
    
    @objc func chooseImage(_ sender: UITapGestureRecognizer){
        popUpForImagePicker()
    }
    
    func popUpForImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let popUp = UIAlertController(title: "Choose image", message: "", preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        popUp.addAction(photoLibraryAction)
        popUp.addAction(cameraAction)
        popUp.addAction(cancelAction)
        present(popUp, animated: true, completion: nil)
    }
    
    // MARK - Upload image
    func uplaodImage(){
        let nsId = NSUUID()
        SVProgressHUD.show()
        FireBaseHelper.sharedInstance.uploadImage(image: imageData, imageName: nsId.uuidString) { (error) in
            if error == nil {
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                Utilites.errorAlert(title: "Error", message: "Can not upload image, try later", controller: self)
            }
        }
    }
}
