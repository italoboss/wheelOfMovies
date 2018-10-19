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
    var posterPath: String
    var voteAverage: Float
    
    var posterImage: UIImage?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
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
    
}
