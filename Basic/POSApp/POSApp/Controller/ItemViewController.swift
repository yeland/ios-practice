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
  
  var itemsViewModel = ItemsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "商品列表"
    
    tableView.dataSource = self
    tableView.delegate = self
    
    itemsViewModel.getItems() { [weak self] _, _ in
      self?.tableView.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tableView.reloadData()
  }
  
  func configure(with itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
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
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

extension ItemViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let itemHeader = Bundle.main.loadNibNamed("ItemHeader", owner: nil, options: nil)?.first as! ItemHeader
    itemHeader.configure(shoppingCartAction: shoppingCartAction, createItemAction: createItemAction)
    return itemHeader
  }
  
  private func shoppingCartAction() {
    let shoppingCartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShoppingCartViewController") as ShoppingCartViewController
    shoppingCartViewController.configure(with: self.itemsViewModel)
    show(shoppingCartViewController, sender: self)
  }
  
  private func createItemAction() {
    let createItemViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateItemViewController") as CreateItemViewController
    createItemViewController.configure(with: self.itemsViewModel)
    show(createItemViewController, sender: self)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let editBUtton = UIContextualAction(style: .normal, title: "编辑") {
      (contextualAction, view, boolValue) in
      self.editButtonAction(row: indexPath.row)
      boolValue(true)
    }
    let deleteButton = UIContextualAction(style: .destructive, title: "删除") {
      (contextualAction, view, boolValue) in
      self.deleteButtonAction(row: indexPath.row)
      boolValue(true)
    }
    let swipeActions = UISwipeActionsConfiguration(actions: [deleteButton, editBUtton])
    return swipeActions
  }
  
  private func editButtonAction(row: Int) {
    let alert = UIAlertController(title: "编辑商品", message: "请输入\(self.itemsViewModel.itemViewModels[row].name)的新价格", preferredStyle: .alert)
    let saveAction = UIAlertAction(title: "保存", style: .default) { [weak self] action in
      guard let textField = alert.textFields?.first, let priceToSave = textField.text else {
        return
      }
      self?.itemsViewModel.editPrice(row: row, price: Double(priceToSave) ?? 0.0)
      self?.tableView.reloadData()
    }
    let cancelAction = UIAlertAction(title: "取消", style: .cancel)
    alert.addTextField()
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true)
  }
  
  private func deleteButtonAction(row: Int) {
    let alert = UIAlertController(title: "删除商品", message: "确定要删除\(self.itemsViewModel.itemViewModels[row].name)吗？", preferredStyle: .alert)
    let deleteAction = UIAlertAction(title: "删除", style: .destructive) { [weak self] action in
      self?.itemsViewModel.deleteItem(row: row)
      self?.tableView.reloadData()
    }
    let cancelAction = UIAlertAction(title: "取消", style: .cancel)
    alert.addAction(deleteAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true)
  }
}
