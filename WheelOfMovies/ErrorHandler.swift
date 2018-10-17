//
//  ErrorHandler.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit

class ErrorHandler {
    
    static let shared = ErrorHandler()
    
    func consoleLogError(_ error: NSError) {
        print("Unresolved error \(error), \(error.userInfo)")
    }
    
    func alertErrorMessage(_ error: NSError) {
        // implement alert
    }

}
