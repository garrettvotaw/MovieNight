//
//  Genre.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


struct Genre {
    let name: String
    let id: Int
    var isSelected: Bool = false
    
    init(name: String) {
        self.name = name
        self.id = 0
        self.isSelected = false
    }
}

extension Genre: JSONDecodable {
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String
              else {return nil}
        self.id = id
        self.name = name
    }
}
