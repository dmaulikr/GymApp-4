//
//  MenuVC.swift
//  GymApp
//
//  Created by David on 16/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MenuVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var logOutBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
  }
  
  
  @IBAction func logOutPressed(_ sender: Any) {
    do {
      try Auth.auth().signOut()
    } catch let logOutError {
      print(logOutError)
    }
    _ = KeychainWrapper.standard.removeObject(forKey: "uid")
    print("ID removed from keychain")
    performSegue(withIdentifier: "logOut", sender: nil)
  }
  

}
