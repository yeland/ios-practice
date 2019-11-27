//
//  Item.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class Item: Codable {
  var barcode: String
  var name: String
  var unit: String
  var price: Float
  var isPromotional: Bool?
}
