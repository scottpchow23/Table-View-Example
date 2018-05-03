//
//  DetailViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/2/18.
//  Copyright © 2018 something here. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .red
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.text = "Hey there"
    }

}
