//
//  WelcomeVC.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
  
  @IBOutlet var backgroundImage: UIImageView!
  
  var blurEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
      blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView?.frame = view.bounds
      backgroundImage.addSubview(blurEffectView!)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func prepareForUnwind(for segue: UIStoryboardSegue, sender: Any?) {
    
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
