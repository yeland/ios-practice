//
//  ShoppingCartViewController.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var itemsViewModel = ItemsViewModel()
  
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
    let shoppingCartFooter = Bundle.main.loadNibNamed("ShoppingCartFooter", owner: nil, options: nil)?.first as! ShoppingCartFooter
    
    shoppingCartFooter.configure {
      let receiptViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ReceiptViewController") as ReceiptViewController
      receiptViewController.configure(with: self.itemsViewModel)
      self.show(receiptViewController, sender: self)
    }
    
    tableView.tableFooterView = shoppingCartFooter
    
    NSLayoutConstraint.activate([
      shoppingCartFooter.widthAnchor.constraint(equalTo: tableView.widthAnchor),
    ])
  }
  
  func configure(with itemsService: ItemsViewModel) {
    self.itemsViewModel = itemsService
  }
}

extension ShoppingCartViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsViewModel.purchasedItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemCell", for: indexPath) as? PurchasedItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: itemsViewModel.purchasedItems[indexPath.row])
    
    return cell
  }
}
