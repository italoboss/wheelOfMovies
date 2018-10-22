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
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movie: Movie?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie.title
            titleLabel.textColor = ColorPalette.primary.color
            posterImageView.image = movie.posterImage
            overviewTextView.text = movie.overview
            
            //scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let colors = [UIColor.black, UIColor.clear]
        self.navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

}
