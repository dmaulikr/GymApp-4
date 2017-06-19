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

class SignUpVC: UIViewController {
  
  @IBOutlet var backgroundImage: UIImageView!
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  var blurEffectView: UIVisualEffectView?
  //var loginVC: LoginVC?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
      blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView?.frame = view.bounds
      backgroundImage.addSubview(blurEffectView!)
      
      nameTextField.backgroundColor = .clear
      nameTextField.attributedPlaceholder = NSAttributedString(string: "NAME", attributes: [NSForegroundColorAttributeName: UIColor.white])
      emailTextField.backgroundColor = .clear
      emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName: UIColor.white])
      passwordTextField.backgroundColor = .clear
      passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.white])
      
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func createAccountBtnPressed() {
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
          if let user = user {
            let userData = ["provider": user.providerID]
            self.completeSignInSUVC(id: user.uid, userData: userData)
          }
        }
      })
    }
  }
  
  // Had to put this method in here aswell - could no refactor. Didnt know how to reference another view controller
  // in a closure with self. Figure out a way to refactor!!!!
  func completeSignInSUVC(id: String, userData: Dictionary<String, String>) {
    DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
    let keychainResult = KeychainWrapper.standard.set(id, forKey: "uid")
    print("DAVID: Data saved to keychain \(keychainResult)")
    self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
  }
  
}
