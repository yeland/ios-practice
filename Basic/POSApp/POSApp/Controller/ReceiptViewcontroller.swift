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
    receiptText.text = itemsViewModel.receipt
  }
  
  override func viewDidAppear(_ animated: Bool) {
    itemsViewModel.clear()
  }
  
  func configure(with itemsService: ItemsViewModel) {
    self.itemsViewModel = itemsService
  }
}
