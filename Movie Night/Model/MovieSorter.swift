//
//  MovieSorter.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/20/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


class MovieSorter {
    static var sortedGenrePreferences = [Int]()
    static var sortedActorPreferences = [Int]()
    
    static func sortGenres() {
        for genreOne in User1.genrePreferences {
            sortedGenrePreferences = User2.genrePreferences.filter { $0 == genreOne }
        }
    }
    
    static func sortActors() {
        for actorOne in User1.genrePreferences {
            sortedActorPreferences = User2.genrePreferences.filter { $0 == actorOne }
        }
    }
    
}

