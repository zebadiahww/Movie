//
//  Movie.swift
//  Movie
//
//  Created by Zebadiah Watson on 10/4/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

import Foundation


struct TopLevelDictionary: Codable {
    let results: [Results]
}

struct Results: Codable {
    let title: String
    let rating: Double
    let overview: String
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case overview
        case poster = "poster_path"
    }
} // End of Class
