//
//  ReceiptViewcontroller.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {
  @IBOutlet weak var receiptText: UITextView!
  
  var itemsViewModel = ItemsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "收据"
    receiptText.text = itemsViewModel.receipt
  }
  
  override func viewDidAppear(_ animated: Bool) {
    itemsViewModel.clear()
  }
  
  func configure(with itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
  }
}
