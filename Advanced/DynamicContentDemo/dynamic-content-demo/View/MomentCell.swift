//
//  MomentCell.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class MomentCell: UITableViewCell {
  @IBOutlet var avatar: UIImageView!
  @IBOutlet var name: UILabel!
  @IBOutlet var content: UILabel!
  
  func configure(with moment: Moment) {
    guard let sender = moment.sender else { return }
    guard let url = URL(string: sender.avatar) else { return }
    avatar.setImage(withURL: url)
    name.text = sender.nick
    
    if let content = moment.content {
      self.content.text = content
    } else {
      self.content.text = ""
    }
    
    addPhoto(with: moment.images ?? [])
  }
  
  func addPhoto(with images: [Image] ) {
    let photoOfCell = PhotoOfCell()
//    photoOfCell.configure
    self.addSubview(photoOfCell)
    
  }
}
