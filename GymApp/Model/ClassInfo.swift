//
//  ClassInfo.swift
//  GymApp
//
//  Created by David on 19/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class ClassInfo {
  
  private var _instructor: String!
  private var _time: String!
  private var _date: String!
  private var _numberOfSpaces: String!
  private var _className: String!
  private var _postKey: String!
  
  var instructor: String {
    return _instructor
  }
  
  var time: String {
    return _time
  }
  
  var date: String {
    return _date
  }
  
  var numberOfSpaces: String {
    return _numberOfSpaces
  }
  
  var className: String {
    return _className
  }
  
  var postKey: String {
    return _postKey
  }
  
  init(instructor: String, time: String, date: String, numberOfSpaces: String, className: String) {
    self._instructor = instructor
    self._time = time
    self._date = date
    self._numberOfSpaces = numberOfSpaces
    self._className = className
  }
  
  init(postKey: String, classData: Dictionary<String, Any>) {
    
   self._postKey = postKey
    
    if let instructor = classData["instructor"] as? String {
      self._instructor = instructor
    }
    
    if let time = classData["time"] as? String {
      self._time = time
    }
    
    if let date = classData["date"] as? String {
      self._date = date
    }
    
    if let numberOfSpaces = classData["numberOfSpaces"] as? String {
      self._numberOfSpaces = numberOfSpaces
    }
    
  }
  
  
  
  
  
}






























