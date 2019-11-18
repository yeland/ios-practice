//
//  LongPressViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/18.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class LongPressViewController: UIViewController {
    
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .green
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.view.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            contentView.backgroundColor = .red
        } else if recognizer.state == .ended {
            contentView.backgroundColor = .green
        }
    }

    private func setupLayout() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 200),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
