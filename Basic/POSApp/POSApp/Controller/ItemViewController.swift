//
//  ViewController.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let netWorkService = NetWorkService()
  let getPurchasedItemsService = GetPurchasedItemsService()
  var items: [Item] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    netWorkService.getResults() { [weak self] results, errorMessage in
      if let results = results {
        self?.items = results
        self?.tableView.reloadData()
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
    }
    tableView.dataSource = self
    setupTableHeader()
  }
  
  private func setupTableHeader() {
    let itemHeader = Bundle.main.loadNibNamed("ItemHeader", owner: nil, options: nil)?.first as! ItemHeader
    itemHeader.configure {
      let shoppingListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShoppingListViewController") as ShoppingListViewController
      shoppingListViewController.configure(with: self.getPurchasedItemsService)
      self.show(shoppingListViewController, sender: self)
    }
    tableView.tableHeaderView = itemHeader
    
    itemHeader.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      itemHeader.widthAnchor.constraint(equalTo: tableView.widthAnchor),
      itemHeader.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension ItemViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: self.items[indexPath.row]) {
      self.getPurchasedItemsService.addPurchasedItems(item: self.items[indexPath.row])
    }
    
    return cell
  }
}




