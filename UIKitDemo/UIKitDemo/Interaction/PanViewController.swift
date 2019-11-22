//
//  PanViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/18.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class PanViewController: UIViewController {

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        title = "Pan"
        imageView.image = UIImage(named: "flower")
        imageView.isUserInteractionEnabled = true

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        imageView.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
      let translation = recognizer.translation(in: self.view)
      if let view = recognizer.view {
        view.center = CGPoint(x:view.center.x + translation.x,
                                y:view.center.y + translation.y)
      }
      recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 125),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
