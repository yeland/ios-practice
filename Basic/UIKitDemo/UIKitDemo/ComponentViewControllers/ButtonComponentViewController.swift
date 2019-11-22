//
//  ButtonComponentViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/15.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class ButtonComponentViewController: UIViewController {

    private let contentView = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        let buttonImage = UIImage(systemName: "person")
        contentView.tintColor = .black
        contentView.setImage(buttonImage, for: .normal)
        contentView.backgroundColor = .yellow
        contentView.setTitle("click", for: .normal)
        contentView.setTitleColor(.blue, for: .normal)
        contentView.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
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
    
    @objc func changeColor(sender: UIButton) {
        contentView.backgroundColor = .systemPink
    }
}
