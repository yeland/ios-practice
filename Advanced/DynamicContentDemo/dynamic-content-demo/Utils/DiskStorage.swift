//
//  DiskStorage.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/12.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class DiskStorage {
  private static let instance : DiskStorage = DiskStorage()
  class var sharedDisk: DiskStorage {
    return instance
  }
  var fileManager = FileManager.default
  let diskPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
  lazy var cacheDirectory = diskPaths[0] as NSString
  
  func store(urlString: String, data: Data) {
    let dirPath = cacheDirectory.appendingPathComponent("image")
    
    let url = URL(fileURLWithPath: cacheFilePath(forKey: urlString))
    do {
      try self.fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
      try data.write(to: url)
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func value(urlString: String) -> Data? {
    let image = UIImage(contentsOfFile: cacheFilePath(forKey: urlString))
    return image?.pngData()
  }
  
  func cacheFilePath(forKey key: String) -> String {
    let path = key.split(separator: ".")[2].split(separator: "/")
    let diskPath = cacheDirectory.appendingPathComponent("image/\(path[path.count - 2])\(path[path.count - 1])")
    return diskPath
  }
}
