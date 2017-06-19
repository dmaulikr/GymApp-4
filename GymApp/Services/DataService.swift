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
  private var _REF_POSTS = DB_BASE.child("posts")
  private var _REF_USERS = DB_BASE.child("users")
  private var _REF_CLASSES = DB_BASE.child("classDetails")
  
  var REF_BASE: DatabaseReference {
    return _REF_BASE
  }
  
  var REF_POSTS: DatabaseReference {
    return _REF_POSTS
  }
  
  var REF_USERS: DatabaseReference {
    return _REF_USERS
  }
  
  var REF_CLASSES: DatabaseReference {
    return _REF_CLASSES
  }
  
  func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
    REF_USERS.child(uid).updateChildValues(userData)
  }
  
  
  
}
