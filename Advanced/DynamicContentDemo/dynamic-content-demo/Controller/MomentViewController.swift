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
  var momentFooter: MomentFooter = MomentFooter()
  var loadingData = false

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "MomentCell", bundle: nil), forCellReuseIdentifier: "MomentCell")
    tableView.register(UINib(nibName: "MomentFooter", bundle: nil), forCellReuseIdentifier: "MomentFooter")
    setupRefresh()
    fetchData()
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func setupRefresh() {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
  }
  
  @objc func refreshData(_ refreshControl: UIRefreshControl) {
    momentViewModel.getInitialMoments()
    tableView.reloadData()
    refreshControl.endRefreshing()
  }
  
  func fetchData() {
    momentViewModel.getUser() { [weak self] in
      let momentHeader = Bundle.main.loadNibNamed("MomentHeader", owner: nil, options: nil)?.first as! MomentHeader
      momentHeader.configure(with: (self?.momentViewModel.user)!)
      self?.tableView.tableHeaderView = momentHeader
    }
    momentViewModel.getMoments() { [weak self] in
      self?.tableView.reloadData()
    }
  }
}

extension MomentViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return momentViewModel.moments.count
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as? MomentCell else {
        fatalError("Can not create cell")
      }
      if (indexPath.row == self.momentViewModel.moments.count - 1) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
      }
      cell.configure(with: momentViewModel.moments[indexPath.row])
      return cell
    }
    momentFooter = tableView.dequeueReusableCell(withIdentifier: "MomentFooter", for: indexPath) as! MomentFooter
    momentFooter.separatorInset = UIEdgeInsets(top: 0, left: momentFooter.bounds.size.width, bottom: 0, right: 0);
    return momentFooter
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let distance = scrollView.contentSize.height - scrollView.frame.size.height
    
    if offsetY > distance && !loadingData && offsetY > 0 && !momentViewModel.isAllLoaded() {
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
    momentViewModel.loadMore()
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if momentViewModel.moments.count == 0 {
      momentFooter.indicator.isHidden = true
      momentFooter.label.isHidden = true
    } else if momentViewModel.isAllLoaded() {
      momentFooter.indicator.isHidden = true
      momentFooter.label.isHidden = false
      momentFooter.label.text = "All loaded"
    } else {
      momentFooter.indicator.isHidden = false
      momentFooter.label.isHidden = true
    }
  }
}
