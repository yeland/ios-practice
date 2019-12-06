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
    
    tableView.dataSource = self
    tableView.delegate = self
    
    itemsViewModel.getItems() { [weak self] _, _ in
      self?.tableView.reloadData()
    }
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
    cell.configure(with: self.itemsViewModel.itemViewModels[indexPath.row]) { [weak self] in
      guard let self = self else { return }
      self.itemsViewModel.addPurchasedItems(row: indexPath.row)
    }

    return cell
  }
}

extension ItemViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return setupHeader()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let editBUtton = UIContextualAction(style: .normal, title: "编辑") {
      (contextualAction, view, boolValue) in
      self.itemsViewModel.deleteItem(row: indexPath.row)
      tableView.reloadData()
    }
    
    let deleteButton = UIContextualAction(style: .destructive, title: "删除") {
      (contextualAction, view, boolValue) in
          //Code I want to do here
    }
    
    let swipeActions = UISwipeActionsConfiguration(actions: [deleteButton, editBUtton])

    return swipeActions
  }
  
  
  private func setupHeader() -> UIView {
    let itemHeader = Bundle.main.loadNibNamed("ItemHeader", owner: nil, options: nil)?.first as! ItemHeader
    itemHeader.configure(shoppingCartAction: shoppingCartAction, createItemAction: createItemAction)
    return itemHeader
  }
  
  private func shoppingCartAction() {
    let shoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShoppingCartViewController") as ShoppingCartViewController
    shoppingCartViewController.configure(with: self.itemsViewModel)
    self.show(shoppingCartViewController, sender: self)
  }
  
  private func createItemAction() {
    let alert = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
    let action = UIAlertAction(title: "ok", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true)
  }
}
