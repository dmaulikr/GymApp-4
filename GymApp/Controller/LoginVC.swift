//
//  ViewController.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKLoginKit

class LoginVC: UIViewController {
  
  @IBOutlet var textFieldLoginEmail: UITextField!
  @IBOutlet var textFieldLoginPassword: UITextField!
  @IBOutlet var backgroundImage: UIImageView!
  
 var blurEffectView: UIVisualEffectView?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView?.frame = view.bounds
    backgroundImage.addSubview(blurEffectView!)
    
    textFieldLoginEmail.backgroundColor = .clear
    textFieldLoginEmail.attributedPlaceholder = NSAttributedString(string: "ENTER YOUR EMAIL", attributes: [NSForegroundColorAttributeName: UIColor.white])
    textFieldLoginPassword.backgroundColor = .clear
    textFieldLoginPassword.attributedPlaceholder = NSAttributedString(string: "ENTER YOUR PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.white])
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  @IBAction func loginBtnPressed() {
    if let email = textFieldLoginEmail.text, let password = textFieldLoginPassword.text {
      Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
        if error == nil {
          print("Users email authenticated with Firebase")
          if let user = user {
            
            // This checks to see if the uid is a PT id - just for testing purposes. Have used the email
            // davewrd00@gmail.com as the PT email to allow a different segue to a screen that users
            // of the app are unable to see. This uid is not saved to keychain so when PTs log out - they will
            // not automatically be signed in like users do.
            if user.uid == "q1N9FHUBRnaeebQjLZQf2kiO8Xj2" {
              print("This is where you need a segue to the PT-version of the app")
              self.performSegue(withIdentifier: "goToPTScreen", sender: self)
            } else {
              let userData = ["provider": user.providerID]
              self.completeSignIn(id: user.uid, userData: userData)
            }
          }
        } else {
          self.displayAlert(title: "Error logging in", message: "Log in details are incorrect. Please try again.", actionTitle: "OK")
        }
      })
    }
  }
  
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
  }
  
  func completeSignIn(id: String, userData: Dictionary<String, String>) {
    DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
    let keychainResult = KeychainWrapper.standard.set(id, forKey: "uid")
    print("DAVID: Data saved to keychain \(keychainResult)")
    self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
  }
  
  func displayAlert(title: String, message: String, actionTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okayAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertController.addAction(okayAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
}

extension LoginVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textFieldLoginEmail {
      textFieldLoginPassword.becomeFirstResponder()
    }
    if textField == textFieldLoginPassword {
      textField.resignFirstResponder()
    }
    return true
  }

}


