//
//  NetworkClient.swift
//  dynamic-content-demo
//
//  Created by Xin Guo on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkClient {
  func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url).validate().responseData { dataResponse in
      switch dataResponse.result {
      case let .success(data):
        completion(data, nil)
      case let .failure(error):
        completion(nil, error)
      }
    }
  }
}
