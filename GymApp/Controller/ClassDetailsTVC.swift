//
//  ClassDetailsTVC.swift
//  GymApp
//
//  Created by David on 19/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class ClassDetailsTVC: UITableViewController {
  
  var classDeets = [ClassInfo]()
  var className: String!
  
  // This method queries the database for all the nodes that contain the passed in class name, and displays them in the tableview.
  fileprivate func setUpTableView() {
    let classN = className
    let _ = DataService.ds.REF_CLASSES.queryOrdered(byChild: "nameOfClass").queryEqual(toValue: classN).observe(.value, with: { (snapshot) in
      print("CATHERINE: \(snapshot.value!)")
      if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
        for snap in snapshots {
          print("SNAP: \(snap)")
          if let snapDict = snap.value as? Dictionary<String, AnyObject> {
            let key = snap.key
            
            let classDetail = ClassInfo(postKey: key, classData: snapDict)
            self.classDeets.append(classDetail)
          }
        }
      }
      self.tableView.reloadData()
    })
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = className
    navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Light", size: 30)!], for: UIControlState.normal)
    
    setUpTableView()
    
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
    return classDeets.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
   let classesInfo = classDeets[indexPath.row]
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ClassDetailCell {
      cell.configureCell(classDetails: classesInfo)
      return cell
    } else {
      return ClassDetailCell()
    }
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("section: \(indexPath.section)")
    print("row: \(indexPath.row)")
    
    print(className)
    let classDate = classDeets[indexPath.row].date
    let classTime = classDeets[indexPath.row].time
    print(classDate)
    print(classTime)
    
    let optionMenu = UIAlertController(title: "Attend class?", message: nil, preferredStyle: .actionSheet)
    let attendClass = UIAlertAction(title: "Attend", style: .default, handler: nil)
    optionMenu.addAction(attendClass)
    present(optionMenu, animated: true) {
      print("HELLO")
      
      guard let uid = Auth.auth().currentUser?.uid else { return }
      DataService.ds.addClassToUserInDatabase(uid: uid, classInfo: ["className": self.className,
                                                                    "classDate": classDate,
                                                                    "classTime": classTime])
    }
    
    
    
  }
 

}
