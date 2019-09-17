//
//  AppDelegate.swift
//  Bar Down
//
//  Created by Alex King on 8/11/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import UIKit
import CoreData
import Combine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var cancellable: AnyCancellable?
    var cancellable2: AnyCancellable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        cancellable = NetworkManager.shared.publisher(for: CurrentSeasonRequest()).compactMap { $0.seasons.first }.sink(receiveCompletion: { _ in }) { season in
            print(season)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Locale.current.calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let seasonBeginDate = dateFormatter.date(from: "2019-10-02") ?? Date()
        cancellable2 = NetworkManager.shared.publisher(for: ScheduleRequest(date: seasonBeginDate)).sink(receiveCompletion: { _ in }) { schedule in
            print(schedule)
            let rfcDateFormatter = ISO8601DateFormatter()
            rfcDateFormatter.formatOptions = .withInternetDateTime
            rfcDateFormatter.timeZone = Locale.current.calendar.timeZone
            schedule.dates.flatMap { $0.games }.compactMap { $0.date }.forEach { print(rfcDateFormatter.string(from: $0)) }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Bar_Down")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

