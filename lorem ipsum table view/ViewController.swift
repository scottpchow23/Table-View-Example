//
//  ViewController.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 4/18/18.
//  Copyright © 2018 something here. All rights reserved.
//


import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    var strings = [String]()
    
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
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.red
        }
        cell.label.text = strings[indexPath.row]
        return cell
    }
    
    func getMovies() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    return
                }
                if let data = data {
                    guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDict = json as? [String : Any],
                    let feedJsonDict = jsonDict["feed"] as? [String :Any],
                    let resultsJSONDict = feedJsonDict["results"] as? [[String : Any]]
                        else {
                            return
                    }
                    for resultJSONDict in resultsJSONDict {
                        guard let name = resultJSONDict["name"] as? String else {
                            return
                        }
                        print(name)
                        self.strings.append(name)
                        
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
            })
            task.resume()
        }
    }
}



















