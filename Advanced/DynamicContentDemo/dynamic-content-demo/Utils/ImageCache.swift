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
  private let networkClient: NetworkClient = .init()
  
  class var sharedLoader : ImageCache {
    return instance
  }
  
  var cache = NSCache<AnyObject, AnyObject>()
  var fileManager = FileManager.default
  
  func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {

    let imageQueue = DispatchQueue(label: "com.brycegao.gcdtest")
    let diskPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let cacheDirectory = diskPaths[0] as NSString
    let dirPath = cacheDirectory.appendingPathComponent("image")
    let path = urlString.split(separator: ".")[2].split(separator: "/")
    let diskPath = cacheDirectory.appendingPathComponent("image/\(path[path.count - 1])")

    imageQueue.async {
      let data: Data? = self.cache.object(forKey: urlString as AnyObject) as? Data
      if let goodData = data {
        let image = UIImage(data: goodData as Data)
        DispatchQueue.main.async {
          completionHandler(image, urlString)
        }
        return
      }
      
      if self.fileManager.fileExists(atPath: diskPath) {
        let image = UIImage(contentsOfFile: diskPath)
        self.cache.setObject((image!).jpegData(compressionQuality: 1.0) as AnyObject, forKey: urlString as AnyObject)
        DispatchQueue.main.async {
          completionHandler(image, urlString)
        }
        return
      }
      
      self.networkClient.request(url: URL(string: urlString)!) { (data, error) in
        if let error = error {
          print(error.localizedDescription)
          completionHandler(nil, urlString)
          return
        }
        
        if data != nil {
          let image = UIImage(data: data!)
          let url = URL(fileURLWithPath: diskPath)
          
          do {
            try self.fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            try data?.write(to: url)
          } catch let error {
            print(error.localizedDescription)
          }
          self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
          DispatchQueue.main.async {
            completionHandler(image, urlString)
          }
          return
        }
      }
    }
  }
}
