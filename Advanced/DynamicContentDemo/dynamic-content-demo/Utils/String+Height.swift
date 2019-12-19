//
//  String+Height.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/19.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

extension String {
  func height(constrainedToWidth width: CGFloat) -> CGFloat {
    return NSString(string: self).boundingRect(
      with: CGSize(width: width, height: .greatestFiniteMagnitude),
      options: .usesLineFragmentOrigin,
      attributes: [.font: UIFont.systemFont(ofSize: 15)],
      context: nil).size.height
  }
}
