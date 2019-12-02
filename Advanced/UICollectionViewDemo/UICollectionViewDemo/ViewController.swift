//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Linxiao Wei on 2019/12/2.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
  
  private let reuseIdentifier = "ImageCell"
  
  private let sectionInsets = UIEdgeInsets(top: 20.0, left: 16.0, bottom: 20.0, right: 16.0)
  
  let names = ["pin1", "pin2", "pin3", "pin4", "pin5", "pin6", "pin7", "pin8", "pin9", "pin10",
               "pin11", "pin12", "pin13", "pin14", "pin15", "pin16", "pin17", "pin18", "pin19", "pin20"]

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension ViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return names.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! ImageCell
    cell.imageView.image = UIImage(named: names[indexPath.row])
    
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let paddingSpace = sectionInsets.left * 2 + 10
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / 2
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
}

