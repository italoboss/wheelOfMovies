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

    var selectedGenre: Genre?
    var moviesToDraw = [Movie]()
    let service = TmdbService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "RouletteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isUserInteractionEnabled = false
    }
    
    func loadMovies(from genre: Genre) {
        selectedGenre = genre
        if let genreId = genre.id {
            service.discoverMovies(by: [genreId], sorting: SortBy.random().value) { movies in
                self.setToRoulette(movies: movies)
            }
        }
        else if genre == Genre.myList, let movies = MovieDao.shared.getAll(in: false) {
            setToRoulette(movies: movies.count > 0 ? movies : nil)
        }
        else {
            setToRoulette(movies: nil)
        }
    }
    
    private func setToRoulette(movies: [Movie]?) {
        if let movies = movies {
            self.moviesToDraw = movies
            self.collectionView.isUserInteractionEnabled = true
        }
        else {
            self.moviesToDraw = []
            self.collectionView.isUserInteractionEnabled = false
            
        }
        reloadData()
    }
    
    private func reloadData() {
        self.collectionView.collectionViewLayout.reloadPositioning()
        self.collectionView.reloadData()
    }
    
}


// MARK: UICollectionViewDataSource

extension RouletteCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesToDraw.count > 0 ? 1000 * moviesToDraw.count : 5
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
                posterCell.viewController = self
                registerForPreviewing(with: posterCell, sourceView: posterCell)
            }
            else {
                posterCell.posterImageView.image = nil
            }
            return posterCell
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


// MARK: - Movie Detail Delegate
extension RouletteCollectionViewController: MovieDetailViewControllerDelegate {
    
    func didUnlike(movie: Movie) {
        if let genre = selectedGenre, genre == Genre.myList, let index = moviesToDraw.firstIndex(where: { (iterateMovie) -> Bool in movie.id == iterateMovie.id }) {
            moviesToDraw.remove(at: index)
            reloadData()
        }
    }
    
}
