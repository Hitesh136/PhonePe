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
        
    }
    
    func getAllPlayList() -> [PlayListViewModel] {
        
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
                
        do {
            let results = try fetchRequest.execute()
            return results.compactMap{$0.name }.map{ PlayListViewModel(name: $0)}
        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        return []
    }
    
    func addPlayList(name: String) {
        
        let playListEntity = PlaylistEntity(context: managedObjectContext)
        playListEntity.name = name
        do {
            try managedObjectContext.save()
        }
        catch {
            // Handle Error
        }
    }
    
    func addMovie(_ playListName: String,_ movieId: Int) {
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == \(playListName)")
    
        
        do {
            let results: [PlaylistEntity] = try fetchRequest.execute()
            if let playListFirst = results.first {

                var moviesSet = playListFirst.movie as! Set<Int>
                if !moviesSet.contains(movieId) {
                    moviesSet.insert(movieId)
                }
            }

            do {
                try managedObjectContext.save()
            }
            catch {
                // Handle Error
            }

        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
    }
}

extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}


