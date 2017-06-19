//
//  SettingsLaucnher.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class Setting: NSObject {
  var name: String
  let imageName: String
  
  init(name: String, imageName: String) {
    self.name = name
    self.imageName = imageName
  }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let blackView = UIView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    return cv
    
  }()
  
  let cellHeight: CGFloat = 50
  let cellId = "cellId"
  var classesVC: ClassesVC?
  var achievementsVC: AchievementsVC?
  var homeVC: HomeVC?
  
  
  // Need icons for the profile image and the log out image
  let settings: [Setting] = {
    return [Setting(name: "Settings", imageName: "settings"), Setting(name: "Profile", imageName: "profile-1"), Setting(name: "Log out", imageName: "cancel")]
  }()
  
  func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height: CGFloat = CGFloat(settings.count) * cellHeight
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
        self.blackView.alpha = 1
        
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
      }, completion: nil)
      
    }
    
  }
  
  func handleDismiss() {
    UIView.animate(withDuration: 0.5) {
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
    
    let setting = settings[indexPath.item]
    cell.setting = setting
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
      
      
    }) { (completion: Bool) in
      
      let setting = self.settings[indexPath.item]
      if setting.name == "Log out" {
//        do {
//          try Auth.auth()?.signOut()
//        } catch let logoutError {
//          print(logoutError)
//        }
        _ = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("DAVID: ID removed from keychain!")
        
        //self.classesVC?.showControllerForLogOut(setting: setting)
        self.homeVC?.showControllerForLogOut(setting: setting)
        //self.achVC?.showControllerForLogOut(setting: setting)
        //self.calendarVC?.showControllerForLogOut(setting: setting)
        //self.gymPassVC?.showControllerForLogOut(setting: setting)
        
      }
      //self.classesVC?.showControllerForSetting(setting: setting)
      self.homeVC?.showControllerForSetting(setting: setting)
      //self.achVC?.showControllerForSetting(setting: setting)
      //self.calendarVC?.showControllerForSetting(setting: setting)
     // self.gymPassVC?.showControllerForSetting(setting: setting)
    }
  }
  
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    
  }
}
