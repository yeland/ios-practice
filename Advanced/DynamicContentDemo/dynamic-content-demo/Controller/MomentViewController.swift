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
  var momentFooter: MomentFooter!
  var momentHeader: MomentHeader = MomentHeader()
  var loadingData = false

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "MomentCell", bundle: nil), forCellReuseIdentifier: "MomentCell")
    setupRefresh()
    fetchData()
    setupFooter()
    
    tableView.dataSource = self
    tableView.delegate = self
    navigationController?.navigationBar.isHidden = true
    tableView.contentInsetAdjustmentBehavior = .never
  }
  
  func setupRefresh() {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
  }
  
  @objc func refreshData(_ refreshControl: UIRefreshControl) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
      self.momentViewModel.getInitialMoments()
      self.tableView.reloadData()
      refreshControl.endRefreshing()
    }
  }
  
  func fetchData() {
    momentViewModel.getUser() { [weak self] in
      self?.setupHeader()
    }
    momentViewModel.getMoments() { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  func setupHeader() {
    momentHeader = Bundle.main.loadNibNamed("MomentHeader", owner: nil, options: nil)?.first as! MomentHeader
    momentHeader.configure(with: momentViewModel.user)
    let header = UITableViewHeaderFooterView()
    header.backgroundColor = .white
    header.addSubview(momentHeader)
    header.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 306)
    tableView.tableHeaderView = header
    momentHeader.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      momentHeader.topAnchor.constraint(equalTo: header.topAnchor),
      momentHeader.bottomAnchor.constraint(equalTo: header.bottomAnchor),
      momentHeader.leadingAnchor.constraint(equalTo: header.leadingAnchor),
      momentHeader.trailingAnchor.constraint(equalTo: header.trailingAnchor),
    ])
  }
  
  func setupFooter() {
    momentFooter = Bundle.main.loadNibNamed("MomentFooter", owner: nil, options: nil)?.first as? MomentFooter
    let footer = UITableViewHeaderFooterView()
    footer.backgroundColor = .white
    footer.addSubview(momentFooter)
    footer.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 80)
    tableView.tableFooterView = footer
    momentFooter.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      momentFooter.topAnchor.constraint(equalTo: footer.topAnchor),
      momentFooter.bottomAnchor.constraint(equalTo: footer.bottomAnchor),
      momentFooter.leadingAnchor.constraint(equalTo: footer.leadingAnchor),
      momentFooter.trailingAnchor.constraint(equalTo: footer.trailingAnchor)
    ])
  }
}

extension MomentViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return momentViewModel.moments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as? MomentCell else {
      fatalError("Can not create cell")
    }
    cell.configure(with: momentViewModel.moments[indexPath.row]) {
      self.addCommentAction(row: indexPath.row)
    }
    return cell
  }
  
  private func addCommentAction(row: Int) {
    let alert = UIAlertController(title: "Add Comment", message: "please", preferredStyle: .alert)
    let sendAction = UIAlertAction(title: "send", style: .default) { [weak self] action in
      guard let textField = alert.textFields?.first, let comment = textField.text else {
        return
      }
      self?.momentViewModel.addComment(row: row, comment: comment)
      self?.tableView.reloadData()
    }
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
    alert.addTextField()
    alert.addAction(sendAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true)
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

extension MomentViewController: UIScrollViewDelegate {
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
    
    setupNavigationBar(offsetY: offsetY)
  }
  
  func setupNavigationBar(offsetY: CGFloat) {
    if offsetY < 170 {
      navigationController?.navigationBar.isHidden = true
    } else {
      navigationController?.navigationBar.isHidden = false
    }
  }
  
  func loadMore() {
    loadingData = true
    momentViewModel.loadMore()
    tableView.reloadData()
  }
}
