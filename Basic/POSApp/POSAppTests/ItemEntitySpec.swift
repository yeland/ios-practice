//
//  ItemViewModelSpec.swift
//  POSAppTests
//
//  Created by Linxiao Wei on 2019/11/28.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Quick
import Nimble

@testable import POSApp

class ItemEntitySpec: QuickSpec {
  override func spec() {
    describe("subtotal") {
      context("should return purchased item's price") {
        it("return promotional purchased item's price when quantity is less than 3") {
          let itemEntity = ItemEntity(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemEntity.quantity = 2
          expect(itemEntity.subtotal) == 6.00
        }
        
        it("return promotional purchased item's price when quantity is more than 3") {
          let itemEntity = ItemEntity(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemEntity.quantity = 6
          expect(itemEntity.subtotal) == 12.00
        }
        
        it("return normal purchased item's price when quantity is more than 3") {
          let itemEntity = ItemEntity(item: Item(barcode: "ITEM000003", name: "荔枝", unit: "斤", price: 15.00), isPromotional: false)
          itemEntity.quantity = 5
          expect(itemEntity.subtotal) == 75.00
        }
      }
    }
    
    describe("savedPrice") {
      context("should return saved price") {
        it("return saved price") {
          let itemEntity = ItemEntity(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemEntity.quantity = 6
          expect(itemEntity.savedPrice) == 6.00
        }
      }
    }
    
    describe("receipt") {
      context("should return purchased item's single receipt") {
        it("return a single receipt") {
          let itemEntity = ItemEntity(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemEntity.quantity = 2
          expect(itemEntity.receipt) == "名称：雪碧，数量：2瓶，单价：3.00(元)，小计：6.00(元)"
        }
      }
    }
  }
}
