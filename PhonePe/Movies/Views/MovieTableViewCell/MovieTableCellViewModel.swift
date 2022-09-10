//
//  ContentTableViewCellModel.swift
//  Caraousell
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class MovieTableCellViewModel {
    
    private var dto: MovieDTO
    
    var movieName: String
    var rating: String
    var playListArray = [String]()
    var playList: String {
        return playListArray.joined(separator: ", ")
    }
    var movieImageURLInString: String
    var movieId: Int {
        return dto.id
    }
    var movieImageURL: URL? {
        URL(string: movieImageURLInString)
    }
    init(dto: MovieDTO) {
        self.dto = dto
        
        self.movieName = dto.originalTitle
        self.rating = "Rating - \(dto.voteAverage)"
        
        self.movieImageURLInString = APIPath().getImagePath(imageName: dto.posterPath, width: "500")
    }
    
}
