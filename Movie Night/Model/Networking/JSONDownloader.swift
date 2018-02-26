//
//  JSONDownloader.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/6/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init?(json: [String:Any])
}
