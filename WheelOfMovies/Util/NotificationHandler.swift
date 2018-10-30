//
//  NotificationHandler.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 24/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationHandler()
    let service = TmdbService()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == NotificationAction.addToFavorites.rawValue {
            print("Adding to favorites!")
            
            if let info = response.notification.request.content.userInfo["aps"] as? [String: Any],
                let idStr = info["movie-id"] as? String, let id = Int(idStr) {
                print(id)
                
                service.findMovie(by: id) { (movie) in
                    if var movie = movie {
                        if let posterPath = movie.posterPath {
                            self.service.downloadImage(from: posterPath, completion: { (image) in
                                movie.posterImage = image
                                self.saveLocally(movie: movie)
                            })
                        }
                        else {
                            self.saveLocally(movie: movie)
                        }
                    }
                }
                
            }
        }
        completionHandler()
    }
    
    private func saveLocally(movie: Movie) {
        if !movie.saveLocal() {
            // ErrorHandler.shared.alertErrorMessage()
        }
    }
    
}


enum NotificationCategory: String {
    case releasedMovie
}

enum NotificationAction: String {
    case addToFavorites
}

extension NotificationAction {
    var title: String {
        switch self {
        case .addToFavorites: return "Add to My list"
        }
    }
}
