//
//  ViewController.swift
//  dynamic-content-demo
//
//  Created by Xin Guo on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  private let networkClient: NetworkClient = .init()
  private let momentViewModel = MomentsViewModel()
  var moments: [Moment] = []

  override func viewDidLoad() {
    super.viewDidLoad()
//    tableView.register(UINib(nibName: "SingleLabelCell", bundle: nil), forCellReuseIdentifier: "SingleLabelCell")
    tableView.register(UINib(nibName: "MomentCell", bundle: nil), forCellReuseIdentifier: "MomentCell")
    
    momentViewModel.getMoments() { [weak self] moments in
      self?.tableView.reloadData()
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return momentViewModel.showMoments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as? MomentCell else {
      fatalError("Can not create cell")
    }
    
    cell.configure(with: momentViewModel.showMoments[indexPath.row])

    return cell
  }
}

