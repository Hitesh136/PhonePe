//
//  PlayListViewModel.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class PlayListViewModel {
    
    private var dataManager = PlayListDataService()
    var playListItems = [PlayItemViewModel]()
    var movieId: Int?
    init(movieId: Int?) {
        self.movieId = movieId
        fetchItemsFromDB()
    }
    
    func fetchItemsFromDB() {
        playListItems = dataManager.getAllPlayList().map{ PlayItemViewModel(dto: $0) }
    }
    
    func numberOfRows() -> Int {
        return playListItems.count
    }
    
    func cellViewModel(atIndexPath indexPath: IndexPath) -> PlayItemViewModel {
        return playListItems[indexPath.row]
    }
    
    func createNewPlayList(withName name: String) {
        dataManager.createNewPlayList(name: name)
    }
    
    func addMovie(atIndexPath indexPath: IndexPath) {
        guard let movieId = movieId else { return }
        let playList = playListItems[indexPath.row]
        dataManager.addMovie(playList.name, movieId)
    }
    
}
