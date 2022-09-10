//
//  APIPath.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation


class APIPath {
    let barURL = "https://api.themoviedb.org"
    let imageBaseURL = "https://image.tmdb.org"
    let versionNumber = 3
    let apiKey = "38a73d59546aa378980a88b645f487fc"
    let urlInString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc"
    
    func getMovieListPath() -> String {
        return "\(barURL)/\(versionNumber)/movie/now_playing?api_key=\(apiKey)"
    }
    
    func getImagePath(imageName: String, width: String) -> String {
        return "\(imageBaseURL)/t/p/w\(width)/\(imageName)"
    }
}
