//
//  ViewController.swift
//  AutoLayoutChallenge1
//
//  Created by Zhiying Fan  on 2019/11/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var redView: UIView!
  @IBOutlet weak var redViewWidth: NSLayoutConstraint!
  @IBOutlet weak var yellowView: UIView!
  @IBOutlet weak var greyView: UIView!
  @IBOutlet weak var orangeView: UIView!
  @IBOutlet weak var brownView: UIView!
  @IBOutlet weak var purpleView: UIView!

  var timer: Timer!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()

    timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
    
  }
  
  private func setupLayout() {
    yellowView.translatesAutoresizingMaskIntoConstraints = false
    greyView.translatesAutoresizingMaskIntoConstraints = false
    orangeView.translatesAutoresizingMaskIntoConstraints = false
    brownView.translatesAutoresizingMaskIntoConstraints = false
    purpleView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      yellowView.widthAnchor.constraint(equalTo: redView.widthAnchor, multiplier: 0.5),
      yellowView.heightAnchor.constraint(equalToConstant: 20),
      yellowView.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
      yellowView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: -10),
      
      greyView.widthAnchor.constraint(equalTo: redView.widthAnchor, multiplier: 0.5),
      greyView.topAnchor.constraint(equalTo: redView.topAnchor),
      greyView.heightAnchor.constraint(equalToConstant: 60),
      greyView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 10),
      
      orangeView.widthAnchor.constraint(equalTo: redView.widthAnchor, multiplier: 0.5),
      orangeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
      orangeView.heightAnchor.constraint(equalToConstant: 60),
      orangeView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 10),
      
      brownView.widthAnchor.constraint(equalToConstant: 50),
      brownView.heightAnchor.constraint(equalToConstant: 60),
      brownView.topAnchor.constraint(equalTo: redView.topAnchor),
      brownView.leadingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: 10),
      
      purpleView.widthAnchor.constraint(equalToConstant: 50),
      purpleView.heightAnchor.constraint(equalToConstant: 60),
      purpleView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
      purpleView.leadingAnchor.constraint(equalTo: orangeView.trailingAnchor, constant: 10),
    ])
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    timer.invalidate()
  }

  @objc func animation() {
    if redViewWidth.constant >= 160 {
      redViewWidth.constant = 80
    } else {
      redViewWidth.constant = 160
    }

    UIView.animate(withDuration: 0.8) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
}

