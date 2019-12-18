//
//  MomentHeader.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/10.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class MomentHeader: UITableViewHeaderFooterView {
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  
  func configure(with user: User) {
    profileImage.setImage(withURL: user.profileImage)
    nameLabel.text = user.nick
    avatarImage.setImage(withURL: user.avatar)
  }
}
