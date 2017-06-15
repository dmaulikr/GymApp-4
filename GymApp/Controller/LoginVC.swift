//
//  ViewController.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

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
    self.performSegue(withIdentifier: "HomeScreen", sender: nil)
  }
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
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


