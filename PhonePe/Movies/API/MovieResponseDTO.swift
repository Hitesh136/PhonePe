//
//  MovieDTO.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation
struct MovieResponseDTO: Codable {
    let results: [MovieDTO]
}

// MARK: - Result
struct MovieDTO: Codable {
    let id: Int
    let originalTitle, posterPath: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
