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
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(r: 76, g: 217, b: 100)
        } else {
            cell.contentView.backgroundColor = UIColor(r: 90, g: 200, b: 250)
        }
        cell.label.text = movies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.movie = movies[indexPath.row]
        
        self.present(detailVC, animated: true, completion: nil)
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


















