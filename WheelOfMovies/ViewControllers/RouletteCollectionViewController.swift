//
//  RouletteCollectionViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 21/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

private let reuseIdentifier = "posterCell"

class RouletteCollectionViewController: UICollectionViewController {

    var moviesToDraw = [Movie]()
    let service = TmdbService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "RouletteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isUserInteractionEnabled = false
    }
    
    func loadMovies(from genre: Genre) {
        if let genreId = genre.id {
            collectionView.isHidden = false
            service.discoverMovies(by: [genreId], sorting: SortBy.random().value) { movies in
                if let movies = movies {
                    self.collectionView.isUserInteractionEnabled = true
                    self.moviesToDraw = movies
                    self.collectionView.collectionViewLayout.reloadPositioning()
                    self.collectionView.reloadData()
                }
            }
        }
        else {
            self.moviesToDraw = []
            self.collectionView.collectionViewLayout.reloadPositioning()
            self.collectionView.reloadData()
            collectionView.isUserInteractionEnabled = false
        }
    }
    
}


// MARK: UICollectionViewDataSource

extension RouletteCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = 1000 * moviesToDraw.count
        return total > 0 ? total : 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        if let posterCell = cell as? RouletteCollectionViewCell {
            if moviesToDraw.count > 0 {
                let index = indexPath.row % moviesToDraw.count
                let movie = moviesToDraw[index]
                posterCell.update(movie: movie)
                
                if movie.posterImage == nil, let posterPath = movie.posterPath {
                    service.downloadImage(from: posterPath) { (image) in
                        self.moviesToDraw[index].posterImage = image
                        posterCell.update(movie: self.moviesToDraw[index])
                    }
                }
                posterCell.navigationController = self.navigationController
                registerForPreviewing(with: posterCell, sourceView: posterCell)
            }
            return posterCell
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
