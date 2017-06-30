//
//  CurrentGoalsCell.swift
//  GymApp
//
//  Created by David on 26/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class CurrentGoalsCell: UITableViewCell {
  
  var goal: GoalInfo!
  
  @IBOutlet var goalName: UILabel!
  @IBOutlet weak var goalLbl: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(goal: GoalInfo) {
    self.goal = goal
    self.goalName.text = goal.goalName
  }
  
}
