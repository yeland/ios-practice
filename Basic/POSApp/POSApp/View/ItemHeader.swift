//
//  ItemHeader.swift
//  POSApp
//
//  Created by Linxiao Wei on 2020/5/18.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class ItemHeader: UIView {
  @IBOutlet var addItemButton: UIButton!
  @IBOutlet var cartButton: UIButton!
  var shoppingCartAction: (() -> Void)?
  var createItemAction: (() -> Void)?


  func configure(shoppingCartAction:  (() -> Void)?, createItemAction: (() -> Void)?) {
    self.shoppingCartAction = shoppingCartAction
    self.createItemAction = createItemAction
  }


  @IBAction func AddItem(_ sender: Any) {
    createItemAction?()
  }


  @IBAction func ShowCart(_ sender: Any) {
    shoppingCartAction?()
  }
}
