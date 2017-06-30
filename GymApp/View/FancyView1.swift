//
//  FancyView1.swift
//  GymApp
//
//  Created by David on 26/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class FancyView1: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 5
  }
  
}
