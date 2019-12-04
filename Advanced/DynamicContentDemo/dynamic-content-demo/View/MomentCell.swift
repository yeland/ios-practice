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
  
  var constraint: NSLayoutConstraint?
  
  var photoView: PhotoView = Bundle.main.loadNibNamed("PhotoView", owner: nil, options: nil)?.first as! PhotoView
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.addSubview(photoView)
    photoView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoView.leadingAnchor.constraint(equalTo: self.content.leadingAnchor),
      photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      photoView.topAnchor.constraint(equalTo: self.content.bottomAnchor, constant: 15),
      photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
    ])
    constraint = photoView.heightAnchor.constraint(equalToConstant: 100)
    constraint?.isActive = true
  }
  
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
    
    if let images = moment.images {
      configurePhoto(with: images)
      constraint?.constant = 100
    } else {
      constraint?.constant = 0
    }
  }
  
  func configurePhoto(with images: [Image] ) {
    photoView.configure(with: images)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatar.image = nil
    name.text = nil
    content.text = nil
    photoView.prepareForReuse()
  }
}
