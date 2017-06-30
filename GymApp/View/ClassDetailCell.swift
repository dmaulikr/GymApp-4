//
//  ClassDetailCell.swift
//  GymApp
//
//  Created by David on 19/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassDetailCell: UITableViewCell {

  @IBOutlet var spacesLeft: UILabel!
  @IBOutlet var descriptionOfClass: UILabel!
  @IBOutlet var time: UILabel!
  @IBOutlet var date: UILabel!
  @IBOutlet var instructor: UILabel!
  
  var classDetails: ClassInfo!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(classDetails: ClassInfo) {
    self.classDetails = classDetails
    self.spacesLeft.text = classDetails.numberOfSpaces
    //self.descriptionOfClass.text = class.description
    self.time.text = classDetails.time
    self.date.text = classDetails.date
    self.instructor.text = classDetails.instructor
    
  }

}
