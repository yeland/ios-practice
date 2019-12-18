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
  private let memoryStorage = MemoryStorage.sharedMemory
  private let diskStorage = DiskStorage.sharedDisk
  
  class var sharedLoader : ImageCache {
    return instance
  }
  
  func imageForUrl(urlString: String, completionHandler:@escaping (_ data: Data) -> ()) {
    if let data = self.memoryStorage.value(urlString: urlString) {
      completionHandler(data)
      return
    }
    
    let imageQueue = DispatchQueue(label: "com.moment.image")
    imageQueue.async {
      if let data = self.diskStorage.value(urlString: urlString) {
        DispatchQueue.main.async {
          completionHandler(data)
        }
        self.memoryStorage.store(urlString: urlString, data: data)
        return
      }
      
      self.networkClient.request(url: URL(string: urlString)!) { (data, error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        if let data = data {
          DispatchQueue.main.async {
            completionHandler(data)
          }
          self.diskStorage.store(urlString: urlString, data: data)
          self.memoryStorage.store(urlString: urlString, data: data)
          return
        }
      }
    }
  }
}
