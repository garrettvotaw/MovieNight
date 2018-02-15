//
//  MovieDBClient.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/14/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


class MovieDBClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getGenres(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        let endpoint = MovieDB.genre
        
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> [Genre] in
            guard let genres = json["genres"] as? [[String:Any]] else { return [] }
            return genres.flatMap { Genre(json: $0) }
        }, completion: completion)
    }
    
    func getActors(page: String, completion: @escaping (Result<[Actor], APIError>) -> Void) {
        let endpoint = MovieDB.people(page: page)
        
        let request = endpoint.request
        
        fetch(with: request, parse: {json -> [Actor] in
            guard let actors = json["results"] as? [[String:Any]] else { return [] }
            return actors.flatMap { Actor(json: $0) }
        }, completion: completion)
        
    }
}
