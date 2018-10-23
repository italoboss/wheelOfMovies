//
//  RouletteCollectionViewCell.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 18/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class RouletteCollectionViewCell: MoviePeekAndPopCollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let layoutAtt = layoutAttributes as? RouletteCollectionViewLayoutAttributes else { return }
        self.layer.anchorPoint = layoutAtt.anchorPoint
        self.center.y += (layoutAtt.anchorPoint.y - 0.5) * self.bounds.height
    }
    
    func update(movie: Movie) {
        self.movie = movie
        posterImageView.image = movie.posterImage != nil ? movie.posterImage : UIImage(named: "no-image")
    }
    
}
