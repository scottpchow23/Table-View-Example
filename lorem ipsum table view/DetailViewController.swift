//
//  DetailViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/2/18.
//  Copyright © 2018 something here. All rights reserved.
//

import Kingfisher
import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .red
        label.text = movie.title
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: URL(string: movie.imageURL) )
    }
    @IBAction func backButtonTUI(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
