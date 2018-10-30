//
//  NotificationService.swift
//  MovieNotificationService
//
//  Created by Italo Boss on 24/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        print(" RECEIVE PUSH NOTIFICATION ")
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent,
            let apsData = bestAttemptContent.userInfo["aps"] as? [String: Any],
            let attachmentURL = apsData["attachment-url"] as? String {
            
            downloadImageFrom(path: attachmentURL) { (attachment) in
                if let attachment = attachment {
                    bestAttemptContent.attachments = [attachment]
                }
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}


extension NotificationService {
    
    private func downloadImageFrom(path: String, with completionHandler: @escaping (UNNotificationAttachment?) -> Void) {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500/")!
        let url = baseUrl.appendingPathComponent(path)
        let task = URLSession.shared.downloadTask(with: url) { (downloaded, response, error) in
            
            guard let downloadedUrl = downloaded else {
                completionHandler(nil)
                return
            }
            
            var urlPath = FileManager.default.temporaryDirectory
            
            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".jpg"
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
            
            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "moviePicture", url: urlPath, options: nil)
                completionHandler(attachment)
            }
            catch {
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    
}
