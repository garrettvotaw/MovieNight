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
