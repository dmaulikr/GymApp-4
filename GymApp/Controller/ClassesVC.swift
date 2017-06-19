//
//  ClassesVC.swift
//  
//
//  Created by David on 15/06/2017.
//

import UIKit

class ClassesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tableView: UITableView!
  
  var titles = ["Body Pump", "Pilates", "Fusion", "Spinning", "Bodybuilding"]
  
  var images: [UIImage] = [
    UIImage(named: "fitness1")!,
    UIImage(named: "fitness2")!,
    UIImage(named: "fitness3")!,
    UIImage(named: "fitness4")!,
    UIImage(named: "fitness5")!
  ]
  
  var parallaxOffsetSpeed: CGFloat = 60
  
  var cellHeight: CGFloat = 250
  
  var imageHeight: CGFloat {
    let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
    
    return maxOffset + self.cellHeight
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      navigationController?.navigationBar.tintColor = .black
    navigationController?.hidesBarsOnTap = true
    UIApplication.shared.statusBarStyle = .lightContent
    
    tableView.delegate = self
    tableView.dataSource = self
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as? ImageCell {
      
      cell.configureCell(title: titles[indexPath.row], image: images[indexPath.row])
     cell.imageHeight.constant = imageHeight
     cell.imageTop.constant = parallaxOffset(newOffSetY: tableView.contentOffset.y, cell: cell)
      
      return cell
    } else {
      return ImageCell()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "classChosen", sender: self)
  }
  
  func parallaxOffset(newOffSetY: CGFloat, cell: UITableViewCell) -> CGFloat {
    
    return (newOffSetY - cell.frame.origin.y) / cellHeight * parallaxOffsetSpeed
    
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let offsetY = tableView.contentOffset.y
    for cell in tableView.visibleCells as! [ImageCell] {
      cell.imageTop.constant = parallaxOffset(newOffSetY: tableView.contentOffset.y, cell: cell)
    }
    
  }
  
  
}
