//
//  Roulette.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

// - Main Business Rules class
// TODO - Ainda precisa ser visto como deve ser utilizada,
//        por enquanto não está sendo instanciada em nenhuma parte.
class Roulette {
    
    var discover: DiscoverDto?
    var selectedGenre: Genre?
    var moviesToDraw = [Movie]()
    
    let service = TmdbService()
    
    func didPick(genre: Genre) {
        selectedGenre = genre
    }
    
    func loadMovies(from genre: Genre, to rouletteCollectionView: UICollectionView) {
        
        if let genre = selectedGenre, let genreId = genre.id {
            rouletteCollectionView.isHidden = false
            service.discoverMovies(by: [genreId]) { movies in
                if let movies = movies {
                    print(movies.count)
                    self.moviesToDraw = movies
                    rouletteCollectionView.collectionViewLayout.reloadPositioning()
                    rouletteCollectionView.reloadData()
                }
            }
        }
        else {
            rouletteCollectionView.isHidden = true
        }
        
    }
    
}
