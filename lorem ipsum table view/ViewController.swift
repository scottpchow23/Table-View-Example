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

enum Type {
    case movie, track
}

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    var movies = [Movie]()
    var tracks = [Track]()
    var type: Type?
    var urlString: String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if self.type == Type.movie {
            self.navigationItem.title = "Movies"
        } else if self.type == Type.track {
            self.navigationItem.title = "Music"
        }
        
        getMovies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type == Type.movie {
            return movies.count
        } else if self.type == Type.track {
            return tracks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        if self.type == .movie {
            let movie = movies[indexPath.row]
            cell.movieImageView.kf.setImage(with: URL(string:movie.imageURL))
            cell.titleLabel.text = movie.title
            cell.genreLabel.text = movie.genre
            cell.releaseDateLabel.text = dateFormatter.string(from: movie.releaseDate)
        } else {
            let track = tracks[indexPath.row]
            cell.movieImageView.kf.setImage(with: track.artworkURL)
            cell.titleLabel.text = track.trackTitle
            cell.genreLabel.text = track.artistName
            cell.releaseDateLabel.text = dateFormatter.string(from: track.releaseDate)
        }
        
        cell.movieImageView.layer.cornerRadius = 4
        cell.movieImageView.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.type == .movie {
            let movie = movies[indexPath.row]
            if let url = URL(string: movie.urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if self.type == .track {
            let track = tracks[indexPath.row]
            if let url = track.artworkURL {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    func getMovies() {
        Alamofire.request(self.urlString!).responseJSON { (response) in
            if let data = response.data {
                
                guard let json = try? JSON(data:data),
                    let results = json["feed"]["results"].array else {
                        return
                }
                
                for result in results {
                    if self.type == Type.movie {
                        if let movie = Movie(json: result) {
                            self.movies.append(movie)
                        }
                    } else {
                        if let track = Track(json: result) {
                            self.tracks.append(track)
                        }
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


















