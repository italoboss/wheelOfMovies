//
//  AppConfig.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

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

enum ColorPalette {
    case primary
    case secondary
    case dark
    case light
    case grayBg
}

extension ColorPalette {
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor(red: 5/255, green: 204/255, blue: 113/255, alpha: 1)
        case .secondary:
            return UIColor(red: 15/255, green: 112/255, blue: 76/255, alpha: 1)
        case .dark:
            return UIColor(red: 12/255, green: 28/255, blue: 36/255, alpha: 1)
        case .light:
            return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        case .grayBg:
            return UIColor(red: 208/255, green: 211/255, blue: 212/255, alpha: 1)
        }
    }
}
