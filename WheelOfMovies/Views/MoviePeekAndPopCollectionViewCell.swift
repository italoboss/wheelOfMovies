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
    weak var viewController: UIViewController?
    
    override func awakeFromNib() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoviePeekAndPopCollectionViewCell.handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let movie = movie, let detailVC = getMovieDetailViewController(with: movie) {
            self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func getMovieDetailViewController(with movie: Movie) -> MovieDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController else { return nil }
        detailVC.movie = movie
        if let delegate = viewController as? MovieDetailViewControllerDelegate {
            detailVC.delegate = delegate
        }
        return detailVC
    }
    
}


// MARK: - Controller Previewing Delegate

extension MoviePeekAndPopCollectionViewCell: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let movie = movie, let detailVC = getMovieDetailViewController(with: movie) {
            return detailVC
        }
        else {
            return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
}
