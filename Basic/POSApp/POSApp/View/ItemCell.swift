//
//  ItemCell.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var isPromotionalLabel: UILabel!
  
  var addItemAction: (() -> Void)?
  
  func configure(with itemEntity: ItemEntity, addItemAction: (() -> Void)?) {
    nameLabel.text = "\(itemEntity.name)(单位：\(itemEntity.unit))"
    priceLabel.text = "￥\(itemEntity.price)"
    if itemEntity.isPromotional {
      isPromotionalLabel.text = "买二送一"
      isPromotionalLabel.backgroundColor = .yellow
    }
    self.addItemAction = addItemAction
  }
  
  @IBAction func clickAddItem(_ sender: UIButton) {
    self.addItemAction?()
  }
}
