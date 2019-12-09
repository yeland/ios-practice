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
  
  func configure(with itemEntity: ItemEntity) {
    nameLabel.text = itemEntity.name
    priceLabel.text = "￥\(itemEntity.price)"
    unitLabel.text = "单位：\(itemEntity.unit)"
    quantityLabel.text = "\(itemEntity.quantity)"
  }
}
