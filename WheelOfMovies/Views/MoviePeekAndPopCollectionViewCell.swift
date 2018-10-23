//
//  MoviePeekAndPopBehavior.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 23/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class MoviePeekAndPopCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    weak var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoviePeekAndPopCollectionViewCell.handleTap(_:))))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoviePeekAndPopCollectionViewCell.handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let movie = movie, let detailVC = getMovieDetail() {
            detailVC.movie = movie
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}


// MARK: - Controller Previewing Delegate

extension MoviePeekAndPopCollectionViewCell: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let movie = movie, let detailVC = getMovieDetail() {
            detailVC.movie = movie
            return detailVC
        }
        else {
            return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
    private func getMovieDetail() -> MovieDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController else { return nil }
        return detailVC
    }
    
}
