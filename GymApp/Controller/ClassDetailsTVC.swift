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

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // This return a list of all the classes attached to the root of the database - classDetails.
//      DataService.ds.REF_CLASSES.observe(.value, with: { (snapshot) in
//        print(snapshot.value)
//        if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//          for snap in snapshots {
//            print("DAVID: \(snap)")
//            if let classDict = snap.value as? Dictionary<String, AnyObject> {
//              let name = snap.key
//              let classDetails = ClassInfo(className: name, classData: classDict)
//              self.classDeets.append(classDetails)
//            }
//          }
//        }
//        self.tableView.reloadData()
//      })
      
      // Thsi returns a single object for the class BodyPump, attached to its parent node classDetails
      DataService.ds.REF_CLASSES.child("Bodypump").observe(.value, with: { (snapshot) in
        print(snapshot.value)
      })
      
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
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
