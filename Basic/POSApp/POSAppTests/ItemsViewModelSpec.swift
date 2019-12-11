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

class ItemsViewModelSpec: QuickSpec {
  override func spec() {
    describe("getItems") {
      context("should return items") {
        it("return items with promotion message") {
          let itemsViewModel = ItemsViewModel()
          itemsViewModel.netWorkService = MockNetWorkService()
          
          itemsViewModel.getItems() {
            expect(itemsViewModel.itemEntitys.count) == 3
            expect(itemsViewModel.itemEntitys[0].barcode) == "ITEM000000"
            expect(itemsViewModel.itemEntitys[0].isPromotional) == true
            expect(itemsViewModel.itemEntitys[0].quantity) == 0
            expect(itemsViewModel.itemEntitys[2].barcode) == "ITEM000002"
            expect(itemsViewModel.itemEntitys[2].isPromotional) == false
          }
        }
      }
    }
    
    func beforeEach() -> ItemsViewModel {
      let itemEntitys = [
      ItemEntity(item: Item(barcode: "ITEM000001", name: "雪碧", unit: "瓶", price: 3.00), isPromotional: true),
      ItemEntity(item: Item(barcode: "ITEM000003", name: "荔枝", unit: "斤", price: 15.00), isPromotional: false),
      ItemEntity(item: Item(barcode: "ITEM000005", name: "方便面", unit: "袋", price: 4.50), isPromotional: true)]
      
      let itemsViewModel = ItemsViewModel()
//      itemsViewModel.itemEntitys = Results<ItemEntity>(itemEntitys)
      
      return itemsViewModel
    }
    
    describe("addPurchasedItems") {
      context("should add purchased items") {
        it("add new item") {
          let itemsViewModel = beforeEach()
          itemsViewModel.addPurchasedItems(row: 0)
          
          expect(itemsViewModel.purchasedItems.count) == 1
          expect(itemsViewModel.purchasedItems[0].quantity) == 1
        }
        
        it("add two new items") {
          let itemsViewModel = beforeEach()
          itemsViewModel.addPurchasedItems(row: 0)
          itemsViewModel.addPurchasedItems(row: 1)
          
          expect(itemsViewModel.purchasedItems.count) == 2
          expect(itemsViewModel.purchasedItems[0].quantity) == 1
          expect(itemsViewModel.purchasedItems[1].quantity) == 1
        }
      }
    }
    
    describe("getReceipt") {
      context("should return reciept") {
        it("return a correct receipt") {
          let itemsViewModel = beforeEach()
          itemsViewModel.itemEntitys[0].quantity = 5
          itemsViewModel.itemEntitys[1].quantity = 2
          itemsViewModel.itemEntitys[2].quantity = 3
          
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
          
          expect(itemsViewModel.receipt) == expectedReceipt
        }
        
        it("return a empty receipt") {
          let itemsViewModel = beforeEach()
          let expectedReceipt = """
          ***<没钱赚商店>收据***
          
          ----------------------
          总计：0.00(元)
          节省：0.00(元)
          **********************
          """
          
          expect(itemsViewModel.receipt) == expectedReceipt
        }
      }
    }
    
    describe("clear") {
      context("should clear purchased items") {
        let itemsViewModel = beforeEach()
        itemsViewModel.itemEntitys[0].quantity = 5
        itemsViewModel.itemEntitys[1].quantity = 2
        itemsViewModel.itemEntitys[2].quantity = 3
        
        expect(itemsViewModel.purchasedItems.count) == 3
        
        itemsViewModel.clear()
        
        expect(itemsViewModel.purchasedItems.count) == 0
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
    let promotions = ["ITEM000000", "ITEM000001"]
    completion(items, promotions)
  }
}
