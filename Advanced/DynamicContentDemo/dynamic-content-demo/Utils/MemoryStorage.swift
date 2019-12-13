//
//  MemoryStorage.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/12.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class MemoryStorage {
  private static let instance : MemoryStorage = MemoryStorage()
  class var sharedMemory: MemoryStorage {
    return instance
  }
  var cache = NSCache<AnyObject, AnyObject>()
  
  func value(urlString: String) -> Data? {
    return self.cache.object(forKey: urlString as AnyObject) as? Data
  }
  
  func store(urlString: String, data: Data) {
    self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
  }
}
