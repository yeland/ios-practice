//
//  CreateItemViewController.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/12/6.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class CreateItemViewController: UIViewController {
  @IBOutlet weak var name: UITextField!
  @IBOutlet weak var unit: UITextField!
  @IBOutlet weak var price: UITextField!
  @IBOutlet weak var promotionSwitch: UISwitch!
  @IBOutlet weak var saveButton: UIButton!
  
  var itemsViewModel = ItemsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "创建商品"
  }
  
  func configure(with itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
  }
  
  @IBAction func clickToSave(_ sender: UIButton) {
    guard let name = name.text, let unit = unit.text, let price = price.text else {
      return
    }
    self.itemsViewModel.createItem(name: name, unit: unit, price: Double(price) ?? 0, isPromotional: promotionSwitch.isOn)
    navigationController?.popViewController(animated: true)
  }
}
