//
//  SignUpVC.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var backgroundImage: UIImageView!
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var plusPhotoImage: UIButton!
  
  
  var loginVC: LoginVC?
  
  fileprivate func setBlurEffect() {
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImage.addSubview(blurEffectView)
  }
  
  fileprivate func setTextFields() {
    nameTextField.backgroundColor = .clear
    nameTextField.attributedPlaceholder = NSAttributedString(string: "NAME", attributes: [NSForegroundColorAttributeName: UIColor.white])
    emailTextField.backgroundColor = .clear
    emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName: UIColor.white])
    passwordTextField.backgroundColor = .clear
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.white])
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
      
    setBlurEffect()
    setTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func createAccountBtnPressed() {
    guard let name = nameTextField.text else { return }
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
        if error != nil {
          print("Unable to authenticate with Firebase")
          let alertController = UIAlertController(title: "Nothing entered", message: "Please enter all the details above", preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)
        } else {
          print("Successfullt authenticated with Firebase")
          
          guard let image = self.plusPhotoImage.imageView?.image else { return }
          guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
          let fileName = NSUUID().uuidString
          Storage.storage().reference().child("profile_images").child(fileName).putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
            if let err = err {
              print("Failed to upload profile image: ", err)
              return
            }
            
            guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
            print("Successfullt uploaded profile image: ", profileImageUrl)
            
            guard let uid = user?.uid else { return }
            let dictionaryValues = ["name": name, "profileImageURL": profileImageUrl, "provider": user?.providerID]
            let values = [uid: dictionaryValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
              if let err = err {
                print("Failed to save user into DB: ", err)
                return
              }
              
              print("Successfullt saved the user into DB")
              
            })
             self.completeSignInSUVC(id: uid)
          })
        }
      })
    }
  }
  
  // Had to put this method in here aswell - could no refactor. Didnt know how to reference another view controller
  // in a closure with self. Figure out a way to refactor!!!!
  func completeSignInSUVC(id: String) {
    let keychainResult = KeychainWrapper.standard.set(id, forKey: "uid")
    print("DAVID: Data saved to keychain \(keychainResult)")
    self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  @IBAction func plusPhotoBtnPressed(_ sender: Any) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
      plusPhotoImage.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    } else {
      return
    }
    
    plusPhotoImage.layer.cornerRadius = plusPhotoImage.frame.width / 2
    plusPhotoImage.layer.masksToBounds = true
    plusPhotoImage.layer.borderColor = UIColor.black.cgColor
    plusPhotoImage.layer.borderWidth = 3
    
    dismiss(animated: true, completion: nil)
  }
  @IBAction func handleAlreadyHaveAnAccount(_ sender: Any) {
    dismiss(animated: true, completion: nil)  }
  
}
