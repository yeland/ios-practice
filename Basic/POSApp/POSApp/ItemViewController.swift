//
//  ViewController.swift
//  POSApp
//
//  Created by Linxiao Wei on 2019/11/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let itemService = ItemService()
  var items: [Item] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    itemService.getResults() { [weak self] results, errorMessage in
      if let results = results {
        self?.items = results
        self?.tableView.reloadData()
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
    }
    tableView.dataSource = self
    let itemHeader = Bundle.main.loadNibNamed("ItemHeader", owner: nil, options: nil)?.first as! ItemHeader
    tableView.tableHeaderView = itemHeader
    itemHeader.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      itemHeader.widthAnchor.constraint(equalTo: tableView.widthAnchor),
      itemHeader.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension ItemViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
      return UITableViewCell()
    }
    cell.configure(with: self.items[indexPath.row])
    
    return cell
  }
  
  
}




