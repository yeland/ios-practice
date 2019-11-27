//
//  PurchasedItemCell.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/26.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class PurchasedItemCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var unitLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  
  func configure(with purchesedItem: PurchasedItem) {
    nameLabel.text = purchesedItem.item.name
    priceLabel.text = "￥\(purchesedItem.item.price)"
    unitLabel.text = "单位：\(purchesedItem.item.unit)"
    quantityLabel.text = "\(purchesedItem.quantity)"
  }
  
  
}
