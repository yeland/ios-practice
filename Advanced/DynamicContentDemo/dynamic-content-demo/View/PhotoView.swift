//
//  PhotoOfCell.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class PhotoView: UIView {
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  
  func configure(with images: [Image]) {
    guard let url = URL(string: images[0].url) else { return }
    image1.setImage(withURL: url)
    
    if images.count == 2 {
      guard let url = URL(string: images[1].url) else { return }
      image2.setImage(withURL: url)
    }
    
    if images.count >= 3 {
      guard let url = URL(string: images[1].url) else { return }
      image2.setImage(withURL: url)
      guard let url1 = URL(string: images[2].url) else { return }
      image3.setImage(withURL: url1)
    }
  }
  
  func prepareForReuse() {
    image1.image = nil
    image2.image = nil
    image3.image = nil
  }
}
