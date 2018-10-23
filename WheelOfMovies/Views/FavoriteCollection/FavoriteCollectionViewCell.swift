//
//  FavoriteCollectionViewCell.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 22/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        self.bounds.size = CGSize(width: 130, height: 170)
//        clipsToBounds = true
//    }
    
    func update(movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.title
        posterImageView.image = movie.posterImage
    }

}
