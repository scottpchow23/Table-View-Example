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
    
    init() {
        title = ""
        imageURL = ""
        artistName = ""
    }
    init?(json: JSON) {
        guard let name = json["name"].string,
            let artistName = json["artistName"].string,
            let artworkURL = json["artworkUrl100"].string else {
                return nil
        }
        title = name
        self.artistName = artistName
        imageURL = artworkURL
    }
}













