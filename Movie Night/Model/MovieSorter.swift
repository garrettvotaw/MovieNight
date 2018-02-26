//
//  MovieSorter.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/20/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


class MovieSorter {
    
    static var sortedGenrePreferences: [Int] {
        var array: [[Int]] = []
        for genreOne in User1.genrePreferences {
            array.append(User2.genrePreferences.filter { $0 == genreOne })
        }
        var newArray = array.flatMap{ return $0 }
        if newArray.isEmpty {
            newArray = User1.genrePreferences + User2.genrePreferences
        }
        return newArray
    }
    
    static var sortedActorPreferences: [Int] {
        var array: [[Int]] = []
        for actorOne in User1.genrePreferences {
            array.append(User2.genrePreferences.filter { $0 == actorOne })
        }
        var newArray = array.flatMap{ return $0 }
        if newArray.isEmpty {
            newArray = User1.actorPreferences + User2.actorPreferences
        }
        return newArray
    }
    
}

