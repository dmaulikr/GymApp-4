//
//  FancyView.swift
//  GymApp
//
//  Created by David on 25/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class FancyView: UIView {
  
  var gradientLayer: CAGradientLayer!
  
  fileprivate func createGradient() {
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 5.0
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    layer.cornerRadius = 8
    
    //createGradient()
    
    
    
  }
}
