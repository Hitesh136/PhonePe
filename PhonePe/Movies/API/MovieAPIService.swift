//
//  MovieAPIService.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation
class MovieAPIService {
    var apiService = APIService()
    
    func getMovieList(_ completion: @escaping (([MovieDTO]?) -> ()) ) {
        let urlInString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        apiService.getAPIRequest(urlInString) { data in
            
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let movieResponseDTO = try JSONDecoder().decode(MovieResponseDTO.self, from: data)
                completion(movieResponseDTO.results)
            }
            catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
            
        }
        
    }
    
}
