//
//  EndPoint.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/14/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


protocol EndPoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndPoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [URLQueryItem(name: "api_key", value: "ef1c5cdfd0883dd20daaf8305961ee2e")]
        components.queryItems?.append(contentsOf: queryItems)
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum MovieDB {
    case genre
    case people(page: String)
    case discover(genres: String, people: String)
}

extension MovieDB: EndPoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .genre: return "/3/genre/movie/list"
        case .people: return "/3/person/popular"
        case .discover: return "/3/discover/movie"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .people(let page):
            var result = [URLQueryItem]()
            let pageNumber = URLQueryItem(name: "page", value: page)
            result.append(pageNumber)
            return result
            
        case .discover(let genres, let people):
            var result = [URLQueryItem]()
            let genres = URLQueryItem(name: "with_genres", value: genres)
            result.append(genres)
            let people = URLQueryItem(name: "with_people", value: people)
            result.append(people)
            return result
            
        case .genre: return [URLQueryItem]()
        }
    }
}
