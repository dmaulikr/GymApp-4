//
//  DataService.swift
//  GymApp
//
//  Created by David on 16/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
  
  static let ds = DataService()
  
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("users")
  private var _REF_CLASSES = DB_BASE.child("classDetails")
  private var _REF_GOALSUNDERWAY = DB_BASE.child("userGoals")
  private var _REF_CLASSESATTENDING = DB_BASE.child("attendingClasses")
  private var _REF_STATICGOALS = DB_BASE.child("goals")
  
  var REF_STATICGOALS: DatabaseReference {
    return _REF_STATICGOALS
  }
  
  var REF_BASE: DatabaseReference {
    return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference {
    return _REF_USERS
  }
  
  var REF_CLASSES: DatabaseReference {
    return _REF_CLASSES
  }
  
  var REF_GOALSUNDERWAY: DatabaseReference {
    return _REF_GOALSUNDERWAY
  }
  
  var REF_CLASSESATTENDING: DatabaseReference {
    return _REF_CLASSESATTENDING
  }
  
  // Creates a new firebase user
  func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
    REF_USERS.child(uid).updateChildValues(userData)
  }
  
  // Creates a new class and uploads it to Firebase DB. Only accessible via PT-side of the app
  func createFirebaseDBClass(classData: Dictionary<String, String>) {
    let key = REF_CLASSES.childByAutoId().key
    let classDetails = classData
    let childUpdates = ["/classDetails/\(key)": classDetails]
    DB_BASE.updateChildValues(childUpdates)
  }
  
  func addClassToUserInDatabase(uid: String, classInfo: Dictionary<String, Any>) {
    let key = REF_CLASSESATTENDING.childByAutoId().key
    let classInfo = classInfo
    let childUpdates = ["/attendingClasses/\(uid)/\(key)": classInfo]
    DB_BASE.updateChildValues(childUpdates)
  }
  
  func createFirebaseDBGoal(uid: String, goalData: Dictionary<String, String>) {
    let key = REF_GOALSUNDERWAY.childByAutoId().key
    let goalDetails = goalData
    let childUpdates = ["/userGoals/\(uid)/\(key)": goalDetails]
    DB_BASE.updateChildValues(childUpdates)
  }
  
}
