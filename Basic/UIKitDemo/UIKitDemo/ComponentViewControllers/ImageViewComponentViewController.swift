//
//  ImageViewComponentViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/15.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class ImageViewComponentViewController: UIViewController {

    private let contentView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        contentView.image = UIImage(named: "flower")
    }

    private func setupLayout() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 400),
            contentView.heightAnchor.constraint(equalToConstant: 250),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
