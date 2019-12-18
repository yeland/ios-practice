//
//  PhotoCell.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/4.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  @IBOutlet weak var photo: UIImageView!
  
  func configure(with image: Image) {
    photo.setImage(withURL: image.url)
  }
  
  override func prepareForReuse() {
    self.photo.image = nil
  }
}
