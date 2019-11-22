//
//  UserService.swift
//  NetworkingDemo
//
//  Created by Linxiao Wei on 2019/11/21.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class ContentService {
  var defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  var errorMessage = ""
  var contents: [Content] = []
  typealias Result = ([Content]?, String) -> Void
  
  func getResults(completion: @escaping Result) {
    
    dataTask?.cancel()
    
    if let urlComponents = URLComponents(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets") {
      
      guard let url = urlComponents.url else { return }
      
      dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
        if let error = error {
          self?.errorMessage = error.localizedDescription
        } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
          do {
            self?.contents = try JSONDecoder().decode([Content].self, from: data)
          } catch let error {
            self?.errorMessage = error.localizedDescription
          }
        } else {
          self?.errorMessage = "Unknown error"
        }
      
        DispatchQueue.main.async {
          completion(self?.contents, self?.errorMessage ?? "")
        }
      }
      
      dataTask?.resume()
    }
    
  }
}
