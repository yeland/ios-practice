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
  @IBOutlet var addCommentButton: UIButton!
  
  private lazy var collectionHightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
  private lazy var collectionWidthConstraint = collectionView.widthAnchor.constraint(equalToConstant: 0)
  private lazy var tableHightContraint = commentsTable.heightAnchor.constraint(equalToConstant: 0)
  
  var photos: [Image] = []
  var comments: [Comment] = []
  let space: CGFloat = 10.0
  var addCommentAction: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    commentsTable.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    commentsTable.dataSource = self
    
    setupLayout()
  }
  
  @IBAction func clickToAddComment(_ sender: UIButton) {
    addCommentAction?()
  }
  
  private func setupLayout() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    commentsTable.translatesAutoresizingMaskIntoConstraints = false
    addCommentButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionHightConstraint,
      collectionWidthConstraint,
      collectionView.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 15),
      collectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
      tableHightContraint,
      commentsTable.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 22),
      commentsTable.leadingAnchor.constraint(equalTo:  content.leadingAnchor),
      commentsTable.trailingAnchor.constraint(equalTo: content.trailingAnchor),
      commentsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      addCommentButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      addCommentButton.trailingAnchor.constraint(equalTo: content.trailingAnchor),
      addCommentButton.widthAnchor.constraint(equalToConstant: 20),
      addCommentButton.heightAnchor.constraint(equalToConstant: 20),
    ])
  }
  
  func configure(with moment: Moment, addCommentAction: (() -> Void)?) {
    self.selectionStyle = .none
    
    photos = moment.images ?? []
    comments = moment.comments ?? []
    collectionView.reloadData()
    commentsTable.reloadData()
    
    guard let sender = moment.sender else { return }
    avatar.setImage(withURL: sender.avatar)
    avatar.layer.cornerRadius = 5
    name.text = sender.nick
    if let momentContent = moment.content {
      content.text = momentContent
    } else {
      content.text = ""
    }
    self.addCommentAction = addCommentAction
  
    collectionHightConstraint.constant = getCollectionHeight()
    collectionWidthConstraint.constant = getCollectionWidth()
    tableHightContraint.constant = CGFloat(self.comments.count * 40)
  }
  
  private func getCollectionHeight() -> CGFloat {
    let itemSize = getItemSize()
    let rowsNumber = CGFloat(ceil(Double(photos.count) / 3.0))
    let itemsHight = rowsNumber * itemSize.height
    let spaceHight = (rowsNumber - 1) * space
    return itemsHight + spaceHight
  }
  
  private func getCollectionWidth() -> CGFloat {
    let itemSize = getItemSize()
    var columeNumber: CGFloat
    if photos.count == 1 {
      columeNumber = 1
    } else if photos.count == 4 {
      columeNumber = 2
    } else {
      columeNumber = 3
    }

    let itemsWidth = columeNumber * itemSize.width
    let spaceWidth = (columeNumber - 1) * space
    return itemsWidth + spaceWidth
  }
  
  func getItemSize() -> CGSize {
    if photos.count == 4 {
      return CGSize(width: 110, height: 110)
    }
    if photos.count == 1 {
      return CGSize(width: 130, height: 130)
    }
    return CGSize(width: 90, height: 90)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatar.image = nil
    name.text = nil
    content.text = nil
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
}

extension MomentCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
      fatalError("Can not create cell")
    }
    cell.configure(with: comments[indexPath.row])
    
    return cell
  }
}
