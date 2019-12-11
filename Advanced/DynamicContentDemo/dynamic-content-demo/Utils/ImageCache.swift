//
//  ImageCache.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/11.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class ImageCache {
  
  private static let instance : ImageCache = ImageCache()
  
  class var sharedLoader : ImageCache {
    return instance
  }
  
  var cache = NSCache<AnyObject, AnyObject>()
  
  func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
    DispatchQueue.global().async {
      let data: Data? = self.cache.object(forKey: urlString as AnyObject) as? Data
      if let goodData = data {
        let image = UIImage(data: goodData as Data)
        DispatchQueue.main.async {
          completionHandler(image, urlString)
        }
        return
      }
      
      let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
        if (error != nil) {
          completionHandler(nil, urlString)
          return
        }
        
        if data != nil {
          let image = UIImage(data: data!)
          self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
          DispatchQueue.main.async {
            completionHandler(image, urlString)
          }
          return
        }
      })
      downloadTask.resume()
    }
  }
}
