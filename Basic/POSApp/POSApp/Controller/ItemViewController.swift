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
  
  let itemsViewModel = ItemsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "商品列表"
    
    itemsViewModel.getItems() { [weak self] items, promotionBarcodes in
      self?.tableView.reloadData()
    }
    
    tableView.dataSource = self
    setupTableHeader()
  }
  
  private func setupTableHeader() {
    let itemHeader = Bundle.main.loadNibNamed("ItemHeader", owner: nil, options: nil)?.first as! ItemHeader
    itemHeader.configure {
      let shoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShoppingCartViewController") as ShoppingCartViewController
      shoppingCartViewController.configure(with: self.itemsViewModel)
      self.show(shoppingCartViewController, sender: self)
    }
    tableView.tableHeaderView = itemHeader
    
    itemHeader.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      itemHeader.widthAnchor.constraint(equalTo: tableView.widthAnchor),
      itemHeader.heightAnchor.constraint(equalToConstant: 70)
    ])
  }
}

extension ItemViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsViewModel.itemViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: self.itemsViewModel.itemViewModels[indexPath.row]) {
      self.itemsViewModel.addPurchasedItems(row: indexPath.row)
    }

    return cell
  }
}




