//
//  SettingsCell.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
      nameLbl.textColor = isHighlighted ? UIColor.white : UIColor.black
      iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
    }
  }
  
  var setting: Setting? {
    didSet {
      nameLbl.text = setting?.name
      
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.darkGray
      }
    }
  }
  
  let nameLbl: UILabel = {
    let lbl = UILabel()
    lbl.text = "Settings"
    lbl.font = UIFont.systemFont(ofSize: 13)
    return lbl
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "settings")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(nameLbl)
    addSubview(iconImageView)
    
//    addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLbl)
//
//
//    addConstraintsWithFormat("V:|[v0]|", views: nameLbl)
//
//    addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
    
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
}

