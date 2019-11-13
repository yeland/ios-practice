//
//  ViewController.swift
//  P01
//
//  Created by Linxiao Wei on 2019/11/13.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var helloButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTabSayHelloButton(_ sender: UIButton) {
        let text = nameTextField.text ?? ""
        helloLabel.text = "Hello, \(text)!";
        if text.isEmpty {
            helloLabel.text = "Hello, World!";
        }
    }
}

