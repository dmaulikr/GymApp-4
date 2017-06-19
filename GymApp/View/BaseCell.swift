//
//  BaseCell.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
