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
        
        if let attributes = layoutAttributes as? RouletteCollectionViewLayoutAttributes {
            toggleShadow(attributes.isInMiddle)
        }
        
    }
    
    func update(movie: Movie) {
        self.movie = movie
        posterImageView.image = movie.posterImage != nil ? movie.posterImage : UIImage(named: "no-image")
    }
    
    func toggleShadow(_ visible: Bool) {
        if visible {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width:0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.5
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        }
        else {
            self.layer.shadowColor = nil
            self.layer.shadowOffset = CGSize(width:0, height: 0.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.0
            self.layer.masksToBounds = true
        }
    }
    
}
