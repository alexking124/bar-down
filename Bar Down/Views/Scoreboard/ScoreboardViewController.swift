//
//  ScoreboardViewController.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import CoreData

class ScoreboardViewController: UIHostingController<ContentView> {
    
    let date: Date
    
    var cancellable2: Cancellable?
    let backgroundQueue = DispatchQueue.global(qos: .utility)

    init(date: Date = Date()) {
        self.date = date
        super.init(rootView: ContentView())
        title = DateFormatter(format: .displayDate).string(from: date)
    }
    
    @available(*, unavailable)
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cancellable2 = NetworkManager.shared.publisher(for: ScheduleRequest(date: date))
            .receive(on: backgroundQueue)
            .sink(receiveCompletion: { _ in }) { schedule in
                print(schedule)
                let rfcDateFormatter = ISO8601DateFormatter()
                rfcDateFormatter.formatOptions = .withInternetDateTime
                rfcDateFormatter.timeZone = Locale.current.calendar.timeZone
//                schedule.dates.flatMap { $0.games }.compactMap { $0.date }.forEach { print(rfcDateFormatter.string(from: $0)) }
                
                PersistenceManager.shared.persistOnBackground { objectContext in
                    schedule.dates
                        .flatMap { $0.games }
                        .forEach { gameData in
                            let fetchPredicate = NSPredicate(format: "%K = %@", "gameID", "\(gameData.gamePk)")
                            guard let game = try? objectContext.existingObjectOrNew(predicate: fetchPredicate) as Game else {
                                return
                            }
                            game.gameID = Int32(gameData.gamePk)
                            game.gameTime = gameData.date
                        }
                }
            }
    }
    
}
