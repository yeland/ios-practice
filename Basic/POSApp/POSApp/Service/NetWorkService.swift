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
  var errorMessage = ""
  var items: [Item] = []
  typealias ItemsResult = ([Item]?, String) -> Void
  
  var promotionErrorMessage = ""
  var promotionBarcodes: [String] = []
  typealias PromotionsResult = ([String], String) -> Void
  
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
      
      DispatchQueue.main.async {
        completion(self?.items, self?.promotionBarcodes ?? [""])
      }
    }
  }
  
  func getItems(completion: @escaping ItemsResult) {
    
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
  
  func getPromotions(completion: @escaping PromotionsResult) {
    
    dataTask?.cancel()
    
    if let urlComponents = URLComponents(string: "https://workshop-pos-api.herokuapp.com/api/promotions") {
      
      guard let url = urlComponents.url else { return }
      
      var request = URLRequest(url: url)
      
      request.setValue("5bCP5YCf5YCf", forHTTPHeaderField: "identifier")
      
      dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
        if let error = error {
          self?.promotionErrorMessage = error.localizedDescription
        } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
          do {
            self?.promotionBarcodes = try JSONDecoder().decode([String].self, from: data)
          } catch let error {
            self?.promotionErrorMessage = error.localizedDescription
          }
        } else {
          self?.promotionErrorMessage = "Unknown error"
        }
      
        DispatchQueue.main.async {
          completion(self?.promotionBarcodes ?? [""], self?.promotionErrorMessage ?? "")
        }
      }
      
      dataTask?.resume()
    }
  }
}
