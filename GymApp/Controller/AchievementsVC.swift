//
//  AchievementsVC.swift
//  GymApp
//
//  Created by David on 15/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import GameKit

class AchievementsVC: UIViewController, GKGameCenterControllerDelegate {
  
  var gcEnabled = Bool()
  var gcDefaultLeaderBoard = String()
  
  var score = 0
  
  let LEADERBOARD_ID = "com.score.gymapp"
  
  @IBOutlet weak var scoreLbl: UILabel!
  
  @IBAction func leaderboardButtonPressed(_ sender: Any) {
    print(123)
    let gcVC = GKGameCenterViewController()
    gcVC.gameCenterDelegate = self
    gcVC.viewState = .leaderboards
    gcVC.leaderboardIdentifier = LEADERBOARD_ID
    present(gcVC, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   navigationController?.navigationBar.tintColor = .black
    authenticatedLocalPlayer()
    }
  
  func authenticatedLocalPlayer() {
    let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    
    localPlayer.authenticateHandler = {(AchievementsVC, error) -> Void in
      if ((AchievementsVC) != nil) {
        // 1. Show login if player is not logged in
        self.present(AchievementsVC!, animated: true, completion: nil)
     } else if (localPlayer.isAuthenticated) {
        // 2. Player is already authentictaed and logged in, load game center
        self.gcEnabled = true
        
        // Get the default leaderboard ID
        localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifier, error) in
          if error != nil { print(error)
          } else { self.gcDefaultLeaderBoard = leaderboardIdentifier! }
        })
      } else {
        // 3. Game center is not enabled on the users device
        self.gcEnabled = false
        print("Local player could not be authengticated!")
        print(error)
      }
    }
  }
  
  @IBAction func addScoreAndSubmitToGC(_ sender: Any) {
    score += 10
    scoreLbl.text = "\(score)"
    
    // Submit score to GC leaderboard
    let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
    bestScoreInt.value = Int64(score)
    GKScore.report([bestScoreInt]) { (error) in
      if error != nil {
        print(error!.localizedDescription)
      } else {
        print("Best score submitted to your leaderboard")
      }
    }
  }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @available(iOS 6.0, *)
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
}
