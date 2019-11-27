//
//  ShoppingListViewController.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var getPurchasedItemsService = GetPurchasedItemsService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "购物车"
    tableView.dataSource = self
  }
  
  func configure(with getPurchasedItemsService: GetPurchasedItemsService) {
    self.getPurchasedItemsService = getPurchasedItemsService
  }
}

extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return getPurchasedItemsService.purchasedItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemCell", for: indexPath) as? PurchasedItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: getPurchasedItemsService.purchasedItems[indexPath.row])
    
    return cell
  }
}
