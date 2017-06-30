//
//  GoalTableViewCell.swift
//  GymApp
//
//  Created by David on 30/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation
import UIKit

class GoalTableViewCell: UITableViewCell {
  
  @IBOutlet weak var goalNameLbl: UILabel!
  
  @IBOutlet weak var goalImageView: UIImageView!
  
  @IBOutlet weak var goalRequirementDesc: UILabel!
  
  @IBOutlet weak var goalNumberOfPoints: UILabel!
  
  var goalDetails: Goal!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(goalDetails: Goal) {
    self.goalDetails = goalDetails
    self.goalNameLbl.text = goalDetails.goalName
    let goalInt = ("\(goalDetails.goalPoints)")
    self.goalRequirementDesc.text = goalDetails.goalDescription
    self.goalNumberOfPoints.text = goalInt
  }
  
  
}
