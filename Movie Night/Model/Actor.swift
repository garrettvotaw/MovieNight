//
//  Actor.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation

struct Actor {
    let name: String
    let id: Int
    var isSelected: Bool = false
    var associatedMovies: [Movie] = []
}

extension Actor: JSONDecodable {
    init?(json: [String : Any]) {
        guard let knownFor = json["known_for"] as? [[String : Any]] else {print("KnownForFailed");return nil}
        guard let name = json["name"] as? String, let id = json["id"] as? Int else {return nil}
        self.name = name
        self.id = id
        self.associatedMovies = knownFor.flatMap{Movie(json: $0)}
    }
}
