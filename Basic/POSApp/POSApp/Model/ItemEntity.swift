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
}
