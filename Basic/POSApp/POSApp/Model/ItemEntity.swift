//
//  ItemEntity.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/12/5.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation
import RealmSwift

class ItemEntity: Object {
  @objc dynamic var barcode = ""
  @objc dynamic var name = ""
  @objc dynamic var unit = ""
  @objc dynamic var price = 0.0
  @objc dynamic var isPromotional = false
  @objc dynamic var quantity = 0
  
  required init() {
    
  }
  
  init(item: Item, isPromotional: Bool) {
    barcode = item.barcode
    name = item.name
    unit = item.unit
    price = item.price
    self.isPromotional = isPromotional
  }
  
  init(itemViewModel: ItemViewModel) {
    barcode = itemViewModel.barcode
    name = itemViewModel.name
    unit = itemViewModel.unit
    price = itemViewModel.price
    isPromotional = itemViewModel.isPromotional
    quantity = itemViewModel.quantity
  }
  
  override static func primaryKey() -> String? {
      return "barcode"
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
