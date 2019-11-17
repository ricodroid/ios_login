//
//  AViewController.swift
//  test_walkthrough
//
//  Created by tessy0901 on 2019/11/15.
//  Copyright © 2019 tessy0901. All rights reserved.
//

import UIKit

class AViewController: UIViewController {
    var onButtonTapped: () -> Void = {}
    @IBAction func nextMove(_ sender: Any) {
        onButtonTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
