//
//  PurchasedItemsService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class PurchasedItemsService {
  var purchasedItems = [PurchasedItem]()
  
  func addPurchasedItems(item: Item) {
    if let purchasedItem = purchasedItems.filter({ $0.item.barcode == item.barcode }).first {
      purchasedItem.setQuantity(quantity: purchasedItem.quantity + 1)
    } else {
      self.purchasedItems.append(PurchasedItem(item: item, quantity: 1))
    }
  }
  
  func getReceipt() -> String {
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

  private func getItemReceipt() -> String {
    return purchasedItems.sorted(by: { $0.item.barcode < $1.item.barcode })
      .map{ $0.getSingleReceipt() }
      .joined(separator: "\n")
  }

  private func getTotalPrice() -> String {
    let total = purchasedItems.reduce(0, { $0 + $1.getPrice() })
    let savedPrice = purchasedItems.reduce(0, { $0 + Float($1.quantity) * $1.item.price }) - total
    return """
    总计：\(String(format: "%.2f", total))(元)
    节省：\(String(format: "%.2f", savedPrice))(元)
    """
  }
}
