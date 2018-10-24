//
//  FavoritesCollectionViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 22/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteCell"

class FavoritesCollectionViewController: UICollectionViewController {

    var favoriteList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        loadMovies()
    }
    
    private func loadMovies() {
        if let localMovies = MovieDao.shared.getAll() {
            favoriteList = localMovies
            collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let favoriteCell = cell as? FavoriteCollectionViewCell {
            favoriteCell.viewController = self
            favoriteCell.update(movie: favoriteList[indexPath.row])
            registerForPreviewing(with: favoriteCell, sourceView: favoriteCell)
            return favoriteCell
        }
        return cell
    }

}


// MARK: - Movie Detail Delegate
extension FavoritesCollectionViewController: MovieDetailViewControllerDelegate {
    
    func didUnlike(movie: Movie) {
        print("Movie Unliked!")
        if let index = favoriteList.firstIndex(where: { (iterateMovie) -> Bool in movie.id == iterateMovie.id }) {
            print(" - at \(index)")
            favoriteList.remove(at: index)
            collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
}
