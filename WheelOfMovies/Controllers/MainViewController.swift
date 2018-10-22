//
//  ViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var pickGenreButton: UIButton!
    
    var selectedGenre: Genre?
    var roulette: RouletteCollectionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupFields()
    }
    
    @IBAction func didTapPickAGenre(_ sender: Any) {
        performSegue(withIdentifier: "PickAGenre", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRoulette", let rouletteVC = segue.destination as? RouletteCollectionViewController {
            roulette = rouletteVC
        }
        else if segue.identifier == "PickAGenre", let pickGenreVC = segue.destination as? GenrePickerViewController {
            pickGenreVC.delegate = self
        }
    }
    
    func loadMoviesFromGenre() {
        if let genre = selectedGenre {
            pickGenreButton.setTitle(genre.name, for: .normal)
            roulette?.loadMovies(from: genre)
        }
    }
    
}


// MARK: - Setup functions
extension MainViewController {
    
    private func setupFields() {
        pickGenreButton.backgroundColor = ColorPalette.primary.color
        pickGenreButton.tintColor = ColorPalette.light.color
        pickGenreButton.layer.cornerRadius = 20.0
        pickGenreButton.layer.masksToBounds = true
    }
    
}


// MARK: - Pick Genre Delegate functions
extension MainViewController: GenrePickerViewControllerDelegate {
    
    func didSelect(genre: Genre) {
        if selectedGenre != genre {
            selectedGenre = genre
            loadMoviesFromGenre()
        }
    }
    
    func didAlreadySelected() -> Genre? {
        return selectedGenre
    }
    
}
