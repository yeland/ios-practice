//
//  ShoppingListFooter.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ShoppingListFooter: UIView {
  @IBOutlet weak var checkButton: UIButton!
  
  var checkButtonAction: (() -> Void)?
  
  func configure(checkButtonAction: (() -> Void)?) {
    self.checkButtonAction = checkButtonAction
  }
  
  @IBAction func clickCheckButton(_ sender: UIButton) {
    self.checkButtonAction?()
  }
}
