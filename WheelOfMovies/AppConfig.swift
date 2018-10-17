//
//  AppConfig.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

class AppConfig {
    
    // https://api.themoviedb.org/3/
    private static let API_KEY = "a0e34270a65934a3427eecbed2d917eb"
    static var BASE_API_ENDPOINT: Endpoint {
        // Adding API KEY in Query
        let apiKeyItem = URLQueryItem(name: "api_key", value: AppConfig.API_KEY)
        // Some Query Params for default
        let noAdultItem = URLQueryItem(name: "include_adult", value: "false")
        let noVideoItem = URLQueryItem(name: "include_video", value: "false")
        return Endpoint(scheme: "https", host: "api.themoviedb.org/3", path: "", queryItems: [apiKeyItem, noAdultItem, noVideoItem])
    }
    
    static let BASE_IMG_URL = URL(string: "https://image.tmdb.org/t/p/w500/")!
    
}
