//
//  Movie.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/9/18.
//  Copyright © 2018 something here. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    var title: String
    var imageURL: String
    var artistName: String
    var genre: String
    var releaseDate: Date
    var urlString: String
    
    init() {
        title = ""
        imageURL = ""
        artistName = ""
        genre = ""
        releaseDate = Date()
        urlString = ""
    }
    init?(json: JSON) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let name = json["name"].string,
            let artistName = json["artistName"].string,
            let artworkURL = json["artworkUrl100"].string,
            let genre = json["genres"][0]["name"].string,
            let releaseDate = json["releaseDate"].string,
            let date = formatter.date(from: releaseDate),
            let urlString = json["url"].string else {
                return nil
        }
        
        
        
        title = name
        self.artistName = artistName
        imageURL = artworkURL
        self.genre = genre
        self.releaseDate = date
        self.urlString = urlString
    }
}













