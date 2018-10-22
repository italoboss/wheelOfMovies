//
//  RouletteCollectionViewLayoutAttributes.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class RouletteCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            if angle == 0.0 || angle.significandWidth < 25 {
                zIndex = Int(1000000)
                size = CGSize(width: 180, height: 270)
                center = CGPoint(x: center.x, y: center.y - 10)
            }
            else {
                zIndex = Int(angle * 1000)
            }
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes = super.copy(with: zone) as! RouletteCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
    
}
