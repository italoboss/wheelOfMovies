//
//  Roulette.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

// - Main Business Rules class
class Roulette {
    
    var discover: DiscoverDto?
    var selectedGenre: Genre?
    
    
    
}


extension Roulette: GenrePickerViewControllerDelegate {
    
    func didSelect(genre: Genre) {
        selectedGenre = genre
    }
    
    func didAlreadySelected() -> Genre? {
        return selectedGenre
    }
    
}
