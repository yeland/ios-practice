//
//  ShoppingListService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class PurchasedItemsService {
  public var purchasedItems = [PurchasedItem]()
  
  public func addPurchasedItems(item: Item) {
    if let purchasedItem = purchasedItems.filter({ $0.item.barcode == item.barcode }).first {
      purchasedItem.setQuantity(quantity: purchasedItem.quantity + 1)
    } else {
      self.purchasedItems.append(PurchasedItem(item: item, quantity: 1))
    }
  }
}
