//
//  DeviceCell.swift
//  UITableViewDemo
//
//  Created by Linxiao Wei on 2019/11/20.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var systemLabel: UILabel!
  @IBOutlet weak var isAvailableButton: UIButton!
  
  func configure(with device: Device) {
    nameLabel.text = device.name
    systemLabel.text = device.system
    
    if device.isAvailable {
      isAvailableButton.setTitle("Available", for: .normal)
      isAvailableButton.backgroundColor = .green
    } else {
      isAvailableButton.setTitle("Not Available", for: .normal)
      isAvailableButton.backgroundColor = .orange
    }
  }
}
