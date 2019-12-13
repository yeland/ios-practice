//
//  ViewController.swift
//  dynamic-content-demo
//
//  Created by Xin Guo on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import UIKit

class MomentViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  private let networkClient: NetworkClient = .init()
  private let momentViewModel = MomentsViewModel()
  var moments: [Moment] = []
  var timer: Timer!
  var step = 0
  var momentFooter: MomentFooter = MomentFooter()
  var loadingData = false

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "MomentCell", bundle: nil), forCellReuseIdentifier: "MomentCell")
    setRefresh()
    setData()
    setFooter()
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func setRefresh() {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
  }
  
  @objc func refreshData(_ refreshControl: UIRefreshControl) {
    self.step = 0
    self.tableView.reloadData()
    refreshControl.endRefreshing()
  }
  
  func setData() {
    momentViewModel.getUser() { [weak self] _ in
      self?.momentViewModel.getMoments() {_ in
        let momentHeader = Bundle.main.loadNibNamed("MomentHeader", owner: nil, options: nil)?.first as! MomentHeader
        momentHeader.configure(with: (self?.momentViewModel.user)!)
        self?.tableView.tableHeaderView = momentHeader
        self?.tableView.reloadData()
      }
    }
  }
  
  func setFooter() {
    momentFooter = Bundle.main.loadNibNamed("MomentFooter", owner: nil, options: nil)?.first as! MomentFooter
    tableView.tableFooterView = momentFooter
  }
}

extension MomentViewController: UITableViewDataSource, UITableViewDelegate {
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let distance = scrollView.contentSize.height - scrollView.frame.size.height
    
    if offsetY > distance && !loadingData && offsetY > 0 && step < 3 {
      loadingData = true
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
        self.loadMore()
      }
    }
    
    if offsetY < distance {
      loadingData = false
    }
  }
  
  func loadMore() {
    loadingData = true
    step += 1
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if momentViewModel.showMoments.count == momentViewModel.showMomentsByStep(step: step).count && step != 0{
      momentFooter.indicator.isHidden = true
      momentFooter.label.isHidden = false
      momentFooter.label.text = "All loaded"
    } else {
      momentFooter.indicator.isHidden = false
      momentFooter.label.isHidden = true
    }
  }
  
    
}
