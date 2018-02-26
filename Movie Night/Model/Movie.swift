//
//  Movie.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/20/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


struct Movie {
    let title: String
    let overview: String
    let releaseDate: Date
}

extension Movie: JSONDecodable {
    init?(json: [String : Any]) {
        guard let title = json["title"] as? String,
              let overview = json["overview"] as? String,
              let releaseDate = json["release_date"] as? String else {print("Parsing failed");return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        guard let date = formatter.date(from: releaseDate) else {print("GIVE IT UP MAN");return nil}
        self.title = title
        self.overview = overview
        self.releaseDate = date
    }
}


