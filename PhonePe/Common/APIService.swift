//
//  APIService.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation
 
class APIService {
        
    /*
     We should use ResultType instead of data in completion hander
     This network layer is not fully implemented. It should add more cases like checking for status code and error coming from json or error coming from server like internal server error.
     This function should be generic and return the response dto in result type.
     */
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


 
