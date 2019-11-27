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
  var purchasedItemsService = PurchasedItemsService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    receiptText.text = purchasedItemsService.getReceipt()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    purchasedItemsService.purchasedItems = []
  }
  
  func configure(with purchasedItemsService: PurchasedItemsService) {
    self.purchasedItemsService = purchasedItemsService
  }
}
