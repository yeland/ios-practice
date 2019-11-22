//
//  PinchViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/18.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class PinchViewController: UIViewController {

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        title = "Pinch"
        imageView.image = UIImage(named: "flower")
        imageView.isUserInteractionEnabled = true

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        imageView.addGestureRecognizer(pinch)
    }
    
    @objc func handlePinch(recognizer:UIPinchGestureRecognizer) {
      if let view = recognizer.view {
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
      }
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

