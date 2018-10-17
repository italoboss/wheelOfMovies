//
//  Endpoint.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

struct Endpoint {
    var scheme: String
    var host: String
    var path: String
    var queryItems: [URLQueryItem]
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents(string: "\(scheme)://\(host)/\(path)")
        components?.queryItems = queryItems
        
        return components?.url
    }
    
}
