//
//  ItemVieModel.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/29.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class ItemViewModel {
  private let item: Item
  let isPromotional: Bool
  var quantity: Int = 0
  
  init(item: Item, isPromotional: Bool) {
    self.item = item
    self.isPromotional = isPromotional
  }
  
  init(itemEntity: ItemEntity) {
    item = Item(barcode: itemEntity.barcode, name: itemEntity.name, unit: itemEntity.unit, price: itemEntity.price)
    isPromotional = itemEntity.isPromotional
    quantity = itemEntity.quantity
  }
  
  var barcode: String {
    return item.barcode
  }
  
  var name: String {
    return item.name
  }
  
  var unit: String {
    return item.unit
  }
  
  var price: Double {
    return item.price
  }
  
  var subtotal: Double {
    if isPromotional {
      return Double(quantity / 3 * 2 + quantity % 3) * price
    }
    return Double(quantity) * price
  }
  
  var savedPrice: Double {
    return Double(quantity) * price - subtotal
  }
  
  var receipt: String {
    let formattedPrice = String(format: "%.2f", price)
    let formattedSubtotal = String(format: "%.2f", subtotal)
    return "名称：\(name)，数量：\(quantity)\(unit)，单价：\(formattedPrice)(元)，小计：\(formattedSubtotal)(元)"
  }
}
