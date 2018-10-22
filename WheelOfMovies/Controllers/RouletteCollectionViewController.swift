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

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "RouletteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        registerForPreviewing(with: self, sourceView: collectionView)
        
        collectionView.isUserInteractionEnabled = false
    }
    
    func loadMovies(from genre: Genre) {
        if let genreId = genre.id {
            collectionView.isHidden = false
            service.discoverMovies(by: [genreId]) { movies in
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
        let total = 10000 * moviesToDraw.count
        return total > 0 ? total : 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        if let posterCell = cell as? RouletteCollectionViewCell {
            if moviesToDraw.count > 0 {
                posterCell.posterImageView.image = UIImage(named: "no-image")
                let index = indexPath.row % moviesToDraw.count
                let movie = moviesToDraw[index]
                
                if let poster = movie.posterImage {
                    posterCell.posterImageView.image = poster
                }
                else if let posterPath = movie.posterPath {
                    service.downloadImage(from: posterPath) { (image) in
                        self.moviesToDraw[index].posterImage = image
                        if let image = image {
                            posterCell.posterImageView.image = image
                        }
                    }
                }
                
            }
            return posterCell
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
}


// MARK: - Controller Previewing Delegate

extension RouletteCollectionViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        if moviesToDraw.count > 0,
            let detailVC = getMovieDetail(),
            let indexPath = collectionView.indexPathForItem(at: location) {
            
            let index = (indexPath.row) % moviesToDraw.count
            let movie = moviesToDraw[index]
            detailVC.movie = movie
            return detailVC
        }
        else {
            return nil
        }
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
    private func getMovieDetail() -> MovieDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController else { return nil }
        
        return detailVC
    }
    
}

