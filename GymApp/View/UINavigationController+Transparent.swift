//
//  UINavigationController+Transparent.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  open override func viewDidLoad() {
    super.viewDidLoad()
 
    
    // Make the navigation bar transparent
    self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.isTranslucent = false
    self.navigationBar.tintColor = UIColor.white
}
}
