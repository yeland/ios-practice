//
//  SwipeViewController.swift
//  UIKitDemo
//
//  Created by Linxiao Wei on 2019/11/18.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    private let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        title = "Swipe"
        myView.backgroundColor = .orange
        let left = UISwipeGestureRecognizer(target : self, action : #selector(leftSwipe))
        left.direction = .left
        self.myView.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        self.myView.addGestureRecognizer(right)
        
        let up = UISwipeGestureRecognizer(target : self, action : #selector(upSwipe))
        up.direction = .up
        self.myView.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target : self, action : #selector(downSwipe))
        down.direction = .down
        self.myView.addGestureRecognizer(down)
    }
    
    @objc
    func leftSwipe(){
        myView.backgroundColor = .blue
    }
    
    @objc
    func rightSwipe(){
        myView.backgroundColor = .green
    }
    
    @objc
    func upSwipe(){
        myView.backgroundColor = .yellow
    }
    
    @objc
    func downSwipe(){
        myView.backgroundColor = .gray
    }
    
    private func setupLayout() {
        view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 200),
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
