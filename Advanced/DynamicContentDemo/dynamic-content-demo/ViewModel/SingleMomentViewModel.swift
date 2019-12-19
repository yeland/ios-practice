//
//  SingleMomentViewModel.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/19.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class SingleMomentViewModel {
  func getCommentsHeight(_ comments: [Comment]) -> CGFloat {
    var totalHeight: CGFloat = 0
    for comment in comments {
      let height = (comment.sender.nick + comment.content).height(constrainedToWidth: UIScreen.main.bounds.width - CGFloat(87))
      totalHeight += (height + 10)
    }
    return totalHeight
  }
}
