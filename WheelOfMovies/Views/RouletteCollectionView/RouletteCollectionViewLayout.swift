//
//  RouletteCollectionViewLayour.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class RouletteCollectionViewLayout: UICollectionViewLayout {

    let itemSize = CGSize(width: 170, height: 255)
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0
            ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem
            : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }

    var radius: CGFloat = 600 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    var attributesList = [RouletteCollectionViewLayoutAttributes]()
    
    var isInitialing = true
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width, height: collectionView!.bounds.height)
    }
    
    override func prepare() {
        super.prepare()
        
        if isInitialing {
            isInitialing = false
            let middle: CGFloat = CGFloat( (collectionView!.numberOfItems(inSection: 0)/2) )
            let factor = -angleAtExtreme/(collectionViewContentSize.width - collectionView!.bounds.width)
            collectionView!.contentOffset.x = middle * anglePerItem / factor
        }
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width/2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        let theta = atan2(collectionView!.bounds.width / 2.0, radius + (itemSize.height / 2.0) - (collectionView!.bounds.height / 2.0))

        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1

        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))

        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        
        attributesList = (startIndex...endIndex).map { (i) -> RouletteCollectionViewLayoutAttributes in
            
            let attributes = RouletteCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.midY)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItem: \(attributesList.count)")
        return attributesList[indexPath.row % attributesList.count]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var finalContentOffset = proposedContentOffset
        
        let factor = -angleAtExtreme/(collectionViewContentSize.width - collectionView!.bounds.width)
        
        let proposedAngle = proposedContentOffset.x * factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        finalContentOffset.x = multiplier * anglePerItem / factor
        return finalContentOffset
    }
    
}


extension UICollectionViewLayout {
    
    func reloadPositioning() {
        if let this = self as? RouletteCollectionViewLayout {
            this.isInitialing = true
        }
    }
    
}
