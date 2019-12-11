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
    self.backgroundColor = color
    setName(comment)
  }
  
  func setName(_ comment: Comment) {
    let mutableString = NSMutableAttributedString(string: "\(comment.sender.nick): \(comment.content)")
    let length = comment.sender.nick.count + 1
    let fontColor = UIColor(displayP3Red: 0, green: 51/255, blue: 142/255, alpha: 1)
    mutableString.addAttribute(.foregroundColor, value: fontColor, range: NSRange(location: 0, length: length))
    mutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15, weight: .medium), range: NSRange(location: 0, length: length))
    name.attributedText = mutableString
  }
  
  override func prepareForReuse() {
    name.text = nil
  }
}
