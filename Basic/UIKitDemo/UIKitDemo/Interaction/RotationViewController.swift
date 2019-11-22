//
//  RotationViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/18.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        title = "Rotation"
        imageView.image = UIImage(named: "flower")
        imageView.isUserInteractionEnabled = true

        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        imageView.addGestureRecognizer(rotation)
    }
    
    @objc func handleRotation(recognizer:UIRotationGestureRecognizer) {
      if let view = recognizer.view {
        view.transform = view.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
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
