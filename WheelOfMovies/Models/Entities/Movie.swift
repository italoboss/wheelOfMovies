//
//  Movie.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

struct Movie: Codable {
    
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var voteAverage: Float
    var releaseDate: String
    
    var posterImage: UIImage?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }

    init?(from local: FavoriteMovies) {
        self.id = Int(local.id)
        guard let title = local.title,
                let overview = local.overview,
                let releaseDate = local.releaseDate
            else {
                return nil
        }
        self.title = title
        self.overview = overview
        self.voteAverage = local.voteAverage
        self.releaseDate = releaseDate
        
        if let posterPath = local.posterImagePath {
            self.posterPath = posterPath
            var path = AppConfig.LOCAL_IMAGES_PATH
            path.append(posterPath)
            self.posterImage = UIImage(contentsOfFile: path)
        }
    }
    
    
    static func decodeToArray(from data: Data) -> [Movie]? {
        do {
            let decoded = try JSONDecoder().decode([Movie].self, from: data)
            return decoded
        }
        catch {
            let nserror = error as NSError
            ErrorHandler.shared.consoleLogError(nserror)
            return nil
        }
    }
    
    func convertToManagedObject() -> FavoriteMovies {
        let favorite: FavoriteMovies = CoreDataManager.shared.initManagedObject()
        favorite.id = Int64(self.id)
        favorite.title = self.title
        favorite.overview = self.overview
        favorite.voteAverage = self.voteAverage
        favorite.releaseDate = self.releaseDate
        favorite.posterImagePath = self.posterPath
        return favorite
    }
    
}


// MARK: - Local access
extension Movie {
    
    var isSaved: Bool {
        return MovieDao.shared.get(by: self.id) != nil
    }
    
    func saveLocal() -> Bool {
        return MovieDao.shared.save(self)
    }
    
    func deleteLocal() -> Bool {
        return MovieDao.shared.delete(self)
    }
    
}
