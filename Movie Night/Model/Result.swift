//
//  Result.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/14/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation


enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
