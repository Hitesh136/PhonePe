//
//  MovieListViewModel.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class MovieListViewModel {
    
    enum FilterState {
        case filter
        case clear
        
        func getButtonText() -> String {
            switch self {
            case .filter:
                return "Filter"
            case .clear:
                return "Clear"
            }
        }
    }
    
    private var cellViewModels = [MovieTableCellViewModel]()
    var filterCellViewModels = [MovieTableCellViewModel]()
    var filterState: FilterState = .filter
    var currentFilteredPlaylist: String?
    
    func getMovies(_ completion: @escaping (String?) -> ()) {
        
        MovieAPIService().getMovieList { [weak self] dtos in
            guard let self = self else { return }
            
            
            guard let dtos = dtos else {
                completion("Something Went wrong")
                return
            }
            
            self.cellViewModels = dtos.map{ MovieTableCellViewModel(dto: $0) }
            PlayListDataService().mapPlayList(viewModels: self.cellViewModels)
            self.filterData(currentFilteredPlaylist: self.currentFilteredPlaylist)
            completion(nil)
        }
    }
    
    func filterData(currentFilteredPlaylist: String?) {
        guard let currentFilteredPlaylist = currentFilteredPlaylist else {
            return
        }
        self.currentFilteredPlaylist = currentFilteredPlaylist
        filterCellViewModels.removeAll()
        for cellViewModel in cellViewModels {
            if cellViewModel.containsPlayList(currentFilteredPlaylist) {
                filterCellViewModels.append(cellViewModel)
            }
        }
        filterState = .clear
    }
    
    func removeFilter() {
        filterState = .filter
        filterCellViewModels.removeAll()
        currentFilteredPlaylist = nil
    }
    
    func toggleFilter(currentFilteredPlaylist: String? = nil) {
        switch filterState {
        case .filter:
            removeFilter()
        case .clear:
            if let playListName = currentFilteredPlaylist {
                filterData(currentFilteredPlaylist: playListName)
            }
        }
    }
    
    func numberOfRows() -> Int {
        switch filterState {
        case .filter:
            return cellViewModels.count
        case .clear:
            return filterCellViewModels.count
        }
    }
    
    func cellViewModel(atIndexPath indexPath: IndexPath) -> MovieTableCellViewModel {
        switch filterState {
        case .filter:
            return cellViewModels[indexPath.row]
        case .clear:
            return filterCellViewModels[indexPath.row]
        }
    }
    
    func update(cellViewModel: MovieTableCellViewModel, atIndexPath indexPath: IndexPath) {
        switch filterState {
        case .filter:
            if indexPath.row < numberOfRows() {
                cellViewModels[indexPath.row] = cellViewModel
            }
        case .clear:
            if indexPath.row < numberOfRows() {
                filterCellViewModels[indexPath.row] = cellViewModel
            }
        }
        
    }
    
    func getFilterButtonText() -> String {
        return filterState.getButtonText()
    }
}

