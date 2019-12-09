//
//  ItemsService.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation
import RealmSwift

class ItemsViewModel {
  var netWorkService = NetWorkService()
  let realm = try! Realm()
  var itemEntitys: Results<ItemEntity>!
  
  func getItems(completion: @escaping () -> Void) {
    itemEntitys = realm.objects(ItemEntity.self)
//    print(realm.configuration.fileURL)
    if itemEntitys.count == 0 {
      netWorkService.fetchData() { [weak self] items, promotions in
        let originItemEntitys = items?.map({ ItemEntity(item: $0, isPromotional: promotions.contains($0.barcode)) }) ?? []
        try! self?.realm.write {
          self?.realm.add(originItemEntitys)
        }
        DispatchQueue.main.async {
          completion()
        }
      }
    } else {
      completion()
    }
  }
  
  var purchasedItems: [ItemEntity] {
    itemEntitys.filter({ $0.quantity > 0 })
  }
  
  func addPurchasedItems(row: Int) {
    let purchasedItem = itemEntitys[row]
    try! self.realm.write {
      purchasedItem.quantity = purchasedItem.quantity + 1
    }
  }
  
  func createItem(name: String, unit: String, price: Double, isPromotional: Bool) {
    let barcode = itemEntitys.map({ (itemEntity: ItemEntity) -> Int in
      let barcode = itemEntity.barcode
      return (Int(String(barcode.split(separator: "M")[1])) ?? 0)
    }).reduce(0, { $0 < $1 ? $1 : $0 }) + 1
    
    let item = Item(barcode: "ITEM\(String(format: "%06d", barcode))", name: name, unit: unit, price: price)
    let itemEntity = ItemEntity(item: item, isPromotional: isPromotional)
    
    try! self.realm.write {
      realm.add(itemEntity)
    }
  }
  
  func editPrice(row: Int, price: Double, completion: () -> Void) {
    let itemEntity = itemEntitys[row]
    try! self.realm.write {
      itemEntity.price = price
    }
    completion()
  }
  
  func deleteItem(row: Int, completion: () -> Void) {
    let itemEntity = itemEntitys[row]
    try! self.realm.write {
      realm.delete(itemEntity)
    }
    completion()
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
    try! realm.write {
      for item in realm.objects(ItemEntity.self) {
        item.quantity = 0
      }
    }
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
