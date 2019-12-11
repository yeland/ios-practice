//
//  MomentCellForComments.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/4.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

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
