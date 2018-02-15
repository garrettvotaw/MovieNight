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
}

extension Actor: JSONDecodable {
    init?(json: [String : Any]) {
        guard let name = json["name"] as? String, let id = json["id"] as? Int else {return nil}
        self.name = name
        self.id = id
    }
}
