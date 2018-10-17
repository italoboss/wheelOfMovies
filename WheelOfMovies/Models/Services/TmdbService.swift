//
//  TmdbService.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

class TmdbService {
    
    func discoverMovies(by genres: [Int], completion: @escaping ([Movie]?) -> Void) {
        var discoverEnd = AppConfig.BASE_API_ENDPOINT
        discoverEnd.path = "discover/movie"
        
        let genreItem = URLQueryItem(name: "with_genres", value: genres.join(with: ","))
        discoverEnd.queryItems.append(genreItem)
        
        let task = URLSession.shared.dataTask(with: discoverEnd.url!) { (data, response, error) in

            guard let result = data,
                let discover = DiscoverDto.decode(from: result)
                else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(discover.movies)
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
    
    func listGenres(completion: @escaping ([Genre]?) -> Void) {
        var allGenresEnd = AppConfig.BASE_API_ENDPOINT
        allGenresEnd.path = "genre/movie/list"
        
        let task = URLSession.shared.dataTask(with: allGenresEnd.url!) { (data, response, error) in
            
            guard let result = data,
                let allGenres = GenresDto.decode(from: result)
                else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
            }
            
            DispatchQueue.main.async {
                completion(allGenres.genres)
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
    
}
