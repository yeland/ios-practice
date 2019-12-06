//
//  ItemService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class NetWorkService {
  var defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  
  var items: [Item] = []
  var promotionBarcodes: [String] = []
  
  func fetchData(completion: @escaping ([Item]?, [String]) -> Void) {
    getItems() { [weak self] results, errorMessage in
      if let results = results {
        self?.items = results
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
      
      self?.getPromotions() { [weak self] results, errorMessage in
        self?.promotionBarcodes = results
        
        if !errorMessage.isEmpty {
          print("Search error: " + errorMessage)
        }
        
        DispatchQueue.main.async {
          completion(self?.items, self?.promotionBarcodes ?? [""])
        }
      }
    }
  }
  
  func getItems(completion: @escaping ([Item]?, String) -> Void) {
    
    dataTask?.cancel()
    
    if let urlComponents = URLComponents(string: "https://workshop-pos-api.herokuapp.com/api/items") {
      
      guard let url = urlComponents.url else { return }
      
      var request = URLRequest(url: url)
      
      request.setValue("5bCP5YCf5YCf", forHTTPHeaderField: "identifier")
      
      dataTask = defaultSession.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(nil, error.localizedDescription)
        } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
          do {
            let items = try JSONDecoder().decode([Item].self, from: data)
            DispatchQueue.main.async {
              completion(items, "")
            }
          } catch let error {
            completion(nil, error.localizedDescription)
          }
        } else {
          completion(nil, "Unknown error")
        }
      }
      
      dataTask?.resume()
    }
  }
  
  func getPromotions(completion: @escaping ([String], String) -> Void) {
    
    dataTask?.cancel()
    
    if let urlComponents = URLComponents(string: "https://workshop-pos-api.herokuapp.com/api/promotions") {
      
      guard let url = urlComponents.url else { return }
      
      var request = URLRequest(url: url)
      
      request.setValue("5bCP5YCf5YCf", forHTTPHeaderField: "identifier")
      
      dataTask = defaultSession.dataTask(with: request) { data, response, error in
        if let error = error {
          completion([], error.localizedDescription)
        } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
          do {
            let promotionBarcodes = try JSONDecoder().decode([String].self, from: data)
            DispatchQueue.main.async {
              completion(promotionBarcodes, "")
            }
          } catch let error {
            completion([], error.localizedDescription)
          }
        } else {
          completion([], "Unknown error")
        }
      }
      
      dataTask?.resume()
    }
  }
}
