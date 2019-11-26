//
//  ItemService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class ItemService {
  var defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  var errorMessage = ""
  var items: [Item] = []
  typealias Result = ([Item]?, String) -> Void
  
  func getResults(completion: @escaping Result) {
    
    dataTask?.cancel()
    
    if let urlComponents = URLComponents(string: "https://workshop-pos-api.herokuapp.com/api/items") {
      
      guard let url = urlComponents.url else { return }
      
      var request = URLRequest(url: url)
      
      request.setValue("5bCP5YCf5YCf", forHTTPHeaderField: "identifier")
      
      dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
        if let error = error {
          self?.errorMessage = error.localizedDescription
        } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
          do {
            self?.items = try JSONDecoder().decode([Item].self, from: data)
            print(self?.items[0].name ?? "")
          } catch let error {
            self?.errorMessage = error.localizedDescription
          }
        } else {
          self?.errorMessage = "Unknown error"
        }
      
        DispatchQueue.main.async {
          completion(self?.items, self?.errorMessage ?? "")
        }
      }
      
      dataTask?.resume()
    }
    
  }
}
