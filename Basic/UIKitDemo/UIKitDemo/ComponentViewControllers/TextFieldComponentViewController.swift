//
//  TextFieldComponentViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/15.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class TextFieldComponentViewController: UIViewController {

    private let contentView = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        contentView.placeholder = "Input your name"
        contentView.borderStyle = .roundedRect
        contentView.textColor = .systemBlue
    }

    private func setupLayout() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 200),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
