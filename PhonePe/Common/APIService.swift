//
//  APIService.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

import Foundation
 
class APIService {
        
    func getAPIRequest(_ url: String, _ completion: @escaping ((Data?) -> ()) ) {
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                if let data = data {
                    completion(data)
                }
                
            }
        }.resume()
    } 
}


 
