//
//  GoalInfo.swift
//  GymApp
//
//  Created by David on 26/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct GoalInfo {
  
   private var _goalName: String!
   private var _frequencyOfGoal: String!
   private var _frequencyWeek: String!
   private var _postKey: String!
  
  var goalName: String {
    return _goalName
  }
  
  var frequencyOfGoal: String {
    return _frequencyOfGoal
  }
  
  var frequencyWeek: String {
    return _frequencyWeek
  }
  
  var key: String {
    return _postKey
  }
  
  
  init(key: String, goalData: Dictionary<String, AnyObject>) {
    self._postKey = key
    
    if let goalName = goalData["nameOfGoal"] as? String {
      self._goalName = goalName
    }
    
    if let frequencyOfGoal = goalData["frequencyOfGoal"] as? String {
      self._frequencyOfGoal = frequencyOfGoal
    }
    
    if let frequencyWeek = goalData["frequencyWeek"] as? String {
      self._frequencyWeek = frequencyWeek
    }

  }
  
}
