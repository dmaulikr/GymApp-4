//
//  UITextField+Placeholder.swift
//  GymApp
//
//  Created by David on 14/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

extension UITextField {
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    
    set {
      if let placeholder = self.placeholder {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: newValue!])

      }
    }
  }
}

