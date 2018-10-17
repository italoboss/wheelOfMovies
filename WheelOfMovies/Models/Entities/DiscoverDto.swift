//
//  DiscoverDto.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

struct DiscoverDto: Codable {
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    static func decode(from data: Data) -> DiscoverDto? {
        do {
            let decoded = try JSONDecoder().decode(DiscoverDto.self, from: data)
            return decoded
        }
        catch {
            let nserror = error as NSError
            ErrorHandler.shared.consoleLogError(nserror)
            return nil
        }
    }
    
}
