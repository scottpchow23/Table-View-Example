//
//  Track.swift
//  lorem ipsum table view
//
//  Created by Scott P. Chow on 5/23/18.
//  Copyright © 2018 something here. All rights reserved.
//

import Foundation
import SwiftyJSON

class Track {
    var artistName: String
    var releaseDate: Date
    var trackTitle: String
    var trackCollection: String
    var artworkURL: URL?
    
    init() {
        artistName = ""
        releaseDate = Date()
        trackTitle = ""
        trackCollection = ""
        artworkURL = nil
    }
    
    init?(json: JSON) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let trackTitle = json["name"].string,
            let artistName = json["artistName"].string,
            let artworkURL = json["artworkUrl100"].string,
            let releaseDate = json["releaseDate"].string,
            let trackCollection = json["collectionName"].string,
            let date = formatter.date(from: releaseDate),
            let urlString = json["url"].string,
            let url = URL(string:artworkURL) else {
                return nil
        }
        self.artistName = artistName
        self.releaseDate = date
        self.trackTitle = trackTitle
        self.trackCollection = trackCollection
        self.artworkURL = url
        
    }
}
