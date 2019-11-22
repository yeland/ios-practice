//
//  LabelComponentViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/15.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class LabelComponentViewController: UIViewController {

    private let contentView = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .systemPink
        contentView.text = "hello"
        contentView.textColor = .white
        contentView.textAlignment = .center
    }

    private func setupLayout() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 200),
            contentView.heightAnchor.constraint(equalToConstant: 100),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
