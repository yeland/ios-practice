//
//  MomentHeader.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/10.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class MomentHeader: UIView {
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  
  func configure(with user: User) {
    guard let profileUrl = URL(string: user.profileImage) else { return }
    guard let avatarUrl = URL(string: user.avatar) else { return }
    profileImage.setImage(withURL: profileUrl)
    nameLabel.text = user.nick
    avatarImage.setImage(withURL: avatarUrl)
  }
}
