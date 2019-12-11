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
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var commentsTable: UITableView!
  
  private var collectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  private lazy var collectionHightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
  private lazy var tableHightContraint = commentsTable.heightAnchor.constraint(equalToConstant: 100)
  
  var photos: [Image] = []
  var comments: [Comment] = []
  let space: CGFloat = 10.0
  var rowPhotosNumber: CGFloat = 3
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    commentsTable.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    commentsTable.dataSource = self
    collectionView.contentInset = collectionInset
    
    setupLayout()
  }
  
  private func setupLayout() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    commentsTable.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionHightConstraint,
      collectionView.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 20),
      collectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
      tableHightContraint,
      commentsTable.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
      commentsTable.leadingAnchor.constraint(equalTo:  collectionView.leadingAnchor),
      commentsTable.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      commentsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
    ])
  }
  
  func configure(with moment: Moment) {
    photos = moment.images ?? []
    comments = moment.comments ?? []
    collectionView.reloadData()
    commentsTable.reloadData()
    
    guard let sender = moment.sender else { return }
    guard let url = URL(string: sender.avatar) else { return }
    avatar.setImage(withURL: url)
    avatar.layer.cornerRadius = 5
    name.text = sender.nick
    if let momentContent = moment.content {
      content.text = momentContent
    } else {
      content.text = ""
    }
    
    setContentRight()
    collectionHightConstraint.constant = getCollectionHeight()
    tableHightContraint.constant = CGFloat(self.comments.count * 40)
  }
  
  private func setContentRight() {
    if photos.count == 1 {
      collectionView.contentInset.right = 180
    } else if photos.count == 4 {
      collectionView.contentInset.right = 80
    } else {
      collectionView.contentInset.right = 0
    }
  }
  
  private func getCollectionHeight() -> CGFloat {
    let itemSize = getItemSize()
    let rowsNumber = CGFloat(ceil(Double(photos.count) / 3.0))
    let itemsHight = rowsNumber * itemSize.height
    let spaceHight = rowsNumber * space
    return itemsHight + spaceHight
  }
  
  func getItemSize() -> CGSize {
    if photos.count == 4 {
      rowPhotosNumber = 2
    }
    
    if photos.count == 1 {
      rowPhotosNumber = 1
    }
    
    let inset = collectionView.contentInset
    let paddingSpace = inset.left + inset.right + space * (rowPhotosNumber - 1)
    let availableWidth = self.collectionView.frame.width - paddingSpace
    let widthPerItem = availableWidth / rowPhotosNumber
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatar.image = nil
    name.text = nil
    content.text = nil
    rowPhotosNumber = 3
  }
}
