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
    let backgroundQueue = DispatchQueue.global(qos: .utility)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        cancellable = NetworkManager.shared.publisher(for: CurrentSeasonRequest())
//            .receive(on: backgroundQueue)
//            .compactMap { $0.seasons.first }
//            .sink(receiveCompletion: { _ in }) { season in
//                print(season)
//            }
        
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

}

