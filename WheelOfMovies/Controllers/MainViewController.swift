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
    @IBOutlet weak var pickGenreButton: UIButton!
    
    var moviesToDraw = [Movie]()
    var selectedGenre: Genre?
    
    let service = TmdbService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRoulette()
        setupFields()
    }
    
    @IBAction func didTapPickAGenre(_ sender: Any) {
        performSegue(withIdentifier: "PickAGenre", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickAGenre", let pickGenreVC = segue.destination as? GenrePickerViewController {
            pickGenreVC.delegate = self
        }
    }
    
    func loadMoviesFromGenre() {
        if let genre = selectedGenre, let genreId = genre.id {
            pickGenreButton.setTitle(genre.name, for: .normal)
            
            rouletteCollectionView.isHidden = false
            service.discoverMovies(by: [genreId]) { movies in
                if let movies = movies {
                    print(movies.count)
                    self.moviesToDraw = movies
                    self.rouletteCollectionView.collectionViewLayout.reloadPositioning()
                    self.rouletteCollectionView.reloadData()
                }
            }
        }
        else {
            rouletteCollectionView.isHidden = true
        }
    }
    
}


// MARK: - Setup functions
extension MainViewController {
    
    private func setupRoulette() {
        rouletteCollectionView.delegate = self
        rouletteCollectionView.dataSource = self
        rouletteCollectionView.register(UINib(nibName: "RouletteCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "posterCell")
    }
    
    private func setupFields() {
        
        pickGenreButton.backgroundColor = ColorPalette.primary.color
        pickGenreButton.tintColor = ColorPalette.light.color
        pickGenreButton.layer.cornerRadius = 20.0
        pickGenreButton.layer.masksToBounds = true
        
    }
    
}


// MARK: - CollectionView Delegate and Data Source functions
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = 10000 * moviesToDraw.count
        return total > 0 ? total : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        if let posterCell = cell as? RouletteCollectionViewCell {
            posterCell.posterImageView.image = UIImage(named: "no-image")
            if moviesToDraw.count > 0 {
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
    
}


// MARK: - Pick Genre Delegate functions
extension MainViewController: GenrePickerViewControllerDelegate {
    
    func didSelect(genre: Genre) {
        selectedGenre = genre
        loadMoviesFromGenre()
    }
    
    func didAlreadySelected() -> Genre? {
        return selectedGenre
    }
    
}
