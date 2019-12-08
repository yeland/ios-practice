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
  var itemViewModels: [ItemViewModel] = []
  
  func getItems(completion: @escaping ([ItemViewModel]?, [String]) -> Void) {
    itemEntitys = realm.objects(ItemEntity.self)
//    print(realm.configuration.fileURL)
    if itemEntitys.count == 0 {
      netWorkService.fetchData() { [weak self] items, promotions in
        self?.itemViewModels = items?.map({ ItemViewModel(item: $0, isPromotional: promotions.contains($0.barcode)) }) ?? []
        let originItemEntitys = self?.itemViewModels.map({ ItemEntity(itemViewModel: $0) })
        try! self?.realm.write {
          self?.realm.add(originItemEntitys ?? [])
        }
        DispatchQueue.main.async {
          completion(self?.itemViewModels, promotions)
        }
      }
    } else {
      self.itemViewModels = itemEntitys.map({ ItemViewModel(itemEntity: $0) })
      completion(self.itemViewModels, [])
    }
  }
  
  var purchasedItems: [ItemViewModel] {
    itemViewModels.filter({ $0.quantity > 0 })
  }
  
  func addPurchasedItems(row: Int) {
    let purchasedItem = itemViewModels[row]
    purchasedItem.quantity = purchasedItem.quantity + 1
    try! self.realm.write {
      realm.add(ItemEntity(itemViewModel: purchasedItem), update: .modified)
    }
  }
  
  func createItem(name: String, unit: String, price: Double, isPromotional: Bool) {
    let barcode = itemViewModels.map({ (itemViewModel: ItemViewModel) -> Int in
      itemViewModel.item.barcode.removeFirst(4)
      return Int(itemViewModel.item.barcode) ?? 0
    }).reduce(0, { $0 < $1 ? $1 : $0 }) + 1
    
    let item = Item(barcode: "ITEM\(String(format: "%06d", barcode))", name: name, unit: unit, price: price)
    let itemViewModel = ItemViewModel(item: item, isPromotional: isPromotional)
    
    itemViewModels.append(itemViewModel)
    try! self.realm.write {
      realm.add(ItemEntity(itemViewModel: itemViewModel))
    }
  }
  
  func editPrice(row: Int, price: Double) {
    let itemViewModel = itemViewModels[row]
    itemViewModel.item.price = price
    try! self.realm.write {
      realm.add(ItemEntity(itemViewModel: itemViewModel), update: .modified)
    }
  }
  
  func deleteItem(row: Int) {
    let itemEntitys = realm.objects(ItemEntity.self)
    let itemEntity = itemEntitys.filter({ $0.barcode == self.itemViewModels[row].barcode })
    try! self.realm.write {
      realm.delete(itemEntity)
    }
    itemViewModels.remove(at: row)
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
