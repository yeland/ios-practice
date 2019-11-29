//
//  Item.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

struct Item: Codable, Equatable {
  var barcode: String
  var name: String
  var unit: String
  var price: Float
}
