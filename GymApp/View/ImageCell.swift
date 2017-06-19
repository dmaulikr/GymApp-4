//
//  ImageCell.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

  @IBOutlet var imageCell: UIImageView!
  @IBOutlet var imageTitle: UILabel!
  @IBOutlet var imageHeight: NSLayoutConstraint!
  @IBOutlet var imageTop: NSLayoutConstraint!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    imageCell.clipsToBounds = true
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(title: String, image: UIImage) {
    
    self.imageTitle.text = title
    self.imageCell.image = image
  }

}
