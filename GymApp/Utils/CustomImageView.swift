//
//  CustomImageView.swift
//  GymApp
//
//  Created by David on 24/06/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class CustomImageView: UIImageView {
  
  func loadImage(urlString: String) {
    print("Loading image...")
    
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if let err = err {
        print("Failed to fetch post image: ", err)
        return
      }
      
      guard let imageData = data else { return }
      
      let photoImage = UIImage(data: imageData)
      
      DispatchQueue.main.async {
        self.image = photoImage
      }
      
      
    }.resume()
  }
}
