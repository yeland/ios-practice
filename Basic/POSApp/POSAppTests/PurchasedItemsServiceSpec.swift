//
//  PurchasedItemsServiceSpec.swift
//  POSAppTests
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Quick
import Nimble

@testable import POSApp

class PurchasedItemsServiceSpec: QuickSpec {
  override func spec() {
    describe("addPurchasedItems") {
      context("should add purchased items") {
        it("add new item") {
          let purchasedItemsService = PurchasedItemsService()
//          let item1 = Item()
          let item = Item(barcode: "ITEM000000", name: "可口可乐", unit: "瓶", price: 3.00)
          purchasedItemsService.addPurchasedItems(item: item)
          expect(purchasedItemsService.purchasedItems.count) == 1
          expect(purchasedItemsService.purchasedItems[0].quantity) == 1
        }
        
        it("add existing item") {
          let purchasedItemsService = PurchasedItemsService()
          let item = Item(barcode: "ITEM000000", name: "可口可乐", unit: "瓶", price: 3.00)
          purchasedItemsService.addPurchasedItems(item: item)
          purchasedItemsService.addPurchasedItems(item: item)
          expect(purchasedItemsService.purchasedItems.count) == 1
          expect(purchasedItemsService.purchasedItems[0].quantity) == 2
        }
        
        it("add two new items") {
          let purchasedItemsService = PurchasedItemsService()
          let item = Item(barcode: "ITEM000000", name: "可口可乐", unit: "瓶", price: 3.00)
          purchasedItemsService.addPurchasedItems(item: item)
          let anotherItem = Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00)
          purchasedItemsService.addPurchasedItems(item: anotherItem)
          expect(purchasedItemsService.purchasedItems.count) == 2
          expect(purchasedItemsService.purchasedItems[0].quantity) == 1
          expect(purchasedItemsService.purchasedItems[1].quantity) == 1
        }
      }
    }
    
    describe("getReceipt") {
      context("should return reciept") {
        it("return ") {
          
        }
      }
    }
  }
}
