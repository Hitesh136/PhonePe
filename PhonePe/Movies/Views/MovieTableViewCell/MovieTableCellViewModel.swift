//
//  ContentTableViewCellModel.swift
//  Caraousell
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class MovieTableCellViewModel {
    
    var dto: MovieDTO
    
    var movieName: String
    var rating: String
    var playList: String
    var movieImageURLInString: String
    var movieImageURL: URL? {
        URL(string: movieImageURLInString)
    }
    init(dto: MovieDTO) {
        self.dto = dto
        
        self.movieName = dto.originalTitle
        self.rating = "Rating - \(dto.voteAverage)"
        self.playList = ""
        
        // need to find what url need to add before the posterpath to create the final url .
        self.movieImageURLInString = "https://i.picsum.photos/id/1041/200/300.jpg?hmac=l4FIMky2hFQgqx0kNCHmVhtfQJz_CUcyK_0Q-UiQwAI"
    }
    
}
