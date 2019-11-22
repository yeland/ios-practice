//
//  ContentCell.swift
//  NetworkingDemo
//
//  Created by Linxiao Wei on 2019/11/21.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  func configure(with content: Content) {
    if let sender = content.sender {
      authorLabel.text = sender.nick
    } else {
      authorLabel.text = ""
    }
    
    if let content = content.content {
      contentLabel.text = content
    } else {
      contentLabel.text = ""
    }
  }
}
