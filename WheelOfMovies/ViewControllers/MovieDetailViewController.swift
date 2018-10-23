//
//  MovieDetailViewController.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 21/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var movieContentVIew: UIView!
    
    var movie: Movie?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieContentVIew.layer.cornerRadius = 10.0
        movieContentVIew.clipsToBounds = true
        
        updateMovieInfo()
    }
    
    func updateMovieInfo() {
        if let movie = movie {
            titleLabel.text = movie.title
            titleLabel.textColor = ColorPalette.primary.color
            posterImageView.image = movie.posterImage != nil ? movie.posterImage : UIImage(named: "placeholder-poster")
            
            voteAverageLabel.text = "☆  \(movie.voteAverage)"
            releaseDateLabel.text = movie.releaseDate
            overviewTextView.text = movie.overview
            
            let icon = UIImage(named: movie.isSaved ? "liked" : "unliked")
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(MovieDetailViewController.handleRightBarButtonItem))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let colors = [UIColor.black, UIColor.clear]
        self.navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    @objc func handleRightBarButtonItem() {
        print("Tap right bar button")
        guard let movie = movie else { return }
        movie.isSaved ? deleteLocally() : saveLocally()
    }
    
    private func saveLocally() {
        guard let movie = movie else { return }
        if movie.saveLocal() {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "liked")
        }
    }
    
    private func deleteLocally() {
        guard let movie = movie else { return }
        if movie.deleteLocal() {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "unliked")
        }
    }

}
