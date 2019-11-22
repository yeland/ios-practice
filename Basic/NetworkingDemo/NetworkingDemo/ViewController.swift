//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Linxiao Wei on 2019/11/21.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let contentService = ContentService()
  var contents: [Content] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentService.getResults() { [weak self] results, errorMessage in
      if let results = results {
        self?.contents = results
        self?.tableView.reloadData()
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
    }

    tableView.dataSource = self
  }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentCell else {
      return UITableViewCell()
    }
    cell.configure(with: self.contents[indexPath.row])
    
    return cell
  }
}


