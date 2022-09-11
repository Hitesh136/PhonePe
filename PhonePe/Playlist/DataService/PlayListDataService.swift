//
//  PlayListManager.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation
import CoreData

class PlayListDataService {
    
    var managedObjectContext: NSManagedObjectContext {
        AppDelegate.getAppDelegate.persistentContainer.viewContext
    }
    
    
    func mapPlayList(viewModels: [MovieTableCellViewModel]) {
        
        var map = [Int: MovieTableCellViewModel]()
        
        for viewModel in viewModels {
            map[viewModel.movieId] = viewModel
        }
        
        let playListArray = getAllPlayList()
        for element in playListArray {
            for movie in element.movies {
                if let movieViewModel = map[movie.id] {
                    movieViewModel.playListArray.append(element.name)
                }
            }
        }
    }
    
    func getPlayList(withName name: String) -> PlaylistEntity? {
        
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results.first
        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        return nil
    }
    
    func getAllPlayList() -> [PlaylistDTO] {
        
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
                
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            var dtos = [PlaylistDTO]()
            
            for result in results {
                let moviesEntities = result.movie?.allObjects as! [MovieEntity]
                
                let movieDTOs = moviesEntities.compactMap{ Int($0.id) }.map{ MovieIdDTO(id: $0) }

                if let name = result.name {
                    let dto = PlaylistDTO(name: name, movies: movieDTOs)
                    dtos.append(dto)
                }
            }
            return dtos
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
    func createNewPlayList(name: String) {
        
        guard getPlayList(withName: name) == nil else { return }
        let playListEntity = PlaylistEntity(context: managedObjectContext)
        
        playListEntity.name = name
        playListEntity.movie = NSSet(array: [])
        do {
            try managedObjectContext.save()
            print("Saved")
        }
        catch let error {
            print(error)
        }
    }
    
    func addMovie(_ playListName: String,_ movieId: Int) {
        
        guard let playListEntity = getPlayList(withName: playListName) else { return }
        var moviesSet = [MovieEntity]()
        if let array = playListEntity.movie?.allObjects as? [MovieEntity] {
            moviesSet = array
        }
        
        var found = false
        for movie in moviesSet {
            if movie.id == Int32(movieId) {
                found = true
                break
            }
        }
        if !found {
            let newEntity = MovieEntity(context: managedObjectContext)
            newEntity.id = Int32(movieId)
            moviesSet.append(newEntity)
        } 
         
        playListEntity.movie = NSSet(array: moviesSet)
        do {
            try managedObjectContext.save()
            print("Saved")
        }
        catch let error{
            print(error)
        }
    }
}
 


