//
//  ArrayExtension.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 17/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

extension Array {
    
    func join(with separator: String) -> String {
        let stringArray = self.map { String(describing: $0) }
        return stringArray.joined(separator: separator)
    }
    
}
