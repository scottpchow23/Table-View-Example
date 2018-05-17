//
//  MenuViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/16/18.
//  Copyright © 2018 something here. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var moviesButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesButton.layer.cornerRadius = moviesButton.layer.bounds.height/2
        musicButton.layer.cornerRadius = musicButton.layer.bounds.height/2
    }
    @IBAction func movieButtonTUI(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieViewController")
        self.navigationController?.pushViewController(movieViewController, animated: true)
    }
    
}
