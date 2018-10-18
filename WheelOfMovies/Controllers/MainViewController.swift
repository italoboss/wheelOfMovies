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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rouletteCollectionView.delegate = self
        rouletteCollectionView.dataSource = self
        
        TmdbService().discoverMovies(by: [18]) { movies in
            if let movies = movies {
                print(movies.count)
                self.moviesToDraw = movies
                self.rouletteCollectionView.collectionViewLayout.reloadPositioning()
                self.rouletteCollectionView.reloadData()
            }
        }
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = 10000 * moviesToDraw.count
        return total > 0 ? total : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        
        // let index = indexPath.row % (MY_ARRAY).count
        return cell
    }
    
}
