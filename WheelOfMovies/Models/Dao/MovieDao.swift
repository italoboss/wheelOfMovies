//
//  MovieDao.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 22/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

class MovieDao {
    
    static let shared = MovieDao()
    
    func save(_ movie: Movie) -> Bool {
        let favorite = movie.convertToManagedObject()
        
        if let poster = movie.posterImage {
            var path = AppConfig.LOCAL_IMAGES_PATH
            path.append(contentsOf: movie.posterPath!)
            if FileManager.default.createFile(atPath: path, contents: poster.jpegData(compressionQuality: 1.0), attributes: [:]) {
                favorite.posterImagePath = movie.posterPath
            }
        }
        
        return CoreDataManager.shared.saveContext()
    }
    
    func get(by id: Int) -> Movie? {
        guard let local: FavoriteMovies = CoreDataManager.shared.fetchObject(by: id) else { return nil }
        let movie = Movie(from: local)
        return movie
    }
    
    func getAll() -> [Movie]? {
        guard let locals: [FavoriteMovies] = CoreDataManager.shared.fecth() else { return nil }
        let movies = locals.compactMap { (local) -> Movie? in Movie(from: local) }
        return movies
    }
    
}