//
//  FavoriteCollectionViewCell.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 22/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: MoviePeekAndPopCollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.title
        posterImageView.image = movie.posterImage
    }

}
