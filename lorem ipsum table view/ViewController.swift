//
//  ViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 4/18/18.
//  Copyright © 2018 something here. All rights reserved.
//
import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    var movies = [Movie]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        getMovies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let movie = movies[indexPath.row]
        cell.movieImageView.kf.setImage(with: URL(string:movie.imageURL))
        cell.movieImageView.layer.cornerRadius = 4
        cell.movieImageView.layer.masksToBounds = true
        cell.titleLabel.text = movie.title
        cell.genreLabel.text = movie.genre
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        cell.releaseDateLabel.text = dateFormatter.string(from: movie.releaseDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        if let url = URL(string: movie.urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func getMovies() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        Alamofire.request(urlString).responseJSON { (response) in
            if let data = response.data {
                
                guard let json = try? JSON(data:data),
                    let results = json["feed"]["results"].array else {
                        return
                }
                
                for result in results {
                    if let movie = Movie(json: result) {
                        self.movies.append(movie)
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat) {
        self.init(red: r/256, green: g/256, blue: b/256, alpha: 1)
    }
}


















