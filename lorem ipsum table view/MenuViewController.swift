//
//  MenuViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/16/18.
//  Copyright © 2018 something here. All rights reserved.
//

import UIKit

let urlStrings = ["https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json",
                    "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/25/explicit.json"]

class MenuViewController: UIViewController {
    
    @IBOutlet weak var moviesButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesButton.layer.cornerRadius = moviesButton.layer.bounds.height/2
        musicButton.layer.cornerRadius = musicButton.layer.bounds.height/2
    }
    @IBAction func movieButtonTUI(_ sender: Any) {
        self.transition(with: sender)
    }
    @IBAction func musicButtonTUI(_ sender: Any) {
        self.transition(with: sender)
    }
    
    
    func transition(with sender: Any) {
        guard let sender = sender as? UIButton else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieViewController") as! ViewController
        movieViewController.type = .movie
        if sender.tag == 0 {
            
        } else {
            movieViewController.type = .track
        }
        movieViewController.urlString = urlStrings[sender.tag]
        self.navigationController?.pushViewController(movieViewController, animated: true)
    }
    
}
