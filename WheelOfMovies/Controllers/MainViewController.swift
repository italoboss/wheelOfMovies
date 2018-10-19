//
//  ViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var rouletteCollectionView: UICollectionView!
    
    var moviesToDraw = [Movie]()
    
    let service = TmdbService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRoulette()
        
        service.discoverMovies(by: [18]) { movies in
            if let movies = movies {
                print(movies.count)
                self.moviesToDraw = movies
                self.rouletteCollectionView.collectionViewLayout.reloadPositioning()
                self.rouletteCollectionView.reloadData()
            }
        }
    }
    
    private func setupRoulette() {
        rouletteCollectionView.delegate = self
        rouletteCollectionView.dataSource = self
        rouletteCollectionView.register(UINib(nibName: "RouletteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "posterCell")
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = 10000 * moviesToDraw.count
        return total > 0 ? total : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        if let posterCell = cell as? RouletteCollectionViewCell {
            if moviesToDraw.count > 0 {
                let index = indexPath.row % moviesToDraw.count
                let movie = moviesToDraw[index]
                
                service.downloadImage(from: movie.posterPath) { (image) in
                    print("Downloaded image of \(movie.title)")
                    if let image = image {
                        posterCell.posterImageView.image = image
                    }
                    else {
                        posterCell.posterImageView.image = UIImage(named: "no-image")
                    }
                }
            }
            return posterCell
        }
        return cell
    }
    
}
