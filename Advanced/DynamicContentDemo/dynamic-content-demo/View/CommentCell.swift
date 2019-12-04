//
//  CommentCell.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/4.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
  @IBOutlet weak var name: UILabel!
  
  func configure(with comment: Comment) {
    let color = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    name.backgroundColor = color
    name.layer.cornerRadius  = 2
    name.text = "\(comment.sender.nick): \(comment.content)"
    self.backgroundColor = color
  }
  
  override func prepareForReuse() {
    name.text = nil
  }
}
