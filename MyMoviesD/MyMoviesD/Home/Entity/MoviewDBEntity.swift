//
//  MoviewDBEntity.swift
//  MyMoviesD
//
//  Created by Briam Cano on 03/08/24.
//

import Foundation

struct UpcomingEntity: Codable {
    var movieName: String
    var moviewImage: String
    var movieDescription: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case movieName = "original_title"
        case moviewImage = "poster_path"
        case movieDescription = "overview"
        case date = "release_date"
    }
}
