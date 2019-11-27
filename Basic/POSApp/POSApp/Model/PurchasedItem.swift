//
//  PurchasedItem.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class PurchasedItem {
  let item: Item
  var quantity: Int
  
  init(item: Item, quantity: Int) {
    self.item = item
    self.quantity = quantity
  }
  
  func setQuantity(quantity: Int) {
    self.quantity = quantity
  }
  
  func getPrice(_ promotionItems: [String]) -> Float {
//    let promotionItems = loadPromotions()[0].barcodes
    if promotionItems.contains(item.barcode) {
      return Float(quantity / 3 * 2 + quantity % 3) * item.price
    }
    return Float(quantity) * item.price
  }
  
  func getSingleReceipt(promotionItems: [String]) -> String {
    let formattedPrice = String(format: "%.2f", item.price)
    return "名称：\(item.name)，数量：\(quantity)\(item.unit)，单价：\(formattedPrice)(元)，小计：\(getPrice(promotionItems))(元)"
  }
}
