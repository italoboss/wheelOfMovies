//
//  SortBy.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 23/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

enum SortBy: Int, CaseIterable {
    case popularityAsc
    case popularityDesc
    case releaseDateAsc
    case releaseDateDesc
    case revenueAsc
    case revenueDesc
    case primaryReleaseDateAsc
    case primaryReleaseDateDesc
    case voteAverageAsc
    case voteAverageDesc
    case voteCountAsc
    case voteCountDesc
}

extension SortBy {
    
    var value: String {
        switch self {
        case .popularityAsc: return "popularity.asc"
        case .popularityDesc: return "popularity.desc"
        case .releaseDateAsc: return "release_date.asc"
        case .releaseDateDesc: return "release_date.desc"
        case .revenueAsc: return "revenue.asc"
        case .revenueDesc: return "revenue.desc"
        case .primaryReleaseDateAsc: return "primary_release_date.asc"
        case .primaryReleaseDateDesc: return "primary_release_date.desc"
        case .voteAverageAsc: return "vote_average.asc"
        case .voteAverageDesc: return "vote_average.desc"
        case .voteCountAsc: return "vote_count.asc"
        case .voteCountDesc: return "vote_count.desc"
        }
    }
    
    static func random() -> SortBy {
        let count = SortBy.allCases.count
        let number = Int.random(in: 0 ..< count)
        return SortBy(rawValue: number)!
    }
    
}
