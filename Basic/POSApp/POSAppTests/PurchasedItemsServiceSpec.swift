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
        it("return a correct receipt") {
          let purchasedItemsService = PurchasedItemsService()
          let purchasedItem0 = PurchasedItem(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00, isPromotional: true), quantity: 5)
          let purchasedItem1 = PurchasedItem(item: Item(barcode: "ITEM000003", name: "荔枝", unit: "斤", price: 15.00, isPromotional: false), quantity: 2)
          let purchasedItem2 = PurchasedItem(item: Item(barcode: "ITEM000005", name: "方便面", unit: "袋", price: 4.50, isPromotional: true), quantity: 3)
          purchasedItemsService.purchasedItems = [purchasedItem0, purchasedItem1, purchasedItem2]
          
          let expectedReceipt = """
          ***<没钱赚商店>收据***
          名称：雪碧，数量：5瓶，单价：3.00(元)，小计：12.00(元)
          名称：荔枝，数量：2斤，单价：15.00(元)，小计：30.00(元)
          名称：方便面，数量：3袋，单价：4.50(元)，小计：9.00(元)
          ----------------------
          总计：51.00(元)
          节省：7.50(元)
          **********************
          """
          
          expect(purchasedItemsService.getReceipt()) == expectedReceipt
        }
        
        it("return a empty receipt") {
          let purchasedItemsService = PurchasedItemsService()
          let expectedReceipt = """
          ***<没钱赚商店>收据***
          
          ----------------------
          总计：0.00(元)
          节省：0.00(元)
          **********************
          """
          
          expect(purchasedItemsService.getReceipt()) == expectedReceipt
        }
      }
    }
  }
}
