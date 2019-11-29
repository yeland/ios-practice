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
  var quantity: Int
  var isPromotional: Bool
  
  
  init(item: Item, quantity: Int, isPromotional: Bool) {
    self.item = item
    self.quantity = quantity
    self.isPromotional = isPromotional
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
  
  var price: String {
    return "￥\(item.price)"
  }
  
  var nameWithUnit: String {
    return "\(item.name)(单位：\(item.unit))"
  }
  
  var subtotal: Float {
    if isPromotional {
      return Float(quantity / 3 * 2 + quantity % 3) * item.price
    }
    return Float(quantity) * item.price
  }
  
  var savedPrice: Float {
    return Float(quantity) * item.price - subtotal
  }
  
  var receipt: String {
    let formattedPrice = String(format: "%.2f", price)
    let formattedSubtotal = String(format: "%.2f", subtotal)
    return "名称：\(name)，数量：\(quantity)\(unit)，单价：\(formattedPrice)(元)，小计：\(formattedSubtotal)(元)"
  }
}
