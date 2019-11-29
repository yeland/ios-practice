//
//  ItemsService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class ItemsViewModel {
  var netWorkService = NetWorkService()
  var itemViewModels: [ItemViewModel] = []
  
  func getItems(completion: @escaping ([ItemViewModel]?, [String]) -> Void) {
    netWorkService.fetchData() { [weak self] items, promotions in
      self?.itemViewModels = items?.map({ ItemViewModel(item: $0, isPromotional: promotions.contains($0.barcode)) }) ?? []
      
      DispatchQueue.main.async {
        completion(self?.itemViewModels, promotions)
      }
    }
  }
  
  var purchasedItems: [ItemViewModel] {
    itemViewModels.filter({ $0.quantity > 0 })
  }
  
  func addPurchasedItems(row: Int) {
    let purchasedItem = itemViewModels[row]
    purchasedItem.quantity = purchasedItem.quantity + 1
  }
  
  var receipt: String {
    let itemsString = getItemReceipt()
    let footer = getTotalPrice()
    return """
    ***<没钱赚商店>收据***
    \(itemsString)
    ----------------------
    \(footer)
    **********************
    """
  }
  
  func clear() {
    itemViewModels.forEach({ $0.quantity = 0 })
  }

  private func getItemReceipt() -> String {
    return purchasedItems.sorted(by: { $0.barcode < $1.barcode })
      .map{ $0.receipt }
      .joined(separator: "\n")
  }

  private func getTotalPrice() -> String {
    let total = purchasedItems.reduce(0, { $0 + $1.subtotal })
    let savedPrice = purchasedItems.reduce(0, { $0 + $1.savedPrice })
    return """
    总计：\(String(format: "%.2f", total))(元)
    节省：\(String(format: "%.2f", savedPrice))(元)
    """
  }
}
