//
//  PickGenreViewControllerDelegate.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 19/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import Foundation

protocol GenrePickerViewControllerDelegate {
    
    func didSelect(genre: Genre) -> Void
    func didAlreadySelected() -> Genre?
    
}
