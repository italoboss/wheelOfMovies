//
//  Genre.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

struct Genre: Codable, Equatable {
    var id: Int?
    var name: String?
}


struct GenresDto: Codable {
    var genres: [Genre]
    
    static func decode(from data: Data) -> GenresDto? {
        do {
            return try JSONDecoder().decode(GenresDto.self, from: data)
        }
        catch {
            let nserror = error as NSError
            ErrorHandler.shared.consoleLogError(nserror)
            return nil
        }
    }
}


// Shortcut to a Genre representing My list
extension Genre {
    static var myList = Genre(id: nil, name: "My list")
}
