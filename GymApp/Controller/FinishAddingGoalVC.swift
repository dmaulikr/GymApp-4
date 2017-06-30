//
//  FinishAddingGoalVC.swift
//  GymApp
//
//  Created by David on 24/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class FinishAddingGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet var frequencyValuePicker: UIPickerView!
  @IBOutlet var frequencyType: UISegmentedControl!
  
  let frequencyTypes = ["Day", "Week", "Month"]
  let frequencyValues = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
  let dayInSeconds = Double(86400)
  var goalName: String!
  var goalCategory: String!
  
  var goal: GoalMO!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.frequencyValuePicker.delegate = self
    self.frequencyValuePicker.dataSource = self
    
    
  }
  
  @available(iOS 2.0, *)
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  @available(iOS 2.0, *)
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return frequencyValues.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "\(frequencyValues[row])"
  }
  
  @IBAction func finishBtnPressed(_ sender: Any) {
//    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
      let frequencyType = "\(frequencyTypes[self.frequencyType.selectedSegmentIndex])"
      let frequency = Double(frequencyValues[self.frequencyValuePicker.selectedRow(inComponent: 0)])
//      goal = GoalMO(context: appDelegate.persistentContainer.viewContext)
//      goal.name = goalName
//      goal.category = goalCategory
//      goal.frequencyType = frequencyType
//      goal.nextDue = Date(timeIntervalSince1970: -36000) as NSDate
//
//      print("Saving data to context")
//      appDelegate.saveContext()
//      dismiss(animated: true, completion: nil)
//    }
    
    guard let uid = Auth.auth().currentUser else { return }
    guard let goalN = goalName else { return }
    guard let goalCat = goalCategory else { return }
    
    let dictionaryValues = ["name": goalN]
    let values = [uid: dictionaryValues]
    
    Database.database().reference().child("goals").updateChildValues(values) { (err, ref) in
      if let err = err {
        print("Failed to save user in db")
        return
      }
      print("Successfully saved the user into the DB")
    }
    
    dismiss(animated: true, completion: nil)
    
    //DataService.ds.createFirebaseDBGoal(goalData: <#T##Dictionary<String, String>#>)
    
    
    
    
    
  }
  
  
}
