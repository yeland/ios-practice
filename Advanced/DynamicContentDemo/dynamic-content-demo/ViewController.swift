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
  var step = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "MomentCell", bundle: nil), forCellReuseIdentifier: "MomentCell")
    
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
//    refreshControl.addTarget(self, action: , for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
    
    momentViewModel.getMoments() { [weak self] moments in
      self?.momentViewModel.getUser() {_ in
        self?.tableView.reloadData()
        let momentHeader = Bundle.main.loadNibNamed("MomentHeader", owner: nil, options: nil)?.first as! MomentHeader
        momentHeader.configure(with: (self?.momentViewModel.user)!)
        self?.tableView.tableHeaderView = momentHeader
      }
    }
    
    let momentFooter = Bundle.main.loadNibNamed("MomentFooter", owner: nil, options: nil)?.first as! MomentFooter
    momentFooter.configure() { [weak self] in
      self?.step += 1
      self?.tableView.reloadData()
    }
    tableView.tableFooterView = momentFooter
    
    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return momentViewModel.showMomentsByStep(step: step).count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as? MomentCell else {
      fatalError("Can not create cell")
    }
    
    cell.configure(with: momentViewModel.showMoments[indexPath.row])

    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if momentViewModel.showMoments.count == momentViewModel.showMomentsByStep(step: step).count {
      tableView.tableFooterView = nil
    }
  }
}

