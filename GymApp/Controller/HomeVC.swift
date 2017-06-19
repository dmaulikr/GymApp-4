//
//  HomeVC.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

  @IBOutlet var menuButton: UIBarButtonItem!
  
  override func viewDidLoad() {
        super.viewDidLoad()
 
      self.view.backgroundColor = UIColor.yellow
      
    navigationController?.navigationBar.tintColor = .black

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
    

