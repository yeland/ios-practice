//
//  NavigationPracticeViewController.swift
//  UIKitDemo
//
//  Created by Facheng Liang  on 2019/11/11.
//  Copyright © 2019 Facheng Liang . All rights reserved.
//

import UIKit

class NavigationPracticeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func clickPushButton(_ sender: Any) {
		// Navigation-TODO1: Push `GreenViewController`
        let greenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GreenViewController")
        navigationController?.pushViewController(greenViewController, animated: true)
	}

	@IBAction func clickPresentButton(_ sender: Any) {
		// Navigation-TODO2: Present `GreenViewController`
        let greenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GreenViewController")
        let nav = UINavigationController(rootViewController: greenViewController)
//        present(greenViewController, animated: true)
        show(nav, sender: self)
	}
}
