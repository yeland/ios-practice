//
//  ItemsServiceSpec.swift
//  POSAppTests
//
//  Created by Linxiao Wei on 2019/11/28.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Quick
import Nimble

@testable import POSApp

class ItemsServiceSpec: QuickSpec {
  override func spec() {
    describe("getItems") {
      context("should return items") {
        it("return items with promotion message") {
          let itemsService = ItemsService()
          itemsService.netWorkService = MockNetWorkService()
          let expectedItems = [Item(
            barcode: "ITEM000000",
            name: "可口可乐",
            unit: "瓶",
            price: 3.00,
            isPromotional: true
          ),
          Item(
            barcode: "ITEM000001",
            name: "雪碧",
            unit: "瓶",
            price: 3.00,
            isPromotional: true
          ),
          Item(
            barcode: "ITEM000002",
            name: "苹果",
            unit: "斤",
            price: 5.50,
            isPromotional: false
          )]
          
          itemsService.getItems() { items, promotionBarcodes in
            expect(itemsService.items).to(equal(expectedItems))
          }
        }
      }
    }
  }
}

class MockNetWorkService: NetWorkService {
  override func fetchData(completion: @escaping ([Item]?, [String]) -> Void) {
    let items = [
    Item(
      barcode: "ITEM000000",
      name: "可口可乐",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000001",
      name: "雪碧",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000002",
      name: "苹果",
      unit: "斤",
      price: 5.50
    )]
    let promotions = ["ITEM000000", "ITEM000001", "ITEM000005"]
    completion(items, promotions)
  }
}
