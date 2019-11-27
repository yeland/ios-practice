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
  
  var purchasedItemsService = PurchasedItemsService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "购物车"
    tableView.dataSource = self
    setupFooter()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  func setupFooter() {
    let shoppingListFooter = Bundle.main.loadNibNamed("ShoppingListFooter", owner: nil, options: nil)?.first as! ShoppingListFooter
    
    shoppingListFooter.configure {
      let receiptViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ReceiptViewController") as ReceiptViewController
      receiptViewController.configure(with: self.purchasedItemsService)
      self.show(receiptViewController, sender: self)
    }
    
    tableView.tableFooterView = shoppingListFooter
    
    NSLayoutConstraint.activate([
      shoppingListFooter.widthAnchor.constraint(equalTo: tableView.widthAnchor),
    ])
  }
  
  func configure(with purchasedItemsService: PurchasedItemsService) {
    self.purchasedItemsService = purchasedItemsService
  }
}

extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return purchasedItemsService.purchasedItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemCell", for: indexPath) as? PurchasedItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: purchasedItemsService.purchasedItems[indexPath.row])
    
    return cell
  }
}
