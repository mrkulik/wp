//
//  ViewController.swift
//  Playground
//
//  Created by Kulik on 1/30/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testImageView.image = UIImage(named: "Screenshot 2020-01-07 at 01.28.45")
        // Do any additional setup after loading the view.
    }


}

