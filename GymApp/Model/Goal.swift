//
//  Goal.swift
//  GymApp
//
//  Created by David on 30/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class Goal {
  
  private var _goalName: String!
  private var _goalDescription: String!
  private var _goalPoints: Int!
  private var _postKey: String!
//  private var _imageView: UIImageView!
  
  var goalName: String {
    return _goalName
  }
  
  var goalDescription: String {
    return _goalDescription
  }
  
  var goalPoints: Int {
    return _goalPoints
  }
  
  var postKey: String {
    return _postKey
  }
  
//  var imageView: UIImageView {
//    return _imageView
//  }
  
  init(goalName: String, description: String, goalPoints: Int) {
    self._goalName = goalName
    self._goalDescription = goalDescription
    self._goalPoints = goalPoints
  }
  
  init(postyKey: String, goalData: Dictionary<String, Any>) {
    self._postKey = postyKey
    
    if let goalName = goalData["className"] as? String {
      self._goalName = goalName
    }
    
    if let description = goalData["goalDesc"] as? String {
      self._goalDescription = description
    }
    
    if let points = goalData["goalPoints"] as? Int {
      self._goalPoints = points
    }
  }
}
