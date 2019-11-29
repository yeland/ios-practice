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

class ItemViewModelSpec: QuickSpec {
  override func spec() {
    describe("subtotal") {
      context("should return purchased item's price") {
        it("return promotional purchased item's price when quantity is less than 3") {
          let itemViewModel = ItemViewModel(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemViewModel.quantity = 2
          expect(itemViewModel.subtotal) == 6.00
        }
        
        it("return promotional purchased item's price when quantity is more than 3") {
          let itemViewModel = ItemViewModel(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemViewModel.quantity = 6
          expect(itemViewModel.subtotal) == 12.00
        }
        
        it("return normal purchased item's price when quantity is more than 3") {
          let itemViewModel = ItemViewModel(item: Item(barcode: "ITEM000003", name: "荔枝", unit: "斤", price: 15.00), isPromotional: false)
          itemViewModel.quantity = 5
          expect(itemViewModel.subtotal) == 75.00
        }
      }
    }
    
    describe("savedPrice") {
      context("should return saved price") {
        it("return saved price") {
          let itemViewModel = ItemViewModel(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemViewModel.quantity = 6
          expect(itemViewModel.savedPrice) == 6.00
        }
      }
    }
    
    describe("receipt") {
      context("should return purchased item's single receipt") {
        it("return a single receipt") {
          let itemViewModel = ItemViewModel(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true)
          itemViewModel.quantity = 2
          expect(itemViewModel.receipt) == "名称：雪碧，数量：2瓶，单价：3.00(元)，小计：6.00(元)"
        }
      }
    }
  }
}
