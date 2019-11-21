//
//  DevicesViewController.swift
//  UITableViewDemo
//
//  Created by Facheng Liang  on 2019/11/19.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class DevicesViewController: UIViewController {
  /*
   Implement the `DevicesViewController`
   Acceptance criteria:
   - has a header view above first `Android` or `iOS` device. the header view contains a label, the label text will be the platform name.
   - display name, system and available status in each device cell.
   */

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
//    tableView.tableHeaderView = 
  }
}

extension DevicesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return deviceList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return deviceList[section].devices.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? DeviceCell else {
      return UITableViewCell()
    }
    cell.configure(with: deviceList[indexPath.section].devices[indexPath.row])

    return cell
  }
}

extension DevicesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return deviceList[section].platform.rawValue
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerLabel = UILabel()
    footerLabel.text = "Total:  \(deviceList[section].devices.count)"
    footerLabel.textColor = .systemBlue
    footerLabel.textAlignment = .center

    return footerLabel
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 50
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let sectionFooterHeight = 40;
    let ButtomHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
    if (ButtomHeight - CGFloat(sectionFooterHeight) <= scrollView.contentOffset.y && scrollView.contentSize.height > 0) {
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    } else  {
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(-(sectionFooterHeight)), right: 0);
    }
  }
}
