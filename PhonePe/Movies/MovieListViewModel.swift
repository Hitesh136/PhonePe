//
//  MovieListViewModel.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class MovieListViewModel {
    
    
    private var cellViewModels = [MovieTableCellViewModel]()
    
    func getMovies(_ completion: @escaping (String?) -> ()) {
        
        MovieAPIService().getMovieList { [weak self] dtos in
            guard let self = self else { return }
            
            
            guard let dtos = dtos else {
                completion("Something Went wrong")
                return
            }
            
            self.cellViewModels = dtos.map{ MovieTableCellViewModel(dto: $0) }
            completion(nil)
        }
    }
    
    func numberOfRows() -> Int {
        return cellViewModels.count
    }
    
    func cellViewModel(atIndexPath indexPath: IndexPath) -> MovieTableCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func update(cellViewModel: MovieTableCellViewModel, atIndexPath indexPath: IndexPath) {
        if indexPath.row < numberOfRows() {
            cellViewModels[indexPath.row] = cellViewModel
        }
    }
}

