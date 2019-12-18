//
//  UIImageView+Networking.swift
//  dynamic-content-demo
//
//  Created by Xin Guo on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
  func setImage(withURL url: String) {
    let imageCache = ImageCache.sharedLoader
    imageCache.imageForUrl(urlString: url) { [weak self] data in
      let image = UIImage(data: data)
      self?.image = image
    }
  }
}
