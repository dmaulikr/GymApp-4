//
//  UploadClassTVC.swift
//  GymApp
//
//  Created by David on 19/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class UploadClassTVC: UITableViewController {

  @IBOutlet var nameOfClass: UITextField!
  
  @IBOutlet var nameOfInstructor: UITextField!
  
  @IBOutlet var date: UITextField!
  
  @IBOutlet var time: UITextField!
  
  @IBOutlet var numberOfSpaces: UITextField!
  
  @IBOutlet var descriptionOfClass: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    
    }
  
  @IBAction func addBtnPressed(_ sender: Any) {
    if nameOfClass.text == "" || nameOfInstructor.text == "" || date.text == "" || time.text == "" || numberOfSpaces.text == "" {
      let alertController = UIAlertController(title: "Oops", message: "You must ensure that every field is filled in correcttly", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(alertAction)
      present(alertController, animated: true, completion: nil)
    }
    
//    DataService.ds.createFirebaseDBClass(className: nameOfClass.text!, classData: ["nameOfClass": nameOfClass.text!,
//                                                     "date": date.text!,
//                                                     "instructor": nameOfInstructor.text!,
//                                                     "numberOfSpaces": numberOfSpaces.text!,
//                                                     "time": time.text!])
    
    DataService.ds.createFirebaseDBClass(classData: ["nameOfClass": nameOfClass.text!,
                                                                                   "date": date.text!,
                                                                                   "instructor": nameOfInstructor.text!,
                                                                                   "numberOfSpaces": numberOfSpaces.text!,
                                                                                   "time": time.text!])
    
//    let ref = Database.database().reference()
//    let key = ref.child("classDetails").childByAutoId().key
//    let classDetails = ["nameOfClass" : nameOfClass.text!,
//                 "date": date.text!,
//                 "instructor": nameOfInstructor.text!,
//                 "numberOfSpaces": numberOfSpaces.text!,
//                 "time": time.text!]
//
//    let childUpdates = ["/classDetails/\(key)": classDetails]
//    ref.updateChildValues(childUpdates)
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

  

}
