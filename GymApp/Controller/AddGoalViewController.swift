//
//  AddGoalViewController.swift
//  GymApp
//
//  Created by David on 26/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class AddGoalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var bookmarkGoalBrn: UIBarButtonItem!
  
  var btnEnabled = false
  
  var goalDetails = [Goal]()
  
  var progress: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    bookmarkGoalBrn.isEnabled = btnEnabled
    
    setupTableView()
    
  }
  
  @IBAction func bookmarkGoalBtnPressed(_ sender: Any) {
    performSegue(withIdentifier: "bookMarkBtnPressed", sender: self)
    
  }
  
  @objc fileprivate func setupTableView() {
    Database.database().reference().child("goals").observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
        for snap in snapshots {
          print("SNAP: \(snap)")
          if let snapDict = snap.value as? Dictionary<String, AnyObject> {
            let key = snap.key
            print("\(key)")
            let goalDetails = Goal(postyKey: key, goalData: snapDict)
            self.goalDetails.append(goalDetails)
            print(self.goalDetails.count)
          }
        }
      }
      self.tableView.reloadData()
      
    })
    
  }
  
  @available(iOS 2.0, *)
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return goalDetails.count
  }
  
  @available(iOS 2.0, *)
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let goal = goalDetails[indexPath.row]
      if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? GoalTableViewCell {
        cell.configureCell(goalDetails: goal)
        return cell
      } else {
        return ClassDetailCell()
      }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let goalName = goalDetails[indexPath.row].goalName
    let goalDescfiption = goalDetails[indexPath.row].goalDescription
    
    let menu = UIAlertController(title: "Add goal?", message: "Would you like to start trying to achieve this goal?", preferredStyle: .alert)
    let addGoal = UIAlertAction(title: "Add", style: .default, handler: {(alert: UIAlertAction!) in print("Goal added")
      self.addGoalToDatabase(goalDeets: self.goalDetails[indexPath.row])
    })
    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    menu.addAction(addGoal)
    menu.addAction(cancel)
    present(menu, animated: true)
    
  }
  
  
  fileprivate func addGoalToDatabase(goalDeets: Goal) {
    
    let goalInfo = goalDeets
    guard let uid = Auth.auth().currentUser?.uid else { return }
    bookmarkGoalBrn.isEnabled = true
    DataService.ds.createFirebaseDBGoal(uid: uid, goalData: ["goalName": goalInfo.goalName,
                                                             "progress": ("\(progress)"),
                                                             ])
    
    
  }
  
  
  
  
    

  
  
  
  
//  @IBAction func addGoalBtnPressed(_ sender: Any) {
  
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    guard let nameOfGoal = nameOfGoalTextField.text else { return }
//    guard let frequency = frequencyTextField.text else { return }
//
//    if nameOfGoalTextField.text == "" || frequencyTextField.text == "" {
//      let alertController = UIAlertController(title: "Oops!!", message: "Must fill in all corresponding fields", preferredStyle: .alert)
//      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//      alertController.addAction(alertAction)
//      present(alertController, animated: true, completion: nil)
//    }
//
//
//    DataService.ds.createFirebaseDBGoal(uid: uid, goalData: ["nameOfGoal": nameOfGoal,
//                                                             "frequencyOfGoal": frequency,
//                                                             "frequencyWeek": frequencyChosen!] )
//

  
  
  
}
