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
  
  private var photos: [Image] = []
  private var collectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16.0)
  private let space: CGFloat = 10.0
  private var rowPhotosNumber: CGFloat = 3
  private lazy var hightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    collectionView.dataSource = self
    collectionView.delegate = self
  
    collectionView.contentInset = collectionInset
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    hightConstraint.isActive = true
  }
  
  func configure(with moment: Moment) {
    collectionView.reloadData()
    self.photos = moment.images ?? []
    
    guard let sender = moment.sender else { return }
    guard let url = URL(string: sender.avatar) else { return }
    avatar.setImage(withURL: url)
    name.text = sender.nick
    if let content = moment.content {
      self.content.text = content
    } else {
      self.content.text = ""
    }
    
    setContentRight()
    hightConstraint.constant = getCollectionHeight()
  }
  
  func setContentRight() {
    if photos.count == 1 {
      collectionView.contentInset.right = 180
    } else if photos.count == 4 {
      collectionView.contentInset.right = 80
    } else {
      collectionView.contentInset.right = 16
    }
  }
  
  func getCollectionHeight() -> CGFloat {
    let itemSize = getItemSize()
    let rowsNumber = CGFloat(ceil(Double(photos.count) / 3.0))
    let itemsHight = rowsNumber * itemSize.height
    let spaceHight = rowsNumber * space
    return itemsHight + spaceHight
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatar.image = nil
    name.text = nil
    content.text = nil
    avatar.cancellOperation()
    rowPhotosNumber = 3
  }
}

extension MomentCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
      fatalError("Can not create cell")
    }
    cell.configure(with: photos[indexPath.row])
    
    return cell
  }
}

extension MomentCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return getItemSize()
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
}
