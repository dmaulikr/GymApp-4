//
//  SignUpVC.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
  
  @IBOutlet var backgroundImage: UIImageView!
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  var blurEffectView: UIVisualEffectView?

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
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
