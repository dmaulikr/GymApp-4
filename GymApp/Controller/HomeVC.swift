//
//  HomeVC.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import Photos
import CoreData

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let cellId = "CellId"
  
  @IBOutlet weak var pointsLbl: UILabel!
  @IBOutlet weak var levelLbl: UILabel! 
  @IBOutlet weak var classNameHomeLbl: UILabel!
  @IBOutlet var menuButton: UIBarButtonItem!
  @IBOutlet weak var classHomeImageView: UIImageView! {
    didSet {
      self.classHomeImageView.layer.cornerRadius = classHomeImageView.frame.width / 2
      self.classHomeImageView.clipsToBounds = true
      self.classHomeImageView.contentMode = .scaleAspectFill
      self.classHomeImageView.layer.shadowColor = UIColor.lightGray.cgColor
      self.classHomeImageView.layer.shadowOpacity = 0.8
      self.classHomeImageView.layer.shadowRadius = 5
      self.classHomeImageView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
  }
  @IBOutlet weak var classHomeDateLbl: UILabel!
  @IBOutlet var profileImageView: UIImageView! {
    didSet {
      self.profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
  }
  @IBOutlet var greetingsLabel: UILabel!
  
  var user: User? {
    didSet {
      guard let profileImage = user?.profileImageUrl else { return }
      fetchUserProfile(urlString: profileImage)
    }
  }
  
  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    //self.view.backgroundColor = UIColor(red: 97/255, green: 132/255, blue: 216/255, alpha: 1.0)
     self.view.backgroundColor = UIColor.lightGray
    navigationController?.navigationBar.tintColor = .black
    
    fetchInfoFromDatabase()
    profileImageView.clipsToBounds = true
    fetchNextClass()
    
    let tapped = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
    profileImageView.addGestureRecognizer(tapped)
    profileImageView.isUserInteractionEnabled = true
    

    }
  
  func tappedMe() {
    performSegue(withIdentifier: "profileImageViewBtnPressed", sender: self)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! NewsFeedCell
    return cell
    
    
  }
  
  var goals = [GoalInfo]()
  
//  fileprivate func fetchGoalsFromFirebase() {
  
//    print("DAVID: FETCHING GOALS HEW")
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    Database.database().reference().child("userGoals").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//      print(snapshot.value ?? "")
//
//      guard let dictionary = snapshot.value as? [String: Any] else { return }
//      print("DAVID: \(dictionary)")
//
//
//      self.goals = GoalInfo(dictionary: dictionary)
//      self.goalNameLbl.text = self.goals?._goalName
//      print(self.goalNameLbl.text ?? "")
//
//    })
//     guard let uid = Auth.auth().currentUser?.uid else { return }
//    Database.database().reference().child("userGoals").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//      print("DAVID: \(snapshot.value)")
//
//      if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//        for snap in snapshots {
//          print("SNAP: \(snap)")
//          if let snapDict = snap.value as? Dictionary<String, AnyObject> {
//           let key = snap.key
//            let goal = GoalInfo(key: key, goalData: snapDict)
//            self.goals.append(goal)
//            print(self.goals.count)
//          }
//        }
//      }
//
//
//    }) { (err) in
//      print("Failed!")
//    }
//  }
    
  fileprivate func fetchUserProfile(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if let err = err {
        print("failed to get user profile")
        return
      }
      
      guard let imageData = data else { return }
      
      let photoImage = UIImage(data: imageData)
      
      DispatchQueue.main.async {
        self.profileImageView.image = photoImage
        print("This is your user profile", photoImage)
      }
    }.resume()
  }
  
  fileprivate func fetchInfoFromDatabase() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      print("DAVID: \(dictionary)")
      
      self.user = User(dictionary: dictionary)
      self.navigationItem.title = self.user?.name
      self.greetingsLabel.text = "Hello \(self.user?.name ?? ""), how are you today?"
      print(self.greetingsLabel.text)
      print(uid)
      
    }) { (err) in
      print("Failed to fetch user: ", err)
    }
  }
  
  var classes = [ClassInfo]()
  var classHome: HomeClassInfo?
  
  fileprivate func fetchNextClass() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let ref = Database.database().reference().child("attendingClasses").child(uid)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      print("DAVIDWARD \(snapshot.value)")
      if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
        print("JAZZY \(snapshots)")
        for snap in snapshots {
          if let snapDict = snap.value as? Dictionary<String, AnyObject> {
            print("\(snapDict)")
            for (key, value) in snapDict {
              self.classNameHomeLbl.text = snapDict["className"] as! String
              self.classHomeDateLbl.text = snapDict["classDate"] as! String
            }
          }
        }
      }
      self.reloadInputViews()
    }) { (err) in
      print("Failed to load all the classes")
    }
  }
 

}


struct User {
  let name: String
  let profileImageUrl: String
  init(dictionary: [String: Any]) {
    self.name = dictionary["name"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageURL"]  as? String ?? ""
  }
}

struct HomeClassInfo {
  var className: String
  
  init(dict: [String: Any]) {
    self.className = dict["className"] as? String ?? ""
  }
  
}

    

