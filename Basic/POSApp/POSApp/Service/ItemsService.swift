//
//  ItemsService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class ItemsService {
  let netWorkService = NetWorkService()
  var items: [Item] = []
  var promotionBarcodes: [String] = []
  
  func getItems(completion: @escaping ([Item]?, [String]) -> Void) {
    fetchData() { [weak self] items, promotions in
      self?.items = items?.map({ Item(barcode: $0.barcode, name: $0.name, unit: $0.unit, price: $0.price, isPromotional: promotions.contains($0.barcode)) }) ?? []
      
      DispatchQueue.main.async {
        completion(self?.items, self?.promotionBarcodes ?? [""])
      }
    }
  }
  
  func fetchData(completion: @escaping ([Item]?, [String]) -> Void) {
    netWorkService.getItems() { [weak self] results, errorMessage in
      if let results = results {
        self?.items = results
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
      
      self?.netWorkService.getPromotions() { [weak self] results, errorMessage in
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
}
