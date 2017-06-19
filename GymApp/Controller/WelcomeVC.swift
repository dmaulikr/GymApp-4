//
//  WelcomeVC.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKLoginKit

class WelcomeVC: UIViewController {
  
  @IBOutlet var backgroundImage: UIImageView!
    
    
  
  var blurEffectView: UIVisualEffectView?
  var loginVC: LoginVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
      blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView?.frame = view.bounds
      backgroundImage.addSubview(blurEffectView!)
    }
  
  override func viewDidAppear(_ animated: Bool) {
    if let _ = KeychainWrapper.standard.string(forKey: "uid") {
      print("DAVID: ID found in keychain")
      performSegue(withIdentifier: "goToHomeScreen", sender: nil)
    }
  }
  
  @IBAction func createAcccountBtnPressed() {
    self.performSegue(withIdentifier: "logInScreen2", sender: nil)
  }
  
  @IBAction func signInWithEmailBtnPressed() {
    self.performSegue(withIdentifier: "logInScreen", sender: nil)
  }
  
  @IBAction func facebookBtnPressed(_ sender: Any) {
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      if let error = error {
        print("Error logging in with Facebook")
        return
      }
      guard let accessToken = FBSDKAccessToken.current() else {
        print("Failed to get the access token")
        return
      }
      
      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      
      // Perform login by calling Firebas API
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if let error = error {
          print("Login error: \(error.localizedDescription)")
          let alertController = UIAlertController(title: "Login error", message: "Error is \(error.localizedDescription)", preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)
        } else {
          if let user = user {
            let userData = ["provider": credential.provider]
            self.loginVC.completeSignIn(id: user.uid, userData: userData)
          }
        }
      })
    }
  }

}
