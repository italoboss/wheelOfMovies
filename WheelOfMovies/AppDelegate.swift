//
//  AppDelegate.swift
//  WheelOfMovies
//
//  Created by Italo Boss on 16/10/18.
//  Copyright © 2018 Italo Boss. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applyColorPalette()
        createImageDirectory()
        requestNotifications()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        let _ = CoreDataManager.shared.saveContext()
    }
    
    func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if granted {
                UNUserNotificationCenter.current().delegate = NotificationHandler.shared
                self.registerNotificationCategory()
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func registerNotificationCategory() {
        let addToFavorites = UNNotificationAction(identifier: NotificationAction.addToFavorites.rawValue, title: NotificationAction.addToFavorites.title, options: [])
        let category = UNNotificationCategory(identifier: NotificationCategory.releasedMovie.rawValue, actions: [addToFavorites], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }

    private func applyColorPalette() {
        UINavigationBar.appearance().barTintColor = ColorPalette.dark.color
        UINavigationBar.appearance().tintColor = ColorPalette.light.color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.primary.color]
    }
    
    private func createImageDirectory() {
        do {
            let path = AppConfig.LOCAL_IMAGES_PATH
            var isDirectory = ObjCBool(true)
            if !FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            }
        }
        catch {
            let nserror = error as NSError
            ErrorHandler.shared.consoleLogError(nserror)
        }
    }

}
